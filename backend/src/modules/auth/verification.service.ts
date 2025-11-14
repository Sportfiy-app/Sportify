import crypto from 'crypto';

import createHttpError from 'http-errors';
import twilio from 'twilio';

import { prisma } from '../../db/prisma';
import { EmailService } from '../../services/email.service';

export class VerificationService {
  private twilioClient: twilio.Twilio | null = null;
  private verifyServiceSid: string | null = null;
  private emailService: EmailService;

  constructor() {
    // Initialize Twilio client if credentials are provided
    const accountSid = process.env.TWILIO_ACCOUNT_SID;
    const authToken = process.env.TWILIO_AUTH_TOKEN;
    const verifyServiceSid = process.env.TWILIO_VERIFY_SERVICE_SID;
    
    if (accountSid && authToken) {
      this.twilioClient = twilio(accountSid, authToken);
      this.verifyServiceSid = verifyServiceSid || null;
      
      if (verifyServiceSid) {
        console.log('✅ Twilio Verify client initialized');
      } else {
        console.log('✅ Twilio client initialized (using Messages API)');
      }
    } else {
      console.log('⚠️  Twilio credentials not found. SMS will be logged in dev mode only.');
    }

    // Initialize email service
    this.emailService = new EmailService();
  }

  /**
   * Generate a 6-digit verification code
   */
  private generateCode(): string {
    return Math.floor(100000 + Math.random() * 900000).toString();
  }

  /**
   * Generate email verification token
   */
  private generateEmailToken(): string {
    return crypto.randomBytes(32).toString('hex');
  }

  /**
   * Send SMS verification code via Twilio Verify or Messages API
   */
  async sendSmsCode(phone: string, userId: string): Promise<{ expiresIn: number; code?: string }> {
    const code = this.generateCode();
    const expiresAt = new Date(Date.now() + 10 * 60 * 1000); // 10 minutes

    await prisma.user.update({
      where: { id: userId },
      data: {
        phoneVerificationCode: code,
        phoneVerificationExpires: expiresAt,
      },
    });

    const isDevelopment = process.env.NODE_ENV !== 'production';
    
    // Option 1: Use Twilio Verify (recommended - no phone number needed)
    if (this.twilioClient && this.verifyServiceSid) {
      try {
        await this.twilioClient.verify.v2
          .services(this.verifyServiceSid)
          .verifications.create({
            to: phone,
            channel: 'sms',
          });
        
        console.log(`✅ Verification code sent via Twilio Verify to ${phone}`);
        
        // In development, also return the code for testing
        if (isDevelopment) {
          return { expiresIn: 600, code };
        }
        
        return { expiresIn: 600 };
      } catch (error: any) {
        console.error('❌ Error sending verification via Twilio Verify:', error.message);
        
        // In development, fallback to returning code
        if (isDevelopment) {
          console.log(`\n📱 [DEV MODE - Twilio Verify Error] SMS verification code for ${phone}: ${code}\n`);
          return { expiresIn: 600, code };
        }
        
        // In production, throw error
        throw createHttpError(500, 'Failed to send verification code. Please try again later.');
      }
    }
    
    // Option 2: Use Twilio Messages API (requires phone number)
    const twilioPhoneNumber = process.env.TWILIO_PHONE_NUMBER;
    if (this.twilioClient && twilioPhoneNumber) {
      try {
        await this.twilioClient.messages.create({
          body: `Votre code de vérification Sportify: ${code}. Ce code expire dans 10 minutes.`,
          to: phone,
          from: twilioPhoneNumber,
        });
        
        console.log(`✅ SMS sent successfully to ${phone}`);
        
        // In development, also return the code for testing
        if (isDevelopment) {
          return { expiresIn: 600, code };
        }
        
        return { expiresIn: 600 };
      } catch (error: any) {
        console.error('❌ Error sending SMS via Twilio Messages:', error.message);
        
        // In development, fallback to returning code
        if (isDevelopment) {
          console.log(`\n📱 [DEV MODE - Twilio Messages Error] SMS verification code for ${phone}: ${code}\n`);
          return { expiresIn: 600, code };
        }
        
        // In production, throw error
        throw createHttpError(500, 'Failed to send SMS. Please try again later.');
      }
    }
    
    // Fallback: Development mode (no Twilio configured)
    console.log(`\n📱 [DEV MODE] SMS verification code for ${phone}: ${code}\n`);
    return { expiresIn: 600, code };
  }

  /**
   * Verify SMS code
   */
  async verifySmsCode(phone: string, code: string, userId: string): Promise<{ verified: boolean }> {
    // Option 1: Use Twilio Verify API (if configured)
    if (this.twilioClient && this.verifyServiceSid) {
      try {
        const verificationCheck = await this.twilioClient.verify.v2
          .services(this.verifyServiceSid)
          .verificationChecks.create({
            to: phone,
            code: code,
          });

        if (verificationCheck.status === 'approved') {
          // Mark phone as verified and clear code
          await prisma.user.update({
            where: { id: userId },
            data: {
              phoneVerified: true,
              phoneVerificationCode: null,
              phoneVerificationExpires: null,
            },
          });

          return { verified: true };
        } else {
          throw createHttpError(400, 'Invalid verification code.');
        }
      } catch (error: any) {
        // If Twilio Verify fails, fallback to database verification
        if (error.status === 404 || error.status === 400) {
          console.log('⚠️  Twilio Verify check failed, falling back to database verification');
        } else {
          console.error('❌ Error verifying code via Twilio Verify:', error.message);
          throw createHttpError(500, 'Failed to verify code. Please try again.');
        }
      }
    }

    // Option 2: Fallback to database verification (for Messages API or dev mode)
    const user = await prisma.user.findUnique({
      where: { id: userId },
      select: {
        phoneVerificationCode: true,
        phoneVerificationExpires: true,
      },
    });

    if (!user || !user.phoneVerificationCode || !user.phoneVerificationExpires) {
      throw createHttpError(400, 'No verification code found. Please request a new code.');
    }

    if (new Date() > user.phoneVerificationExpires) {
      throw createHttpError(400, 'Verification code has expired. Please request a new code.');
    }

    if (user.phoneVerificationCode !== code) {
      throw createHttpError(400, 'Invalid verification code.');
    }

    // Mark phone as verified and clear code
    await prisma.user.update({
      where: { id: userId },
      data: {
        phoneVerified: true,
        phoneVerificationCode: null,
        phoneVerificationExpires: null,
      },
    });

    return { verified: true };
  }

  /**
   * Send email verification
   */
  async sendEmailVerification(email: string, userId: string): Promise<{ token: string }> {
    const token = this.generateEmailToken();
    // expiresAt is stored in the database but not used here

    await prisma.user.update({
      where: { id: userId },
      data: {
        emailVerificationToken: token,
      },
    });

    // Send verification email
    try {
      await this.emailService.sendVerificationEmail(email, token);
    } catch (error: any) {
      console.error('Error sending verification email:', error.message);
      // In development, still return the token so the user can verify manually
      const isDevelopment = process.env.NODE_ENV !== 'production';
      if (isDevelopment) {
        console.log(`\n📧 [DEV MODE - Email Verification Token]`);
        console.log(`Email: ${email}`);
        console.log(`Token: ${token}`);
        console.log(`Verification URL: ${process.env.FRONTEND_URL || 'http://localhost:3000'}/verify-email?token=${token}\n`);
      } else {
        // In production, throw error if email service is configured but fails
        throw createHttpError(500, 'Failed to send verification email. Please try again later.');
      }
    }

    return { token };
  }

  /**
   * Verify email token
   */
  async verifyEmail(token: string): Promise<{ verified: boolean }> {
    const user = await prisma.user.findFirst({
      where: {
        emailVerificationToken: token,
      },
    });

    if (!user) {
      throw createHttpError(400, 'Invalid or expired verification token.');
    }

    // Mark email as verified and clear token
    await prisma.user.update({
      where: { id: user.id },
      data: {
        emailVerified: true,
        emailVerificationToken: null,
      },
    });

    return { verified: true };
  }
}


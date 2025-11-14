import nodemailer from 'nodemailer';
import type { Transporter } from 'nodemailer';

export class EmailService {
  private transporter: Transporter | null = null;

  constructor() {
    // Initialize email transporter if credentials are provided
    const smtpHost = process.env.SMTP_HOST;
    const smtpPort = process.env.SMTP_PORT;
    const smtpUser = process.env.SMTP_USER;
    const smtpPassword = process.env.SMTP_PASSWORD;
    // smtpFrom is available but not used in current implementation

    if (smtpHost && smtpPort && smtpUser && smtpPassword) {
      this.transporter = nodemailer.createTransport({
        host: smtpHost,
        port: parseInt(smtpPort, 10),
        secure: parseInt(smtpPort, 10) === 465, // true for 465, false for other ports
        auth: {
          user: smtpUser,
          pass: smtpPassword,
        },
      });

      // Verify connection
      this.transporter.verify((error) => {
        if (error) {
          console.error('❌ Email service configuration error:', error.message);
        } else {
          console.log('✅ Email service initialized');
        }
      });
    } else {
      console.log('⚠️  Email credentials not found. Emails will be logged in dev mode only.');
    }
  }

  /**
   * Send email verification
   */
  async sendVerificationEmail(email: string, token: string): Promise<void> {
    const verificationUrl = `${process.env.FRONTEND_URL || 'http://localhost:3000'}/verify-email?token=${token}`;
    
    const html = this.getVerificationEmailTemplate(email, verificationUrl, token);
    const text = this.getVerificationEmailText(email, verificationUrl, token);

    const mailOptions = {
      from: process.env.SMTP_FROM || 'Sportify <noreply@sportify.app>',
      to: email,
      subject: 'Vérifiez votre adresse email - Sportify',
      text,
      html,
    };

    if (this.transporter) {
      try {
        await this.transporter.sendMail(mailOptions);
        console.log(`✅ Verification email sent to ${email}`);
      } catch (error: any) {
        console.error('❌ Error sending verification email:', error.message);
        throw error;
      }
    } else {
      // Development mode: log the email
      const isDevelopment = process.env.NODE_ENV !== 'production';
      if (isDevelopment) {
        console.log('\n📧 [DEV MODE - Email Verification]');
        console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        console.log(`To: ${email}`);
        console.log(`Subject: ${mailOptions.subject}`);
        console.log(`Verification URL: ${verificationUrl}`);
        console.log(`Token: ${token}`);
        console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');
      } else {
        throw new Error('Email service not configured. Cannot send verification email.');
      }
    }
  }

  /**
   * Get HTML template for verification email
   */
  private getVerificationEmailTemplate(email: string, verificationUrl: string, _token: string): string {
    return `
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Vérifiez votre email - Sportify</title>
</head>
<body style="margin: 0; padding: 0; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif; background-color: #f5f5f5;">
  <table role="presentation" style="width: 100%; border-collapse: collapse; background-color: #f5f5f5;">
    <tr>
      <td align="center" style="padding: 40px 20px;">
        <table role="presentation" style="max-width: 600px; width: 100%; background-color: #ffffff; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.1);">
          <!-- Header -->
          <tr>
            <td style="padding: 40px 40px 20px; text-align: center; background: linear-gradient(135deg, #176BFF 0%, #0B5ED7 100%); border-radius: 12px 12px 0 0;">
              <h1 style="margin: 0; color: #ffffff; font-size: 28px; font-weight: 700; letter-spacing: -0.5px;">
                Sportify
              </h1>
            </td>
          </tr>
          
          <!-- Content -->
          <tr>
            <td style="padding: 40px;">
              <h2 style="margin: 0 0 20px; color: #0B1220; font-size: 24px; font-weight: 700;">
                Vérifiez votre adresse email
              </h2>
              
              <p style="margin: 0 0 20px; color: #475569; font-size: 16px; line-height: 1.6;">
                Bonjour,
              </p>
              
              <p style="margin: 0 0 30px; color: #475569; font-size: 16px; line-height: 1.6;">
                Merci de vous être inscrit sur Sportify ! Pour activer votre compte, veuillez vérifier votre adresse email en cliquant sur le bouton ci-dessous.
              </p>
              
              <!-- CTA Button -->
              <table role="presentation" style="width: 100%; margin: 30px 0;">
                <tr>
                  <td align="center">
                    <a href="${verificationUrl}" style="display: inline-block; padding: 16px 32px; background-color: #176BFF; color: #ffffff; text-decoration: none; border-radius: 8px; font-weight: 600; font-size: 16px;">
                      Vérifier mon email
                    </a>
                  </td>
                </tr>
              </table>
              
              <p style="margin: 30px 0 0; color: #64748B; font-size: 14px; line-height: 1.6;">
                Si le bouton ne fonctionne pas, copiez et collez ce lien dans votre navigateur :
              </p>
              <p style="margin: 10px 0 20px; color: #176BFF; font-size: 14px; word-break: break-all;">
                ${verificationUrl}
              </p>
              
              <p style="margin: 30px 0 0; color: #64748B; font-size: 14px; line-height: 1.6;">
                Ce lien est valable pendant 24 heures. Si vous n'avez pas créé de compte sur Sportify, vous pouvez ignorer cet email.
              </p>
            </td>
          </tr>
          
          <!-- Footer -->
          <tr>
            <td style="padding: 30px 40px; background-color: #F8FAFC; border-radius: 0 0 12px 12px; border-top: 1px solid #E2E8F0;">
              <p style="margin: 0 0 10px; color: #64748B; font-size: 12px; text-align: center;">
                © ${new Date().getFullYear()} Sportify. Tous droits réservés.
              </p>
              <p style="margin: 0; color: #94A3B8; font-size: 12px; text-align: center;">
                Cet email a été envoyé à ${email}
              </p>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</body>
</html>
    `.trim();
  }

  /**
   * Get plain text version of verification email
   */
  private getVerificationEmailText(email: string, verificationUrl: string, _token: string): string {
    return `
Bonjour,

Merci de vous être inscrit sur Sportify ! Pour activer votre compte, veuillez vérifier votre adresse email en cliquant sur le lien ci-dessous :

${verificationUrl}

Ce lien est valable pendant 24 heures. Si vous n'avez pas créé de compte sur Sportify, vous pouvez ignorer cet email.

© ${new Date().getFullYear()} Sportify. Tous droits réservés.
    `.trim();
  }
}


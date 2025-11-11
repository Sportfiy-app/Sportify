import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_routes.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordEmailSentView extends GetView<ForgotPasswordController> {
  const ForgotPasswordEmailSentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          const baseWidth = 375.0;
          const baseHeight = 812.0;
          final size = MediaQuery.of(context).size;
          final maxWidth =
              constraints.hasBoundedWidth ? constraints.maxWidth : size.width;
          final maxHeight =
              constraints.hasBoundedHeight
                  ? constraints.maxHeight
                  : size.height;
          final scale = math
              .min(maxWidth / baseWidth, maxHeight / baseHeight)
              .clamp(0.65, 1.2);
          return Container(
            color: const Color(0xFFF8FAFC),
            alignment: Alignment.center,
            child: SizedBox(
              width: baseWidth * scale,
              child: _EmailSentContent(scale: scale),
            ),
          );
        },
      ),
    );
  }
}

class _EmailSentContent extends StatelessWidget {
  const _EmailSentContent({required this.scale});

  final double scale;

  double s(double value) => value * scale;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgotPasswordController>();
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(s(24)),
      ),
      padding: EdgeInsets.all(s(24)),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Get.back<void>(),
                child: Container(
                  width: 48 * scale,
                  height: 48 * scale,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(12 * scale),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 18 * scale,
                    color: const Color(0xFF0B1220),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: Get.back,
                child: Container(
                  width: 40 * scale,
                  height: 40 * scale,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(9999),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.close_rounded,
                    size: 18 * scale,
                    color: const Color(0xFF475569),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: s(40)),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 240 * scale,
                height: 240 * scale,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0x33176BFF), Color(0x330F5AE0)],
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 160 * scale,
                height: 160 * scale,
                decoration: BoxDecoration(
                  color: const Color(0xFF176BFF),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 6 * scale),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x40176BFF),
                      blurRadius: 30 * scale,
                      offset: Offset(0, 20 * scale),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.mark_email_read_rounded,
                  color: Colors.white,
                  size: 64 * scale,
                ),
              ),
            ],
          ),
          SizedBox(height: s(32)),
          Text(
            'Vérifiez votre boîte mail',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 24 * scale,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0B1220),
            ),
          ),
          SizedBox(height: s(12)),
          Text(
            'Nous avons envoyé un lien de réinitialisation à :\n${controller.emailController.text.isEmpty ? 'votre.email@exemple.com' : controller.emailController.text}',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14 * scale,
              color: const Color(0xFF475569),
              height: 1.6,
            ),
          ),
          SizedBox(height: s(24)),
          Container(
            padding: EdgeInsets.all(20 * scale),
            decoration: BoxDecoration(
              color: const Color(0x0C0EA5E9),
              borderRadius: BorderRadius.circular(16 * scale),
              border: Border.all(color: const Color(0x330EA5E9)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: const Color(0xFF0EA5E9),
                      size: 18 * scale,
                    ),
                    SizedBox(width: 8 * scale),
                    Text(
                      'Astuce',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF0EA5E9),
                        fontWeight: FontWeight.w600,
                        fontSize: 14 * scale,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12 * scale),
                Text(
                  'Vérifiez également vos spams si l\'email n\'apparaît pas d\'ici quelques minutes.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF475569),
                    fontSize: 13 * scale,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: s(32)),
          GestureDetector(
            onTap: () {
              controller.currentStep.value = ForgotPasswordStep.email;
              Get.offAllNamed(Routes.loginEmail);
            },
            child: Container(
              height: 56 * scale,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
                ),
                borderRadius: BorderRadius.circular(12 * scale),
              ),
              alignment: Alignment.center,
              child: Text(
                'Fermer',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16 * scale,
                ),
              ),
            ),
          ),
          SizedBox(height: s(16)),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: controller.resendCode,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFE2E8F0), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12 * scale),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14 * scale),
                  ),
                  child: Text(
                    'Renvoyer',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF475569),
                      fontWeight: FontWeight.w500,
                      fontSize: 14 * scale,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16 * scale),
              Expanded(
                child: OutlinedButton(
                  onPressed: controller.contactSupport,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFFFB800), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12 * scale),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14 * scale),
                  ),
                  child: Text(
                    'Ouvrir email',
                    style: GoogleFonts.inter(
                      color: const Color(0xFFFFB800),
                      fontWeight: FontWeight.w600,
                      fontSize: 14 * scale,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              Text(
                'Vous n\'avez pas reçu l\'email ?',
                style: GoogleFonts.inter(
                  color: const Color(0xFF475569),
                  fontSize: 12 * scale,
                ),
              ),
              SizedBox(height: 4 * scale),
              GestureDetector(
                onTap: controller.contactSupport,
                child: Text(
                  'Contactez le support',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF176BFF),
                    fontSize: 12 * scale,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

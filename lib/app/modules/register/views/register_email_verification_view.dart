import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/register_controller.dart';

class RegisterEmailVerificationView extends GetView<RegisterController> {
  const RegisterEmailVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          const baseWidth = 375.0;
          final screenSize = MediaQuery.of(context).size;
          final maxWidth =
              constraints.hasBoundedWidth ? constraints.maxWidth : screenSize.width;
          final scale = (maxWidth / baseWidth).clamp(0.85, 1.1);

          return _EmailVerificationContent(scale: scale);
        },
      ),
    );
  }
}

class _EmailVerificationContent extends StatelessWidget {
  const _EmailVerificationContent({required this.scale});

  final double scale;

  double s(double value) => value * scale;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          _BackgroundLayer(scale: scale),
          Container(color: Colors.black.withValues(alpha: 0.45)),
          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: s(24), vertical: s(32)),
              child: _ModalCard(scale: scale),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackgroundLayer extends StatelessWidget {
  const _BackgroundLayer({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-0.35, 0.4),
          end: Alignment(0.5, 1.0),
          colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 24 * scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _TransparentButton(
                  scale: scale,
                  icon: Icons.arrow_back_ios_new_rounded,
                  onTap: Get.back,
                ),
                Expanded(
                  child: Text(
                    'Vérification',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18 * scale,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(width: 40 * scale),
              ],
            ),
            SizedBox(height: 20 * scale),
            _GradientStepIndicator(scale: scale),
            SizedBox(height: 32 * scale),
            _VerificationHero(scale: scale),
          ],
        ),
      ),
    );
  }
}

class _GradientStepIndicator extends StatelessWidget {
  const _GradientStepIndicator({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Étape 3 sur 4',
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 14 * scale,
              ),
            ),
            const Spacer(),
            Text(
              '75%',
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 14 * scale,
              ),
            ),
          ],
        ),
        SizedBox(height: 12 * scale),
        ClipRRect(
          borderRadius: BorderRadius.circular(9999),
          child: LinearProgressIndicator(
            value: 0.75,
            minHeight: 8 * scale,
            backgroundColor: Colors.white.withValues(alpha: 0.2),
            valueColor: const AlwaysStoppedAnimation(Color(0xFFFFB800)),
          ),
        ),
      ],
    );
  }
}

class _VerificationHero extends StatelessWidget {
  const _VerificationHero({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RegisterController>();
    return Column(
      children: [
        Container(
          width: 80 * scale,
          height: 80 * scale,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(9999),
            border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
          ),
          alignment: Alignment.center,
          child: Icon(Icons.sms, size: 36 * scale, color: Colors.white),
        ),
        SizedBox(height: 24 * scale),
        Text(
          'Code de vérification',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 24 * scale,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12 * scale),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Nous avons envoyé un code à 6 chiffres au ',
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 16 * scale,
                ),
              ),
              TextSpan(
                text: controller.phoneController.text.isNotEmpty
                    ? controller.phoneController.text
                    : '+33 6 12 34 56 78',
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.95),
                  fontSize: 16 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 32 * scale),
        Obx(() {
          final countdown = controller.resendSeconds.value;
          final isWaiting = countdown > 0;
          return TextButton(
            onPressed: isWaiting ? null : controller.resendSmsCode,
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFFFB800),
              padding: EdgeInsets.zero,
            ),
            child: Text(
              isWaiting
                  ? 'Renvoyer le code (${_formatTimer(countdown)})'
                  : 'Vous n\'avez pas reçu le code ? Renvoyer le code',
              style: GoogleFonts.inter(
                color: const Color(0xFFFFB800),
                fontSize: 14 * scale,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
              ),
              textAlign: TextAlign.center,
            ),
          );
        }),
        SizedBox(height: 16 * scale),
        TextButton(
          onPressed: controller.changeEmailAddress,
          style: TextButton.styleFrom(
            foregroundColor: Colors.white.withValues(alpha: 0.85),
          ),
          child: Text(
            'Utiliser un autre numéro',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 14 * scale,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  static String _formatTimer(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(1, '0')}:${secs.toString().padLeft(2, '0')}';
  }
}

class _ModalCard extends StatelessWidget {
  const _ModalCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RegisterController>();
    final email = controller.emailController.text.isNotEmpty
        ? controller.emailController.text
        : 'john.doe@gmail.com';

    return ClipRRect(
      borderRadius: BorderRadius.circular(24 * scale),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(24 * scale),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24 * scale),
            border: Border.all(color: const Color(0xFFE5E7EB)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 30 * scale,
                offset: Offset(0, 24 * scale),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: _LightButton(
                  scale: scale,
                  icon: Icons.close,
                  onTap: () => Get.back(),
                ),
              ),
              SizedBox(height: 12 * scale),
              Container(
                width: 84 * scale,
                height: 84 * scale,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment(0.35, 0.35),
                    end: Alignment(1.06, -0.35),
                    colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
                  ),
                  borderRadius: BorderRadius.circular(24 * scale),
                ),
                padding: EdgeInsets.all(3 * scale),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22 * scale),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.mark_email_unread_rounded,
                      size: 36 * scale, color: const Color(0xFF176BFF)),
                ),
              ),
              SizedBox(height: 24 * scale),
              Text(
                'Vérifiez votre boîte mail',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: const Color(0xFF0B1220),
                  fontSize: 24 * scale,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16 * scale),
              Text(
                'Un email de vérification vous a été envoyé à l\'adresse suivante :',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: const Color(0xFF475569),
                  fontSize: 16 * scale,
                  height: 1.55,
                ),
              ),
              SizedBox(height: 16 * scale),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16 * scale),
                decoration: BoxDecoration(
                  color: const Color(0x0C176BFF),
                  borderRadius: BorderRadius.circular(12 * scale),
                  border: Border.all(color: const Color(0x33176BFF)),
                ),
                child: Text(
                  email,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF176BFF),
                    fontSize: 16 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 24 * scale),
              _InstructionList(scale: scale),
              SizedBox(height: 24 * scale),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.continueAfterEmailVerification,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 20 * scale),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14 * scale),
                    ),
                    backgroundColor: const Color(0xFF176BFF),
                    elevation: 0,
                  ),
                  child: Text(
                    'Fermer',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 17 * scale,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16 * scale),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: controller.resendVerificationEmail,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFE2E8F0), width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14 * scale),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16 * scale),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.refresh, size: 18 * scale, color: const Color(0xFF475569)),
                          SizedBox(width: 8 * scale),
                          Text(
                            'Renvoyer',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF475569),
                              fontSize: 14 * scale,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 12 * scale),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: controller.changeEmailAddress,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF176BFF), width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12 * scale),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14 * scale),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.edit_outlined, size: 18 * scale, color: const Color(0xFF176BFF)),
                          SizedBox(width: 8 * scale),
                          Text(
                            'Modifier',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF176BFF),
                              fontSize: 14 * scale,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20 * scale),
              Column(
                children: [
                  Text(
                    'Besoin d\'aide ?',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF475569),
                      fontSize: 12 * scale,
                    ),
                  ),
                  SizedBox(height: 6 * scale),
                  GestureDetector(
                    onTap: () => Get.snackbar('Support', 'Contactez support@sportify.com'),
                    child: Text(
                      'Contacter le support',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF176BFF),
                        fontSize: 14 * scale,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InstructionList extends StatelessWidget {
  const _InstructionList({required this.scale});

  final double scale;

  final List<String> _instructions = const [
    'Vérifiez votre boîte de réception (et vos spams).',
    'Cliquez sur le lien de vérification dans l\'email.',
    'Le lien est valable 24 heures.',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        color: const Color(0x0C0EA5E9),
        borderRadius: BorderRadius.circular(12 * scale),
        border: Border.all(color: const Color(0x330EA5E9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _instructions
            .map(
              (text) => Padding(
                padding: EdgeInsets.only(bottom: 12 * scale),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 4 * scale),
                      width: 6 * scale,
                      height: 6 * scale,
                      decoration: const BoxDecoration(
                        color: Color(0xFF0EA5E9),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 12 * scale),
                    Expanded(
                      child: Text(
                        text,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF475569),
                          fontSize: 14 * scale,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _TransparentButton extends StatelessWidget {
  const _TransparentButton({required this.scale, required this.icon, required this.onTap});

  final double scale;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40 * scale,
        height: 40 * scale,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(9999),
          border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: Colors.white, size: 18 * scale),
      ),
    );
  }
}

class _LightButton extends StatelessWidget {
  const _LightButton({required this.scale, required this.icon, required this.onTap});

  final double scale;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40 * scale,
        height: 40 * scale,
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(9999),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: const Color(0xFF0B1220), size: 18 * scale),
      ),
    );
  }
}

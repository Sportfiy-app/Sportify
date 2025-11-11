import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordVerifyView extends GetView<ForgotPasswordController> {
  const ForgotPasswordVerifyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          const baseWidth = 375.0;
          const baseHeight = 2333.0;
          final size = MediaQuery.of(context).size;
          final maxWidth =
              constraints.hasBoundedWidth ? constraints.maxWidth : size.width;
          final maxHeight =
              constraints.hasBoundedHeight
                  ? constraints.maxHeight
                  : size.height;
          final scale = math
              .min(maxWidth / baseWidth, maxHeight / baseHeight)
              .clamp(0.55, 1.1);
          return Container(
            color: const Color(0xFFF8FAFC),
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: baseWidth * scale,
              child: _VerifyContent(scale: scale),
            ),
          );
        },
      ),
    );
  }
}

class _VerifyContent extends StatelessWidget {
  const _VerifyContent({required this.scale});

  final double scale;

  double s(double value) => value * scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(s(24)),
      ),
      child: Column(
        children: [
          _GradientHeader(scale: scale),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: s(24), vertical: s(32)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _StepIndicator(scale: scale),
                  SizedBox(height: s(32)),
                  _InstructionCard(scale: scale),
                  SizedBox(height: s(32)),
                  _CodeForm(scale: scale),
                  SizedBox(height: s(32)),
                  _ActionButtons(scale: scale),
                  SizedBox(height: s(24)),
                  _SupportPrompt(scale: scale),
                  SizedBox(height: s(24)),
                  _FooterBar(scale: scale),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientHeader extends StatelessWidget {
  const _GradientHeader({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 212 * scale,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment(-0.35, 0.35),
          end: Alignment(0.35, 1.06),
          colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24 * scale),
          topRight: Radius.circular(24 * scale),
        ),
      ),
      padding: EdgeInsets.only(
        left: 24 * scale,
        right: 24 * scale,
        top: 32 * scale,
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              width: 48 * scale,
              height: 48 * scale,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(9999),
                border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: Get.back,
                    child: Container(
                      width: 48 * scale,
                      height: 48 * scale,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(9999),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.3),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 18 * scale,
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              SizedBox(height: 16 * scale),
              Container(
                width: 80 * scale,
                height: 80 * scale,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.4),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  'S',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 30 * scale,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 12 * scale),
              Text(
                'Réinitialiser mot de passe',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 24 * scale,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4 * scale),
              Text(
                'Accédez à votre compte en toute sécurité',
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 14 * scale,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgotPasswordController>();
    controller.currentStep.value = ForgotPasswordStep.verify;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _Badge(step: 1, label: 'Email', isCompleted: true, scale: scale),
        _StepLine(scale: scale),
        _Badge(
          step: 2,
          label: 'Code',
          isCompleted: true,
          isActive: true,
          scale: scale,
        ),
        _StepLine(scale: scale),
        _Badge(step: 3, label: 'Nouveau', isCompleted: false, scale: scale),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    required this.step,
    required this.label,
    required this.scale,
    this.isCompleted = false,
    this.isActive = false,
  });

  final int step;
  final String label;
  final double scale;
  final bool isCompleted;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final Color color;
    if (isActive) {
      color = const Color(0xFF176BFF);
    } else if (isCompleted) {
      color = const Color(0xFF16A34A);
    } else {
      color = const Color(0xFFE2E8F0);
    }

    final textColor = isActive ? Colors.white : const Color(0xFF0B1220);

    return Column(
      children: [
        Container(
          width: 32 * scale,
          height: 32 * scale,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: Text(
            step.toString(),
            style: GoogleFonts.inter(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 14 * scale,
            ),
          ),
        ),
        SizedBox(height: 6 * scale),
        Text(
          label,
          style: GoogleFonts.inter(
            color: isActive ? const Color(0xFF176BFF) : const Color(0xFF475569),
            fontSize: 12 * scale,
          ),
        ),
      ],
    );
  }
}

class _StepLine extends StatelessWidget {
  const _StepLine({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48 * scale,
      height: 2,
      margin: EdgeInsets.symmetric(horizontal: 8 * scale),
      color: const Color(0xFFE2E8F0),
    );
  }
}

class _InstructionCard extends StatelessWidget {
  const _InstructionCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgotPasswordController>();
    return Container(
      padding: EdgeInsets.all(24 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Vérifiez votre boîte mail',
            style: GoogleFonts.poppins(
              color: const Color(0xFF0B1220),
              fontSize: 20 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12 * scale),
          Text(
            'Nous avons envoyé un code de confirmation à l\'adresse suivante :',
            style: GoogleFonts.inter(
              color: const Color(0xFF475569),
              fontSize: 14 * scale,
              height: 1.5,
            ),
          ),
          SizedBox(height: 12 * scale),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16 * scale,
              vertical: 14 * scale,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12 * scale),
              border: Border.all(color: const Color(0xFF176BFF), width: 1.5),
            ),
            child: Text(
              controller.emailController.text.isEmpty
                  ? 'votre.email@exemple.com'
                  : controller.emailController.text,
              style: GoogleFonts.inter(
                color: const Color(0xFF176BFF),
                fontSize: 16 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeForm extends StatelessWidget {
  const _CodeForm({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgotPasswordController>();
    return Container(
      padding: EdgeInsets.all(24 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Code de vérification',
            style: GoogleFonts.inter(
              color: const Color(0xFF0B1220),
              fontSize: 16 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16 * scale),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              controller.codeControllers.length,
              (index) => SizedBox(
                width: 40 * scale,
                child: TextField(
                  controller: controller.codeControllers[index],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 1,
                  decoration: InputDecoration(
                    counterText: '',
                    filled: true,
                    fillColor: const Color(0xFFF8FAFC),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12 * scale),
                      borderSide: const BorderSide(
                        color: Color(0xFFE2E8F0),
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 12 * scale),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Code valable 10 minutes',
                style: GoogleFonts.inter(
                  color: const Color(0xFF475569),
                  fontSize: 13 * scale,
                ),
              ),
              TextButton(
                onPressed: controller.resendCode,
                child: Text(
                  'Renvoyer',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF176BFF),
                    fontSize: 13 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24 * scale),
          Text(
            'Nouveau mot de passe',
            style: GoogleFonts.inter(
              color: const Color(0xFF0B1220),
              fontSize: 16 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12 * scale),
          Obx(
            () => _PasswordField(
              scale: scale,
              controller: controller.newPasswordController,
              hint: 'Mot de passe sécurisé',
              obscureText: controller.obscureNewPassword.value,
              onToggle: controller.toggleNewPasswordVisibility,
            ),
          ),
          SizedBox(height: 16 * scale),
          Text(
            'Confirmer le mot de passe',
            style: GoogleFonts.inter(
              color: const Color(0xFF0B1220),
              fontSize: 16 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12 * scale),
          Obx(
            () => _PasswordField(
              scale: scale,
              controller: controller.confirmPasswordController,
              hint: 'Confirmer le mot de passe',
              obscureText: controller.obscureConfirmPassword.value,
              onToggle: controller.toggleConfirmPasswordVisibility,
            ),
          ),
        ],
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    required this.scale,
    required this.controller,
    required this.hint,
    required this.obscureText,
    required this.onToggle,
  });

  final double scale;
  final TextEditingController controller;
  final String hint;
  final bool obscureText;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
        hintText: hint,
        hintStyle: GoogleFonts.inter(
          color: const Color(0xFFADAEBC),
          fontSize: 14 * scale,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12 * scale),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 2),
        ),
        suffixIcon: IconButton(
          onPressed: onToggle,
          icon: Icon(
            obscureText
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: const Color(0xFF94A3B8),
          ),
        ),
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgotPasswordController>();
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: controller.goToConfirmation,
            child: Container(
              height: 56 * scale,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
                ),
                borderRadius: BorderRadius.circular(12 * scale),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 15 * scale,
                    offset: Offset(0, 10 * scale),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                'Réinitialiser',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 16 * scale),
        Expanded(
          child: OutlinedButton(
            onPressed: controller.goToEmail,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFE2E8F0), width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12 * scale),
              ),
              padding: EdgeInsets.symmetric(vertical: 16 * scale),
              backgroundColor: Colors.white,
            ),
            child: Text(
              'Annuler',
              style: GoogleFonts.inter(
                color: const Color(0xFF475569),
                fontSize: 16 * scale,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SupportPrompt extends StatelessWidget {
  const _SupportPrompt({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgotPasswordController>();
    return Column(
      children: [
        Text(
          'Vous n\'avez pas reçu l\'email ?',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: const Color(0xFF475569),
            fontSize: 12 * scale,
          ),
        ),
        SizedBox(height: 8 * scale),
        GestureDetector(
          onTap: controller.contactSupport,
          child: Text(
            'Contactez le support',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF176BFF),
              fontSize: 12 * scale,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}

class _FooterBar extends StatelessWidget {
  const _FooterBar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65 * scale,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: EdgeInsets.all(16 * scale),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 8 * scale,
            height: 8 * scale,
            decoration: const BoxDecoration(
              color: Color(0xFF176BFF),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 12 * scale),
          Text(
            'Sécurisé par Sportify',
            style: GoogleFonts.inter(
              color: const Color(0xFF475569),
              fontSize: 12 * scale,
            ),
          ),
          SizedBox(width: 12 * scale),
          Container(
            width: 8 * scale,
            height: 8 * scale,
            decoration: const BoxDecoration(
              color: Color(0xFFFFB800),
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}

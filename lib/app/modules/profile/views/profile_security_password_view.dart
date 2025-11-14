import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/profile_security_password_controller.dart';

class ProfileSecurityPasswordView extends GetView<ProfileSecurityPasswordController> {
  const ProfileSecurityPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _Header(onBack: Get.back),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  const designWidth = 375.0;
                  final width = constraints.maxWidth.isFinite ? constraints.maxWidth : MediaQuery.of(context).size.width;
                  final scale = (width / designWidth).clamp(0.9, 1.1);

                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 24 * scale),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: designWidth * scale),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _HeroBanner(scale: scale),
                          SizedBox(height: 24 * scale),
                          _CurrentPasswordField(scale: scale),
                          SizedBox(height: 20 * scale),
                          _NewPasswordField(scale: scale),
                          SizedBox(height: 16 * scale),
                          _PasswordStrength(scale: scale),
                          SizedBox(height: 12 * scale),
                          _PasswordRequirements(scale: scale),
                          SizedBox(height: 20 * scale),
                          _ConfirmPasswordField(scale: scale),
                          SizedBox(height: 32 * scale),
                          _GradientButton(
                            scale: scale,
                            label: 'Modifier le mot de passe',
                            onTap: controller.submit,
                          ),
                          SizedBox(height: 20 * scale),
                          _SecurityTip(scale: scale),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
            style: IconButton.styleFrom(
              backgroundColor: const Color(0xFFF3F4F6),
              padding: const EdgeInsets.all(10),
              shape: const CircleBorder(),
            ),
          ),
          Expanded(
            child: Text(
              'Mot de passe',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(width: 44),
        ],
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18 * scale),
        gradient: const LinearGradient(colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)]),
      ),
      child: Row(
        children: [
          Container(
            width: 56 * scale,
            height: 56 * scale,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16 * scale),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.lock_outline_rounded, color: Colors.white, size: 30 * scale),
          ),
          SizedBox(width: 16 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sécurité renforcée',
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 18 * scale, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 6 * scale),
                Text(
                  'Mettez à jour régulièrement votre mot de passe pour protéger votre compte Sportify.',
                  style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.88), fontSize: 13.5 * scale, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CurrentPasswordField extends GetView<ProfileSecurityPasswordController> {
  const _CurrentPasswordField({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Mot de passe actuel', style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
        SizedBox(height: 8 * scale),
        Obx(
          () => TextField(
            controller: controller.currentPasswordController,
            obscureText: controller.obscureCurrent.value,
            decoration: _inputDecoration(
              hint: 'Entrez votre mot de passe actuel',
              errorText: controller.currentError.value.isEmpty ? null : controller.currentError.value,
            ),
          ),
        ),
      ],
    );
  }
}

class _NewPasswordField extends GetView<ProfileSecurityPasswordController> {
  const _NewPasswordField({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Nouveau mot de passe', style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
        SizedBox(height: 8 * scale),
        Obx(
          () => TextField(
            controller: controller.newPasswordController,
            obscureText: controller.obscureNew.value,
            onChanged: controller.onNewPasswordChanged,
            decoration: _inputDecoration(
              hint: 'Créez un mot de passe sécurisé',
              errorText: controller.newError.value.isEmpty ? null : controller.newError.value,
              suffix: IconButton(
                icon: Icon(
                  controller.obscureNew.value ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                  color: const Color(0xFF94A3B8),
                  size: 20 * scale,
                ),
                onPressed: controller.toggleNewVisibility,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ConfirmPasswordField extends GetView<ProfileSecurityPasswordController> {
  const _ConfirmPasswordField({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Confirmer le mot de passe', style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
        SizedBox(height: 8 * scale),
        Obx(
          () => TextField(
            controller: controller.confirmPasswordController,
            obscureText: controller.obscureConfirm.value,
            decoration: _inputDecoration(
              hint: 'Confirmez votre nouveau mot de passe',
              errorText: controller.confirmError.value.isEmpty ? null : controller.confirmError.value,
              suffix: IconButton(
                icon: Icon(
                  controller.obscureConfirm.value ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                  color: const Color(0xFF94A3B8),
                  size: 20 * scale,
                ),
                onPressed: controller.toggleConfirmVisibility,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PasswordStrength extends GetView<ProfileSecurityPasswordController> {
  const _PasswordStrength({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Force du mot de passe',
                style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale, fontWeight: FontWeight.w500),
              ),
              Text(
                _strengthLabel(controller.strength.value),
                style: GoogleFonts.inter(color: _strengthColor(controller.strength.value), fontSize: 12 * scale, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(height: 6 * scale),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: controller.strength.value,
              minHeight: 8 * scale,
              backgroundColor: const Color(0xFFE2E8F0),
              valueColor: AlwaysStoppedAnimation<Color>(_strengthColor(controller.strength.value)),
            ),
          ),
        ],
      ),
    );
  }

  String _strengthLabel(double strength) {
    if (strength >= 0.8) return 'Fort';
    if (strength >= 0.5) return 'Bon';
    if (strength > 0) return 'Faible';
    return '-';
  }

  Color _strengthColor(double strength) {
    if (strength >= 0.8) return const Color(0xFF16A34A);
    if (strength >= 0.5) return const Color(0xFFF59E0B);
    if (strength > 0) return const Color(0xFFEF4444);
    return const Color(0xFF94A3B8);
  }
}

class _PasswordRequirements extends StatelessWidget {
  const _PasswordRequirements({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final requirements = [
      'Au moins 8 caractères',
      'Inclure une majuscule et une minuscule',
      'Ajouter au moins un chiffre',
      'Ajouter un caractère spécial (!@#\$%)',
    ];

    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(14 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: requirements
            .map(
              (item) => Padding(
                padding: EdgeInsets.symmetric(vertical: 6 * scale),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: const Color(0xFF176BFF), size: 16 * scale),
                    SizedBox(width: 10 * scale),
                    Expanded(
                      child: Text(
                        item,
                        style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale),
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

class _SecurityTip extends StatelessWidget {
  const _SecurityTip({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF6EC),
        borderRadius: BorderRadius.circular(14 * scale),
        border: Border.all(color: const Color(0xFFFDE68A)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb_outline_rounded, color: const Color(0xFFF59E0B), size: 24 * scale),
          SizedBox(width: 12 * scale),
          Expanded(
            child: Text(
              'Activez l’authentification à deux facteurs pour renforcer la sécurité de votre compte Sportify.',
              style: GoogleFonts.inter(color: const Color(0xFF9B9B9B), fontSize: 13 * scale, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientButton extends StatelessWidget {
  const _GradientButton({required this.scale, required this.label, required this.onTap});

  final double scale;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56 * scale,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFF006CFF), Color(0xFF4FC3F7)]),
            borderRadius: BorderRadius.circular(14 * scale),
          ),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.inter(color: Colors.white, fontSize: 16 * scale, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}

InputDecoration _inputDecoration({required String hint, String? errorText, Widget? suffix}) {
  return InputDecoration(
    hintText: hint,
    hintStyle: GoogleFonts.inter(color: const Color(0xFFADAEBC)),
    filled: true,
    fillColor: const Color(0xFFF6F6F6),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF176BFF)),
    ),
    errorText: errorText,
    errorStyle: GoogleFonts.inter(color: const Color(0xFFEF4444), fontSize: 12),
    suffixIcon: suffix,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  );
}


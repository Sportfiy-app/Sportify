import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/login_controller.dart';

class LoginEmailView extends GetView<LoginController> {
  const LoginEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const baseWidth = 375.0;
          final size = MediaQuery.of(context).size;
          final maxWidth =
              constraints.maxWidth.isFinite
                  ? constraints.maxWidth
                  : size.width;
          final scale = (maxWidth / baseWidth).clamp(0.72, 1.15);

          return Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: maxWidth,
              child: _LoginEmailContent(scale: scale),
            ),
          );
        },
      ),
    );
  }
}

class _LoginEmailContent extends StatelessWidget {
  const _LoginEmailContent({required this.scale});

  final double scale;

  double s(double value) => value * scale;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    return SafeArea(
      bottom: false,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF7FAFF),
          border: Border(
            left: BorderSide(color: Color(0xFFE5E7EB)),
            right: BorderSide(color: Color(0xFFE5E7EB)),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: s(24)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: s(20)),
                          _HeroSection(scale: scale),
                          SizedBox(height: s(20)),
                          _LoginModeToggle(scale: scale),
                          SizedBox(height: s(24)),
                          Obx(() {
                            final mode = controller.loginMode.value;
                            final isLoading = controller.isSubmitting.value;
                            return Column(
                              children: [
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 320),
                                  switchInCurve: Curves.easeOutCubic,
                                  switchOutCurve: Curves.easeInCubic,
                                  transitionBuilder: (child, animation) {
                                    final slideAnimation = Tween<Offset>(
                                      begin: const Offset(0.08, 0),
                                      end: Offset.zero,
                                    ).animate(animation);
                                    return FadeTransition(
                                      opacity: animation,
                                      child: SlideTransition(
                                        position: slideAnimation,
                                        child: child,
                                      ),
                                    );
                                  },
                                  child:
                                      mode == LoginMode.email
                                          ? _EmailModeSection(
                                              key: const ValueKey(LoginMode.email),
                                              scale: scale,
                                            )
                                          : _PhoneModeSection(
                                              key: const ValueKey(LoginMode.phone),
                                              scale: scale,
                                            ),
                                ),
                                SizedBox(height: s(32)),
                                _PrimaryButton(
                                  scale: scale,
                                  label: isLoading ? 'Connexion en cours...' : 'Connexion',
                                  icon: Icons.login_rounded,
                                  onTap:
                                      mode == LoginMode.email
                                          ? controller.submitEmailLogin
                                          : () async => controller.submitPhoneLogin(),
                                  isLoading: isLoading,
                                  enabled: !isLoading,
                                ),
                                SizedBox(height: s(32)),
                                _DividerWithLabel(scale: scale, label: 'ou'),
                                SizedBox(height: s(24)),
                                _SocialButtons(scale: scale),
                                SizedBox(height: s(32)),
                                _QuickLoginSection(scale: scale),
                                SizedBox(height: s(32)),
                                _SecurityCard(scale: scale),
                                SizedBox(height: s(32)),
                                _HelpSection(scale: scale),
                                SizedBox(height: s(32)),
                                _RecentLogins(scale: scale),
                                SizedBox(height: s(32)),
                                _NewOnboardingCard(scale: scale),
                                SizedBox(height: s(32)),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                    _Footer(scale: scale),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 140 * scale,
              height: 140 * scale,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0x1A176BFF), Color(0x00176BFF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Container(
              width: 90 * scale,
              height: 90 * scale,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment(-0.35, 0.35),
                  end: Alignment(0.35, 1.06),
                  colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
                ),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFE5E7EB)),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x4D176BFF),
                    blurRadius: 30 * scale,
                    offset: Offset(0, 20 * scale),
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 9 * scale,
                    offset: Offset(0, 3 * scale),
                  ),
                ],
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
          ],
        ),
        SizedBox(height: 20 * scale),
        Text(
          'Connectez-vous',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: const Color(0xFF0B1220),
            fontSize: 26 * scale,
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
        ),
        SizedBox(height: 10 * scale),
        Text(
          'Retrouvez votre communauté sportive',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: const Color(0xFF475569),
            fontSize: 15 * scale,
            fontWeight: FontWeight.w500,
            height: 1.55,
          ),
        ),
      ],
    );
  }
}

class _LoginModeToggle extends StatelessWidget {
  const _LoginModeToggle({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    return Obx(
      () => _SegmentedToggle(
        scale: scale,
        activeMode: controller.loginMode.value,
        onSelect: controller.setMode,
      ),
    );
  }
}

class _SegmentedToggle extends StatelessWidget {
  const _SegmentedToggle({
    required this.scale,
    required this.activeMode,
    required this.onSelect,
  });

  final double scale;
  final LoginMode activeMode;
  final ValueChanged<LoginMode> onSelect;

  @override
  Widget build(BuildContext context) {
    final double width = 236 * scale;
    final double height = 48 * scale;
    final double indicatorWidth = (width - 6 * scale) / 2;

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF0F5FF),
              borderRadius: BorderRadius.circular(20 * scale),
              border: Border.all(color: const Color(0xFFD6E3FF)),
            ),
          ),
          AnimatedAlign(
            alignment:
                activeMode == LoginMode.email ? Alignment.centerLeft : Alignment.centerRight,
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            child: Container(
              margin: EdgeInsets.all(3 * scale),
              width: indicatorWidth,
              height: height - 6 * scale,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16 * scale),
                border: Border.all(color: const Color(0xFFD6E3FF)),
              ),
            ),
          ),
          Row(
            children: [
              _LoginModeChip(
                scale: scale,
                label: 'Email',
                icon: Icons.email_outlined,
                mode: LoginMode.email,
                activeMode: activeMode,
                onSelect: onSelect,
              ),
              _LoginModeChip(
                scale: scale,
                label: 'Téléphone',
                icon: Icons.phone_iphone_outlined,
                mode: LoginMode.phone,
                activeMode: activeMode,
                onSelect: onSelect,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LoginModeChip extends StatelessWidget {
  const _LoginModeChip({
    required this.scale,
    required this.label,
    required this.icon,
    required this.mode,
    required this.activeMode,
    required this.onSelect,
  });

  final double scale;
  final String label;
  final IconData icon;
  final LoginMode mode;
  final LoginMode activeMode;
  final ValueChanged<LoginMode> onSelect;

  @override
  Widget build(BuildContext context) {
    final bool isActive = mode == activeMode;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (!isActive) {
            onSelect(mode);
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6 * scale),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 14 * scale,
                  color: isActive ? const Color(0xFF176BFF) : const Color(0xFF475569),
                ),
                SizedBox(width: 5 * scale),
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 12.5 * scale,
                    fontWeight: FontWeight.w600,
                    color: isActive ? const Color(0xFF176BFF) : const Color(0xFF475569),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailForm extends StatelessWidget {
  const _EmailForm({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FieldLabel(scale: scale, label: 'Adresse email'),
        _OutlinedField(
          scale: scale,
          controller: controller.emailController,
          hint: 'john.doe@gmail.com',
          keyboardType: TextInputType.emailAddress,
          prefixIcon: Icons.mail_outline,
        ),
        SizedBox(height: 24 * scale),
        _FieldLabel(scale: scale, label: 'Mot de passe'),
        Obx(
          () => _OutlinedField(
            scale: scale,
            controller: controller.passwordController,
            hint: 'Entrez votre mot de passe',
            obscureText: controller.obscurePassword.value,
            prefixIcon: Icons.lock_outline,
            suffixIcon:
                controller.obscurePassword.value
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
            onSuffixTap: controller.togglePasswordVisibility,
          ),
        ),
        SizedBox(height: 12 * scale),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: controller.resetPassword,
            child: Text(
              'Réinitialiser',
              style: GoogleFonts.inter(
                color: const Color(0xFF176BFF),
                fontSize: 14 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PhoneForm extends StatelessWidget {
  const _PhoneForm({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FieldLabel(scale: scale, label: 'Numéro de téléphone'),
        SizedBox(height: 12 * scale),
        Row(
          children: [
            _PhoneCodeField(scale: scale, controller: controller.countryCodeController),
            SizedBox(width: 12 * scale),
            Expanded(
              child: _PhoneNumberField(scale: scale, controller: controller.phoneController),
            ),
          ],
        ),
        SizedBox(height: 24 * scale),
        _FieldLabel(scale: scale, label: 'Code de vérification'),
        SizedBox(height: 12 * scale),
        _OtpRow(scale: scale),
        SizedBox(height: 12 * scale),
        Text(
          'Code envoyé par SMS',
          style: GoogleFonts.inter(
            color: const Color(0xFF475569),
            fontSize: 14 * scale,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class _PhoneCodeField extends StatelessWidget {
  const _PhoneCodeField({required this.scale, required this.controller});

  final double scale;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 86 * scale,
      child: _PhoneOutlinedField(
        scale: scale,
        controller: controller,
        hint: '+33',
        trailing: Icon(
          Icons.expand_more,
          size: 18 * scale,
          color: const Color(0xFF94A3B8),
        ),
      ),
    );
  }
}

class _PhoneNumberField extends StatelessWidget {
  const _PhoneNumberField({required this.scale, required this.controller});

  final double scale;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return _PhoneOutlinedField(
      scale: scale,
      controller: controller,
      hint: '03 45 67 89',
      keyboardType: TextInputType.phone,
    );
  }
}

class _PhoneOutlinedField extends StatelessWidget {
  const _PhoneOutlinedField({
    required this.scale,
    required this.controller,
    required this.hint,
    this.keyboardType,
    this.trailing,
  });

  final double scale;
  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60 * scale,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 2 * scale),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              style: GoogleFonts.inter(
                fontSize: 16 * scale,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0B1220),
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: GoogleFonts.inter(
                  color: const Color(0xFFADAEBC),
                  fontSize: 14 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

class _OtpRow extends StatelessWidget {
  const _OtpRow({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(controller.otpControllers.length, (index) {
        return SizedBox(
          width: 46 * scale,
          child: TextField(
            controller: controller.otpControllers[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            decoration: InputDecoration(
              counterText: '',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12 * scale),
                borderSide: const BorderSide(
                  color: Color(0xFFE2E8F0),
                  width: 2,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.scale, required this.label});

  final double scale;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.inter(
        fontSize: 14 * scale,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF0B1220),
      ),
    );
  }
}

class _OutlinedField extends StatelessWidget {
  const _OutlinedField({
    required this.scale,
    required this.controller,
    required this.hint,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
  });

  final double scale;
  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;
  final bool obscureText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 2 * scale),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: GoogleFonts.inter(
          fontSize: 16 * scale,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF0B1220),
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16 * scale,
            vertical: 18 * scale,
          ),
          border: InputBorder.none,
          hintText: hint,
          hintStyle: GoogleFonts.inter(
            fontSize: 16 * scale,
            color: const Color(0xFFADAEBC),
          ),
          prefixIcon:
              prefixIcon == null
                  ? null
                  : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                    child: Icon(
                      prefixIcon,
                      size: 18 * scale,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
          prefixIconConstraints: BoxConstraints(
            minWidth: 48 * scale,
            minHeight: 48 * scale,
          ),
          suffixIcon:
              suffixIcon == null
                  ? null
                  : GestureDetector(
                    onTap: onSuffixTap,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                      child: Icon(
                        suffixIcon,
                        size: 18 * scale,
                        color: const Color(0xFF94A3B8),
                      ),
                    ),
                  ),
          suffixIconConstraints: BoxConstraints(
            minWidth: 48 * scale,
            minHeight: 48 * scale,
          ),
        ),
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.scale,
    required this.label,
    required this.icon,
    required this.onTap,
    this.isLoading = false,
    this.enabled = true,
  });

  final double scale;
  final String label;
  final IconData icon;
  final Future<void> Function()? onTap;
  final bool isLoading;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!enabled || isLoading || onTap == null) {
          return;
        }
        unawaited(onTap!());
      },
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 150),
        opacity: enabled ? 1 : 0.6,
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
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 6 * scale,
                offset: Offset(0, 4 * scale),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isLoading)
                SizedBox(
                  width: 18 * scale,
                  height: 18 * scale,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              else
                Icon(icon, color: Colors.white, size: 18 * scale),
              SizedBox(width: 12 * scale),
              Text(
                label,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DividerWithLabel extends StatelessWidget {
  const _DividerWithLabel({required this.scale, required this.label});

  final double scale;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: const Color(0xFFE2E8F0))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12 * scale),
          child: Text(
            label,
            style: GoogleFonts.inter(
              color: const Color(0xFF475569),
              fontSize: 14 * scale,
            ),
          ),
        ),
        Expanded(child: Container(height: 1, color: const Color(0xFFE2E8F0))),
      ],
    );
  }
}

class _SocialButtons extends StatelessWidget {
  const _SocialButtons({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SocialButton(
          scale: scale,
          label: 'Continuer avec Google',
          icon: Icons.g_mobiledata_rounded,
        ),
        SizedBox(height: 16 * scale),
        _SocialButton(
          scale: scale,
          label: 'Continuer avec Apple',
          icon: Icons.apple,
        ),
        SizedBox(height: 16 * scale),
        _SocialButton(
          scale: scale,
          label: 'Continuer avec Facebook',
          icon: Icons.facebook,
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.scale,
    required this.label,
    required this.icon,
  });

  final double scale;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64 * scale,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 2 * scale),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24 * scale, color: const Color(0xFF0B1220)),
          SizedBox(width: 16 * scale),
          Text(
            label,
            style: GoogleFonts.inter(
              color: const Color(0xFF0B1220),
              fontSize: 16 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickLoginSection extends StatelessWidget {
  const _QuickLoginSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Connexion rapide',
          style: GoogleFonts.poppins(
            color: const Color(0xFF0B1220),
            fontSize: 18 * scale,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16 * scale),
        Row(
          children: [
            _QuickLoginCard(
              scale: scale,
              colors: const [Color(0xFFFFB800), Color(0xFFEAB308)],
              label: 'Touch ID',
              icon: Icons.fingerprint,
            ),
            SizedBox(width: 16 * scale),
            _QuickLoginCard(
              scale: scale,
              colors: const [Color(0xFF0EA5E9), Color(0xFF60A5FA)],
              label: 'Face ID',
              icon: Icons.face_retouching_natural_outlined,
            ),
          ],
        ),
      ],
    );
  }
}

class _QuickLoginCard extends StatelessWidget {
  const _QuickLoginCard({
    required this.scale,
    required this.colors,
    required this.label,
    required this.icon,
  });

  final double scale;
  final List<Color> colors;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 92 * scale,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: colors),
          borderRadius: BorderRadius.circular(12 * scale),
          border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 28 * scale),
            SizedBox(height: 12 * scale),
            Text(
              label,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SecurityCard extends StatelessWidget {
  const _SecurityCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(12 * scale),
        border: Border.all(color: const Color(0xFFBFDBFE)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32 * scale,
            height: 32 * scale,
            decoration: BoxDecoration(
              color: const Color(0xFF176BFF),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.shield_outlined,
              color: Colors.white,
              size: 16 * scale,
            ),
          ),
          SizedBox(width: 16 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Connexion sécurisée',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF0B1220),
                    fontSize: 16 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8 * scale),
                Text(
                  'Vos données sont protégées par un chiffrement de niveau bancaire. Connexion SSL et authentification à deux facteurs disponible.',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF475569),
                    fontSize: 14 * scale,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HelpSection extends StatelessWidget {
  const _HelpSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Besoin d\'aide ?',
          style: GoogleFonts.inter(
            color: const Color(0xFF0B1220),
            fontSize: 16 * scale,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16 * scale),
        _HelpTile(
          scale: scale,
          label: 'Mot de passe oublié',
          icon: Icons.lock_reset_rounded,
          onTap: controller.resetPassword,
        ),
        SizedBox(height: 12 * scale),
        _HelpTile(
          scale: scale,
          label: 'Problème de réception d\'email',
          icon: Icons.mark_email_unread_outlined,
          onTap: controller.contactSupport,
        ),
        SizedBox(height: 12 * scale),
        _HelpTile(
          scale: scale,
          label: 'Contacter le support',
          icon: Icons.support_agent_outlined,
          onTap: controller.contactSupport,
        ),
      ],
    );
  }
}

class _HelpTile extends StatelessWidget {
  const _HelpTile({
    required this.scale,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final double scale;
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48 * scale,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8 * scale),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16 * scale),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Icon(icon, size: 18 * scale, color: const Color(0xFF475569)),
            SizedBox(width: 12 * scale),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.inter(
                  color: const Color(0xFF475569),
                  fontSize: 16 * scale,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 18 * scale,
              color: const Color(0xFF94A3B8),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentLogins extends StatelessWidget {
  const _RecentLogins({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final items = [
      (
        iconBg: const Color(0x3316A34A),
        icon: Icons.smartphone_outlined,
        title: 'iPhone 14 Pro',
        subtitle: 'Il y a 2 heures • Paris, France',
        active: true,
      ),
      (
        iconBg: const Color(0xFFF3F4F6),
        icon: Icons.laptop_mac_outlined,
        title: 'MacBook Pro',
        subtitle: 'Hier • Lyon, France',
        active: false,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dernières connexions',
          style: GoogleFonts.inter(
            color: const Color(0xFF0B1220),
            fontSize: 16 * scale,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16 * scale),
        ...items.map(
          (item) => Container(
            margin: EdgeInsets.only(bottom: 12 * scale),
            padding: EdgeInsets.all(16 * scale),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12 * scale),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                Container(
                  width: 40 * scale,
                  height: 40 * scale,
                  decoration: BoxDecoration(
                    color: item.iconBg,
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    item.icon,
                    color: const Color(0xFF0B1220),
                    size: 18 * scale,
                  ),
                ),
                SizedBox(width: 16 * scale),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF0B1220),
                          fontSize: 16 * scale,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4 * scale),
                      Text(
                        item.subtitle,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF475569),
                          fontSize: 14 * scale,
                        ),
                      ),
                    ],
                  ),
                ),
                if (item.active)
                  Container(
                    width: 8 * scale,
                    height: 8 * scale,
                    decoration: BoxDecoration(
                      color: const Color(0xFF16A34A),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _NewOnboardingCard extends StatelessWidget {
  const _NewOnboardingCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24 * scale),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
        ),
        borderRadius: BorderRadius.circular(12 * scale),
      ),
      child: Column(
        children: [
          Text(
            'Nouveau sur Sportify ?',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12 * scale),
          Text(
            'Rejoignez des milliers de sportifs dans votre région',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 14 * scale,
            ),
          ),
          SizedBox(height: 20 * scale),
          GestureDetector(
            onTap: controller.createAccount,
            child: Container(
              height: 48 * scale,
              width: 183 * scale,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12 * scale),
              ),
              alignment: Alignment.center,
              child: Text(
                'Créer maintenant',
                style: GoogleFonts.inter(
                  color: const Color(0xFF176BFF),
                  fontSize: 16 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 24 * scale,
        vertical: 18 * scale,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 24 * scale,
            runSpacing: 8 * scale,
            children: [
              _FooterLink(scale: scale, label: 'Conditions'),
              _FooterLink(scale: scale, label: 'Confidentialité'),
              _FooterLink(scale: scale, label: 'Support'),
            ],
          ),
          SizedBox(height: 16 * scale),
          Text(
            '© 2024 Sportify. Tous droits réservés.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF475569),
              fontSize: 12 * scale,
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink({required this.scale, required this.label});

  final double scale;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: TextAlign.center,
      style: GoogleFonts.inter(
        color: const Color(0xFF475569),
        fontSize: 14 * scale,
      ),
    );
  }
}

class _EmailModeSection extends StatelessWidget {
  const _EmailModeSection({required this.scale, super.key});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return _EmailForm(scale: scale);
  }
}

class _PhoneModeSection extends StatelessWidget {
  const _PhoneModeSection({required this.scale, super.key});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return _PhoneForm(scale: scale);
  }
}

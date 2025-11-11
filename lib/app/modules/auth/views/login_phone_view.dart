import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/login_controller.dart';

class LoginPhoneView extends GetView<LoginController> {
  const LoginPhoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          const baseWidth = 375.0;
          const baseHeight = 2339.0;

          final maxWidth =
              constraints.maxWidth.isFinite
                  ? constraints.maxWidth
                  : MediaQuery.of(context).size.width;
          final maxHeight =
              constraints.maxHeight.isFinite
                  ? constraints.maxHeight
                  : MediaQuery.of(context).size.height;

          final scaleX = maxWidth / baseWidth;
          final scaleY = maxHeight / baseHeight;
          final scale = math.min(scaleX, scaleY).clamp(0.55, 1.2);

          return Container(
            color: const Color(0xFFF8FAFC),
            child: Center(
              child: SizedBox(
                width: baseWidth * scale,
                child: _LoginPhoneContent(scale: scale),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _LoginPhoneContent extends StatelessWidget {
  const _LoginPhoneContent({required this.scale});

  final double scale;

  double s(double value) => value * scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        children: [
          _PhoneTopBar(scale: scale),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: s(24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: s(32)),
                  _PhoneHero(scale: scale),
                  SizedBox(height: s(32)),
                  _PhoneToggle(scale: scale),
                  SizedBox(height: s(24)),
                  _PhoneForm(scale: scale),
                  SizedBox(height: s(32)),
                  _PhoneSubmitButton(scale: scale),
                  SizedBox(height: s(32)),
                  _PhoneDivider(scale: scale),
                  SizedBox(height: s(24)),
                  _PhoneSocialButtons(scale: scale),
                  SizedBox(height: s(32)),
                  _PhoneQuickLogin(scale: scale),
                  SizedBox(height: s(32)),
                  _PhoneSecurityCard(scale: scale),
                  SizedBox(height: s(32)),
                  _PhoneHelp(scale: scale),
                  SizedBox(height: s(32)),
                  _PhoneRecent(scale: scale),
                  SizedBox(height: s(32)),
                  _PhoneNewCard(scale: scale),
                  SizedBox(height: s(32)),
                ],
              ),
            ),
          ),
          _PhoneFooter(scale: scale),
        ],
      ),
    );
  }
}

class _PhoneTopBar extends StatelessWidget {
  const _PhoneTopBar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 73 * scale,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16 * scale,
        vertical: 16 * scale,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _PhoneCircleButton(
            scale: scale,
            icon: Icons.arrow_back_ios_new_rounded,
            background: const Color(0xFFF3F4F6),
            onTap: Get.back,
          ),
          Container(
            width: 40 * scale,
            height: 40 * scale,
            decoration: BoxDecoration(
              color: const Color(0xFF176BFF),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            alignment: Alignment.center,
            child: Text(
              'S',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 20 * scale,
              ),
            ),
          ),
          SizedBox(width: 40 * scale),
        ],
      ),
    );
  }
}

class _PhoneCircleButton extends StatelessWidget {
  const _PhoneCircleButton({
    required this.scale,
    required this.icon,
    required this.background,
    this.onTap,
  });

  final double scale;
  final IconData icon;
  final Color background;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40 * scale,
        height: 40 * scale,
        decoration: BoxDecoration(
          color: background,
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        alignment: Alignment.center,
        child: Icon(icon, size: 18 * scale, color: const Color(0xFF0B1220)),
      ),
    );
  }
}

class _PhoneHero extends StatelessWidget {
  const _PhoneHero({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80 * scale,
          height: 80 * scale,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment(-0.35, 0.35),
              end: Alignment(0.35, 1.06),
              colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
            ),
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFE5E7EB)),
            boxShadow: [
              BoxShadow(color: const Color(0x51176BFF), blurRadius: 6 * scale),
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
        SizedBox(height: 24 * scale),
        Text(
          'Connectez-vous',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: const Color(0xFF0B1220),
            fontSize: 30 * scale,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 12 * scale),
        Text(
          'Retrouvez votre communauté sportive',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: const Color(0xFF475569),
            fontSize: 18 * scale,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class _PhoneToggle extends StatelessWidget {
  const _PhoneToggle({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    return Container(
      height: 52 * scale,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(12 * scale),
      ),
      child: Row(
        children: [
          _PhoneToggleButton(
            scale: scale,
            label: 'Email',
            icon: Icons.email_outlined,
            isActive: false,
            onTap: () => controller.setMode(LoginMode.email),
          ),
          _PhoneToggleButton(
            scale: scale,
            label: 'Téléphone',
            icon: Icons.phone_iphone_outlined,
            isActive: true,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _PhoneToggleButton extends StatelessWidget {
  const _PhoneToggleButton({
    required this.scale,
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  final double scale;
  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.all(4 * scale),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8 * scale),
            boxShadow:
                isActive
                    ? [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 6 * scale,
                        offset: Offset(0, 2 * scale),
                      ),
                    ]
                    : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16 * scale,
                color:
                    isActive
                        ? const Color(0xFF176BFF)
                        : const Color(0xFF475569),
              ),
              SizedBox(width: 8 * scale),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 14 * scale,
                  fontWeight: FontWeight.w600,
                  color:
                      isActive
                          ? const Color(0xFF176BFF)
                          : const Color(0xFF475569),
                ),
              ),
            ],
          ),
        ),
      ),
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
        _PhoneFieldLabel(scale: scale, label: 'Numéro de téléphone'),
        SizedBox(height: 12 * scale),
        Row(
          children: [
            _PhoneOutlinedField(
              scale: scale,
              controller: controller.countryCodeController,
              hint: '+33',
              width: 86 * scale,
              keyboardType: TextInputType.phone,
              trailing: Icon(
                Icons.expand_more,
                size: 18 * scale,
                color: const Color(0xFF94A3B8),
              ),
            ),
            SizedBox(width: 12 * scale),
            Expanded(
              child: _PhoneOutlinedField(
                scale: scale,
                controller: controller.phoneController,
                hint: '03 45 67 89',
                keyboardType: TextInputType.phone,
              ),
            ),
          ],
        ),
        SizedBox(height: 24 * scale),
        _PhoneFieldLabel(scale: scale, label: 'Code de vérification'),
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

class _PhoneFieldLabel extends StatelessWidget {
  const _PhoneFieldLabel({required this.scale, required this.label});

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

class _PhoneOutlinedField extends StatelessWidget {
  const _PhoneOutlinedField({
    required this.scale,
    required this.controller,
    required this.hint,
    this.width,
    this.keyboardType,
    this.trailing,
  });

  final double scale;
  final TextEditingController controller;
  final String hint;
  final double? width;
  final TextInputType? keyboardType;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final field = Container(
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

    if (width != null) {
      return SizedBox(width: width, child: field);
    }
    return field;
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

class _PhoneSubmitButton extends StatelessWidget {
  const _PhoneSubmitButton({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    return GestureDetector(
      onTap: controller.submitPhoneLogin,
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
          children: [
            Icon(Icons.login_rounded, color: Colors.white, size: 18 * scale),
            SizedBox(width: 12 * scale),
            Text(
              'Connexion',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PhoneDivider extends StatelessWidget {
  const _PhoneDivider({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: const Color(0xFFE2E8F0))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12 * scale),
          child: Text(
            'ou',
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

class _PhoneSocialButtons extends StatelessWidget {
  const _PhoneSocialButtons({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PhoneSocialButton(
          scale: scale,
          label: 'Continuer avec Google',
          icon: Icons.g_mobiledata_rounded,
        ),
        SizedBox(height: 16 * scale),
        _PhoneSocialButton(
          scale: scale,
          label: 'Continuer avec Apple',
          icon: Icons.apple,
        ),
        SizedBox(height: 16 * scale),
        _PhoneSocialButton(
          scale: scale,
          label: 'Continuer avec Facebook',
          icon: Icons.facebook,
        ),
      ],
    );
  }
}

class _PhoneSocialButton extends StatelessWidget {
  const _PhoneSocialButton({
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

class _PhoneQuickLogin extends StatelessWidget {
  const _PhoneQuickLogin({required this.scale});

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
            _PhoneQuickCard(
              scale: scale,
              colors: const [Color(0xFFFFB800), Color(0xFFEAB308)],
              label: 'Touch ID',
              icon: Icons.fingerprint,
            ),
            SizedBox(width: 16 * scale),
            _PhoneQuickCard(
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

class _PhoneQuickCard extends StatelessWidget {
  const _PhoneQuickCard({
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

class _PhoneSecurityCard extends StatelessWidget {
  const _PhoneSecurityCard({required this.scale});

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

class _PhoneHelp extends StatelessWidget {
  const _PhoneHelp({required this.scale});

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
        _PhoneHelpTile(
          scale: scale,
          label: 'Mot de passe oublié',
          icon: Icons.lock_reset_rounded,
          onTap: controller.resetPassword,
        ),
        SizedBox(height: 12 * scale),
        _PhoneHelpTile(
          scale: scale,
          label: 'Problème de réception d\'email',
          icon: Icons.mark_email_unread_outlined,
          onTap: controller.contactSupport,
        ),
        SizedBox(height: 12 * scale),
        _PhoneHelpTile(
          scale: scale,
          label: 'Contacter le support',
          icon: Icons.support_agent_outlined,
          onTap: controller.contactSupport,
        ),
      ],
    );
  }
}

class _PhoneHelpTile extends StatelessWidget {
  const _PhoneHelpTile({
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

class _PhoneRecent extends StatelessWidget {
  const _PhoneRecent({required this.scale});

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

class _PhoneNewCard extends StatelessWidget {
  const _PhoneNewCard({required this.scale});

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

class _PhoneFooter extends StatelessWidget {
  const _PhoneFooter({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 121 * scale,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 24 * scale,
        vertical: 16 * scale,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _PhoneFooterLink(
                scale: scale,
                label: 'Conditions\nd\'utilisation',
              ),
              _PhoneFooterLink(scale: scale, label: 'Confidentialité'),
              _PhoneFooterLink(scale: scale, label: 'Support'),
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

class _PhoneFooterLink extends StatelessWidget {
  const _PhoneFooterLink({required this.scale, required this.label});

  final double scale;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100 * scale,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
          color: const Color(0xFF475569),
          fontSize: 14 * scale,
        ),
      ),
    );
  }
}

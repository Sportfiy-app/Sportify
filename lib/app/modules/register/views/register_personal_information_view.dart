import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_routes.dart';
import '../controllers/register_controller.dart';
import '../widgets/country_code_picker.dart';

class RegisterPersonalInformationView
    extends GetView<RegisterController> {
  const RegisterPersonalInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF176BFF), // Blue background to match header
      body: LayoutBuilder(
        builder: (context, constraints) {
          const baseWidth = 375.0;
          final screenSize = MediaQuery.of(context).size;
          final maxWidth =
              constraints.hasBoundedWidth ? constraints.maxWidth : screenSize.width;
          final scale = (maxWidth / baseWidth).clamp(0.85, 1.15);

          return Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: maxWidth,
              child: _RegisterContent(scale: scale),
            ),
          );
        },
      ),
    );
  }
}

class _RegisterContent extends StatelessWidget {
  const _RegisterContent({required this.scale});

  final double scale;

  double s(double value) => value * scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header that extends to top (behind status bar)
        _RegisterHeader(scale: scale),
        // Content area with SafeArea for bottom only
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFFF7FAFF),
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: SafeArea(
              top: false,
              bottom: true,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: s(24)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: s(16)),
                    _StepProgress(scale: scale),
                    SizedBox(height: s(16)),
                    _HeroCard(scale: scale),
                    SizedBox(height: s(16)),
                    _FormCard(scale: scale),
                    SizedBox(height: s(16)),
                    _TermsCard(scale: scale),
                    SizedBox(height: s(16)),
                    _SecurityBanner(scale: scale),
                    SizedBox(height: s(24)),
                    _PrimaryCTA(scale: scale),
                    SizedBox(height: s(16)),
                    _AlreadyAccount(scale: scale),
                    SizedBox(height: s(16)),
                    _SocialDivider(scale: scale),
                    SizedBox(height: s(16)),
                    _SocialButtons(scale: scale),
                    SizedBox(height: s(24)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _RegisterHeader extends StatelessWidget {
  const _RegisterHeader({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    
    return Container(
      padding: EdgeInsets.only(
        top: statusBarHeight,
        left: 16 * scale,
        right: 16 * scale,
        bottom: 16 * scale,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-0.35, 0.35),
          end: Alignment(1.06, -0.35),
          colors: [Color(0xFF176BFF), Color(0xFF0F5AE0), Color(0xFF176BFF)],
        ),
      ),
      child: SizedBox(
        height: 180 * scale,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 52 * scale,
                height: 52 * scale,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.only(bottom: 28 * scale, right: 8 * scale),
                width: 26 * scale,
                height: 26 * scale,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8 * scale),
                // Navigation bar with centered logo
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Left back button
                    Positioned(
                      left: 0,
                      child: _HeaderButton(
                        icon: Icons.arrow_back_ios_new_rounded,
                        onTap: Get.back,
                        scale: scale,
                        background: Colors.white.withValues(alpha: 0.2),
                        iconColor: Colors.white,
                      ),
                    ),
                    // Centered logo
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(9999),
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 28 * scale,
                            height: 28 * scale,
                            decoration: BoxDecoration(
                              color: const Color(0xFF176BFF),
                              borderRadius: BorderRadius.circular(9999),
                              border: Border.all(color: const Color(0xFFE5E7EB)),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'S',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16 * scale,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(width: 8 * scale),
                          Text(
                            'Sportify',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF0B1220),
                              fontSize: 18 * scale,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Right help button
                    Positioned(
                      right: 0,
                      child: _HeaderButton(
                        icon: Icons.help_outline,
                        onTap: () {},
                        scale: scale,
                        background: Colors.transparent,
                        iconColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20 * scale),
                // Title and subtitle
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Créez un compte',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 28 * scale,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: 6 * scale),
                      Text(
                        'Rejoignez la communauté Sportify',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 16 * scale,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
      ),
    );
  }
}

class _StepProgress extends StatelessWidget {
  const _StepProgress({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Étape 1 sur 5',
              style: GoogleFonts.inter(
                color: const Color(0xFF475569),
                fontSize: 15 * scale,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
            const Spacer(),
            Text(
              '20%',
              style: GoogleFonts.inter(
                color: const Color(0xFF176BFF),
                fontSize: 15 * scale,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
        SizedBox(height: 14 * scale),
        ClipRRect(
          borderRadius: BorderRadius.circular(9999),
          child: LinearProgressIndicator(
            value: 0.2,
            minHeight: 10 * scale,
            backgroundColor: const Color(0xFFE2E8F0),
            valueColor: const AlwaysStoppedAnimation(Color(0xFF176BFF)),
          ),
        ),
      ],
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 18 * scale,
            offset: Offset(0, 10 * scale),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 96 * scale,
                height: 96 * scale,
                decoration: BoxDecoration(
                  color: const Color(0x19176BFF),
                  borderRadius: BorderRadius.circular(9999),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                alignment: Alignment.center,
                child: Container(
                  width: 66 * scale,
                  height: 66 * scale,
                  decoration: BoxDecoration(
                    color: const Color(0xFF176BFF),
                    borderRadius: BorderRadius.circular(9999),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.person_add_alt_1_outlined,
                      color: Colors.white, size: 32 * scale),
                ),
              ),
              Positioned(
                right: -12 * scale,
                top: 0,
                child: _MiniBadge(
                  scale: scale,
                  color: const Color(0xFFFFB800),
                  icon: Icons.star_rounded,
                ),
              ),
              Positioned(
                left: -12 * scale,
                bottom: -12 * scale,
                child: _MiniBadge(
                  scale: scale,
                  color: const Color(0xFF16A34A),
                  icon: Icons.verified_outlined,
                ),
              ),
            ],
          ),
          SizedBox(height: 24 * scale),
          Text(
            'Informations personnelles',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: const Color(0xFF0B1220),
              fontSize: 20 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 14 * scale),
          Text(
            'Créez votre profil en quelques étapes',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF475569),
              fontSize: 14 * scale,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _FormCard extends GetView<RegisterController> {
  const _FormCard({required this.scale});

  final double scale;

  double s(double value) => value * scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(s(24)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15 * scale,
            offset: Offset(0, 10 * scale),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Renseignez vos informations personnelles pour personnaliser votre expérience',
            style: GoogleFonts.inter(
              color: const Color(0xFF4B5563),
              fontSize: 14 * scale,
              height: 1.45,
            ),
          ),
          SizedBox(height: s(24)),
          _RegisterTextField(
            scale: scale,
            label: 'Nom',
            controller: controller.lastNameController,
            hint: 'Ex. Doe',
            isRequired: true,
          ),
          SizedBox(height: s(20)),
          _RegisterTextField(
            scale: scale,
            label: 'Prénom',
            controller: controller.firstNameController,
            hint: 'Ex. John',
            isRequired: true,
          ),
          SizedBox(height: s(20)),
          Obx(
            () {
              // Update controller text when selectedBirthDate changes
              if (controller.selectedBirthDate.value != null) {
                controller.birthDateController.text = controller.formattedBirthDate;
              }
              return _RegisterTextField(
                scale: scale,
                label: 'Date de naissance',
                controller: controller.birthDateController,
                hint: '01/02/1990',
                readOnly: true,
                onTap: () => controller.pickBirthDate(context),
                suffix: Icons.calendar_today_outlined,
              );
            },
          ),
          SizedBox(height: s(20)),
          _GenderSelector(scale: scale),
          SizedBox(height: s(20)),
          _RegisterTextField(
            scale: scale,
            label: 'Ville de résidence',
            controller: controller.cityController,
            hint: 'Ex. Nice, France',
            suffix: Icons.location_on_outlined,
          ),
          SizedBox(height: s(20)),
          _PhoneInput(scale: scale),
          SizedBox(height: s(20)),
          _RegisterTextField(
            scale: scale,
            label: 'Adresse email',
            controller: controller.emailController,
            hint: 'john.doe@gmail.com',
            prefixIcon: Icons.mail_outline,
          ),
          SizedBox(height: s(20)),
          Obx(
            () => _RegisterTextField(
              scale: scale,
              label: 'Mot de passe',
              controller: controller.passwordController,
              hint: 'Minimum 8 caractères',
              prefixIcon: Icons.lock_outline,
              obscureText: controller.obscurePassword.value,
              onSuffixTap: controller.togglePasswordVisibility,
              suffix: controller.obscurePassword.value
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
            ),
          ),
          SizedBox(height: s(8)),
          Row(
            children: List.generate(4, (index) {
              final colors = [
                const Color(0xFF94A3B8),
                const Color(0xFFE2E8F0),
                const Color(0xFFE2E8F0),
                const Color(0xFFE2E8F0),
              ];
              return Expanded(
                child: Container(
                  height: 4 * scale,
                  margin: EdgeInsets.symmetric(horizontal: 4 * scale),
                  decoration: BoxDecoration(
                    color: colors[index],
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: s(6)),
          Text(
            'Force du mot de passe',
            style: GoogleFonts.inter(
              color: const Color(0xFF475569),
              fontSize: 12 * scale,
            ),
          ),
          SizedBox(height: s(20)),
          Obx(
            () => _RegisterTextField(
              scale: scale,
              label: 'Confirmer le mot de passe',
              controller: controller.confirmPasswordController,
              hint: 'Retapez votre mot de passe',
              prefixIcon: Icons.lock_outline,
              obscureText: controller.obscureConfirmPassword.value,
              onSuffixTap: controller.toggleConfirmPasswordVisibility,
              suffix: controller.obscureConfirmPassword.value
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
            ),
          ),
        ],
      ),
    );
  }
}

class _GenderSelector extends GetView<RegisterController> {
  const _GenderSelector({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    const options = ['Femme', 'Homme', 'Autre'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Sexe',
                style: GoogleFonts.inter(
                  color: const Color(0xFF374151),
                  fontSize: 15 * scale,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.1,
                ),
              ),
              TextSpan(
                text: ' *',
                style: GoogleFonts.inter(
                  color: const Color(0xFFEF4444),
                  fontSize: 14 * scale,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 14 * scale),
        Obx(
          () => Row(
            children: options.map((option) {
              final isSelected = controller.gender.value == option;
              return Expanded(
                child: GestureDetector(
                  onTap: () => controller.selectGender(option),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 6 * scale),
                    padding: EdgeInsets.symmetric(vertical: 14 * scale),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12 * scale),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF176BFF)
                            : const Color(0xFFE5E7EB),
                        width: isSelected ? 2 : 1.5,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: const Color(0x19176BFF),
                                blurRadius: 20 * scale,
                                offset: Offset(0, 10 * scale),
                              ),
                            ]
                          : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      option,
                      style: GoogleFonts.inter(
                        color: isSelected
                            ? const Color(0xFF176BFF)
                            : const Color(0xFF0B1220),
                      fontSize: 15 * scale,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _PhoneInput extends GetView<RegisterController> {
  const _PhoneInput({required this.scale});

  final double scale;

  double s(double value) => value * scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Numéro de téléphone',
                style: GoogleFonts.inter(
                  color: const Color(0xFF374151),
                  fontSize: 15 * scale,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.1,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: s(12)),
        Row(
          children: [
            Flexible(
              flex: 36,
              child: Obx(
                () => CountryCodePicker(
                  selectedCode: controller.selectedCountryCode.value,
                  selectedFlag: controller.selectedCountryFlag.value,
                  onCountrySelected: (code, flag, name) {
                    controller.selectedCountryCode.value = code;
                    controller.selectedCountryFlag.value = flag;
                    controller.selectedCountryName.value = name;
                  },
                  scale: scale,
                ),
              ),
            ),
            SizedBox(width: s(12)),
            Flexible(
              flex: 64,
              child: Container(
                height: 60 * scale,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(14 * scale),
                  border: Border.all(color: const Color(0xFFE2E8F0), width: 2),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                alignment: Alignment.center,
                child: TextField(
                  controller: controller.phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Ex. 6 12 34 56 78',
                    hintStyle: GoogleFonts.inter(
                      color: const Color(0xFFADAEBC),
                      fontSize: 16 * scale,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: s(12)),
        Text(
          'Nous utiliserons ce numéro pour vérifier votre compte',
          style: GoogleFonts.inter(
            color: const Color(0xFF475569),
            fontSize: 12 * scale,
          ),
        ),
      ],
    );
  }
}

class _RegisterTextField extends StatelessWidget {
  const _RegisterTextField({
    required this.scale,
    required this.label,
    required this.controller,
    required this.hint,
    this.isRequired = false,
    this.prefixIcon,
    this.suffix,
    this.onSuffixTap,
    this.onTap,
    this.obscureText = false,
    this.readOnly = false,
  });

  final double scale;
  final String label;
  final TextEditingController controller;
  final String hint;
  final bool isRequired;
  final IconData? prefixIcon;
  final IconData? suffix;
  final VoidCallback? onSuffixTap;
  final VoidCallback? onTap;
  final bool obscureText;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: label,
                style: GoogleFonts.inter(
                  color: const Color(0xFF374151),
                  fontSize: 15 * scale,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.1,
                ),
              ),
              if (isRequired)
                TextSpan(
                  text: ' *',
                  style: GoogleFonts.inter(
                    color: const Color(0xFFEF4444),
                    fontSize: 14 * scale,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 14 * scale),
        TextField(
          controller: controller,
          obscureText: obscureText,
          readOnly: readOnly,
          onTap: onTap,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            hintText: hint,
            hintStyle: GoogleFonts.inter(
              color: const Color(0xFFADAEBC),
              fontSize: 16 * scale,
            ),
            prefixIcon: prefixIcon == null
                ? null
                : Icon(prefixIcon, color: const Color(0xFF94A3B8), size: 18 * scale),
            suffixIcon: suffix == null
                ? null
                : IconButton(
                    onPressed: onSuffixTap,
                    icon: Icon(suffix, color: const Color(0xFF94A3B8), size: 18 * scale),
                  ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 18 * scale),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12 * scale),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12 * scale),
              borderSide: const BorderSide(color: Color(0xFF176BFF), width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

class _TermsCard extends GetView<RegisterController> {
  const _TermsCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => Checkbox(
              value: controller.acceptsTerms.value,
              onChanged: controller.toggleTerms,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4 * scale)),
            ),
          ),
          SizedBox(width: 12 * scale),
          Expanded(
            child: Text.rich(
              TextSpan(
                style: GoogleFonts.inter(
                  fontSize: 14 * scale,
                  color: const Color(0xFF475569),
                  height: 1.55,
                ),
                children: const [
                  TextSpan(text: "En créant un compte, j'accepte les "),
                  TextSpan(
                    text: "Conditions d'utilisation",
                    style: TextStyle(color: Color(0xFF176BFF), decoration: TextDecoration.underline),
                  ),
                  TextSpan(text: ' et la '),
                  TextSpan(
                    text: 'Politique de confidentialité',
                    style: TextStyle(color: Color(0xFF176BFF), decoration: TextDecoration.underline),
                  ),
                  TextSpan(text: ' de Sportify.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SecurityBanner extends StatelessWidget {
  const _SecurityBanner({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24 * scale),
      decoration: BoxDecoration(
        color: const Color(0x190EA5E9),
        borderRadius: BorderRadius.circular(12 * scale),
        border: Border.all(color: const Color(0x330EA5E9)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20 * scale,
            height: 20 * scale,
            margin: EdgeInsets.only(top: 4 * scale),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4 * scale),
              border: Border.all(color: const Color(0xFFD0D5DD)),
            ),
            child: const Icon(Icons.lock_outlined, size: 16, color: Color(0xFF176BFF)),
          ),
          SizedBox(width: 12 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Protection des données',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF0B1220),
                    fontSize: 14 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8 * scale),
                Text(
                  'Vos informations personnelles sont protégées et chiffrées. Nous ne partageons jamais vos données avec des tiers sans votre consentement.',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF475569),
                    fontSize: 12 * scale,
                    height: 1.6,
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

class _PrimaryCTA extends GetView<RegisterController> {
  const _PrimaryCTA({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14 * scale),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF176BFF).withValues(alpha: 0.3),
            blurRadius: 12 * scale,
            offset: Offset(0, 6 * scale),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: controller.continueRegistration,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 20 * scale),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
          backgroundColor: const Color(0xFF176BFF),
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        child: Text(
          'Continuer',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 17 * scale,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}

class _AlreadyAccount extends StatelessWidget {
  const _AlreadyAccount({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Vous avez déjà un compte ?',
          style: GoogleFonts.inter(
            color: const Color(0xFF475569),
            fontSize: 14 * scale,
          ),
        ),
        SizedBox(height: 8 * scale),
        GestureDetector(
          onTap: () => Get.offAllNamed(Routes.loginEmail),
          child: Text(
            'Se connecter',
            style: GoogleFonts.inter(
              color: const Color(0xFF176BFF),
              fontSize: 16 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _SocialDivider extends StatelessWidget {
  const _SocialDivider({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: const Color(0xFFE2E8F0))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12 * scale),
          child: Text(
            'ou continuez avec',
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
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFE2E8F0), width: 2),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12 * scale),
              ),
              padding: EdgeInsets.symmetric(vertical: 14 * scale),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.g_mobiledata_rounded, color: const Color(0xFF0B1220), size: 20 * scale),
                SizedBox(width: 12 * scale),
                Text(
                  'Google',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF0B1220),
                    fontSize: 14 * scale,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 12 * scale),
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFE2E8F0), width: 2),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12 * scale),
              ),
              padding: EdgeInsets.symmetric(vertical: 14 * scale),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.apple, color: const Color(0xFF0B1220), size: 20 * scale),
                SizedBox(width: 12 * scale),
                Text(
                  'Apple',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF0B1220),
                    fontSize: 14 * scale,
                    fontWeight: FontWeight.w500,
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

class _MiniBadge extends StatelessWidget {
  const _MiniBadge({required this.scale, required this.color, required this.icon});

  final double scale;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28 * scale,
      height: 28 * scale,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(9999),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      alignment: Alignment.center,
      child: Icon(icon, size: 16 * scale, color: Colors.white),
    );
  }
}

class _HeaderButton extends StatelessWidget {
  const _HeaderButton({
    required this.icon,
    required this.onTap,
    required this.scale,
    required this.background,
    required this.iconColor,
  });

  final IconData icon;
  final VoidCallback onTap;
  final double scale;
  final Color background;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40 * scale,
        height: 40 * scale,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(12 * scale),
          border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: iconColor, size: 18 * scale),
      ),
    );
  }
}

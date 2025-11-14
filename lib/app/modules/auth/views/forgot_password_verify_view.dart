import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_routes.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordVerifyView extends GetView<ForgotPasswordController> {
  const ForgotPasswordVerifyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const baseWidth = 375.0;
          final size = MediaQuery.of(context).size;
          final maxWidth =
              constraints.hasBoundedWidth ? constraints.maxWidth : size.width;
          final scale = (maxWidth / baseWidth).clamp(0.8, 1.2);
          return Container(
            color: const Color(0xFFF7FAFF),
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: maxWidth,
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
    return SafeArea(
      bottom: false,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF7FAFF), Color(0xFFFFFFFF)],
          ),
          border: const Border(
            left: BorderSide(color: Color(0xFFE5E7EB)),
            right: BorderSide(color: Color(0xFFE5E7EB)),
          ),
        ),
        child: Column(
          children: [
            _VerifyTopBar(scale: scale),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: s(24)),
                child: Column(
                  children: [
                    SizedBox(height: s(24)),
                    _VerifyHero(scale: scale),
                    SizedBox(height: s(32)),
                    _VerifyHeading(scale: scale),
                    SizedBox(height: s(24)),
                    _PhoneSummary(scale: scale),
                    SizedBox(height: s(24)),
                    _OtpInput(scale: scale),
                    SizedBox(height: s(20)),
                    _ResendHelp(scale: scale),
                    SizedBox(height: s(24)),
                    _VerifyButton(scale: scale),
                    SizedBox(height: s(24)),
                    _SecurityInfoCard(scale: scale),
                    SizedBox(height: s(24)),
                    _HelpOptionsList(scale: scale),
                    SizedBox(height: s(24)),
                    _SocialConnect(scale: scale),
                    SizedBox(height: s(32)),
                    _VerifyFooter(scale: scale),
                    SizedBox(height: s(40)),
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

class _VerifyTopBar extends StatelessWidget {
  const _VerifyTopBar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24 * scale, vertical: 12 * scale),
      child: Row(
        children: [
          _CircleButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: Get.find<ForgotPasswordController>().goToEmail,
            scale: scale,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 32 * scale,
                  height: 32 * scale,
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
                      fontSize: 18 * scale,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(width: 12 * scale),
                Text(
                  'Sportify',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF0B1220),
                    fontSize: 20 * scale,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Get.offAllNamed(Routes.loginEmail),
            child: Container(
              width: 40 * scale,
              height: 40 * scale,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(9999),
                border: Border.all(color: const Color(0xFFE5E7EB)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 12 * scale,
                    offset: Offset(0, 6 * scale),
                  ),
                ],
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
    );
  }
}

class _VerifyHero extends StatelessWidget {
  const _VerifyHero({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 240 * scale,
          height: 240 * scale,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [const Color(0x33176BFF), const Color(0x000F5AE0)],
              radius: 0.9,
            ),
          ),
        ),
        Container(
          width: 160 * scale,
          height: 160 * scale,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
            ),
            border: Border.all(color: Colors.white, width: 6 * scale),
            boxShadow: [
              BoxShadow(
                color: const Color(0x40176BFF),
                blurRadius: 28 * scale,
                offset: Offset(0, 18 * scale),
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
    );
  }
}

class _VerifyHeading extends StatelessWidget {
  const _VerifyHeading({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Entrez le code reçu par SMS',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: const Color(0xFF0B1220),
            fontSize: 24 * scale,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 12 * scale),
        Text(
          'Nous avons envoyé un code de vérification à 6 chiffres sur votre téléphone pour confirmer votre identité',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: const Color(0xFF475569),
            fontSize: 16 * scale,
            height: 1.55,
          ),
        ),
        SizedBox(height: 24 * scale),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 18 * scale, vertical: 14 * scale),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16 * scale),
            border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
          ),
          child: Row(
            children: [
              Container(
                width: 32 * scale,
                height: 32 * scale,
                decoration: BoxDecoration(
                  color: const Color(0x19176BFF),
                  borderRadius: BorderRadius.circular(9999),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.phone_iphone_outlined,
                  size: 16 * scale,
                  color: const Color(0xFF176BFF),
                ),
              ),
              SizedBox(width: 12 * scale),
              Expanded(
                child: Text(
                  '+33 6 ** ** ** 45',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF0B1220),
                    fontSize: 16 * scale,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              GestureDetector(
                onTap: Get.find<ForgotPasswordController>().goToEmail,
                child: Text(
                  'Modifier',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF176BFF),
                    fontSize: 14 * scale,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16 * scale),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24 * scale, vertical: 10 * scale),
          decoration: BoxDecoration(
            color: const Color(0x19F59E0B),
            borderRadius: BorderRadius.circular(9999),
            border: Border.all(color: const Color(0xFFF59E0B).withValues(alpha: 0.4)),
          ),
          child: Obx(
            () {
              final seconds = Get.find<ForgotPasswordController>().resendSeconds.value;
              final duration = Duration(seconds: seconds);
              final minutesStr = duration.inMinutes.remainder(60).toString().padLeft(1, '0');
              final secondsStr = (duration.inSeconds % 60).toString().padLeft(2, '0');
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.timer_outlined, size: 16 * scale, color: const Color(0xFFF59E0B)),
                  SizedBox(width: 8 * scale),
                  Text(
                    'Le code expire dans',
                    style: GoogleFonts.inter(
                      color: const Color(0xFFF59E0B),
                      fontSize: 14 * scale,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 8 * scale),
                  Text(
                    '$minutesStr:$secondsStr',
                    style: GoogleFonts.inter(
                      color: const Color(0xFFF59E0B),
                      fontSize: 14 * scale,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _PhoneSummary extends StatelessWidget {
  const _PhoneSummary({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 14 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            width: 32 * scale,
            height: 32 * scale,
            decoration: BoxDecoration(
              color: const Color(0x19F59E0B),
              borderRadius: BorderRadius.circular(9999),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.sms_outlined, size: 16 * scale, color: const Color(0xFFF59E0B)),
          ),
          SizedBox(width: 12 * scale),
          Expanded(
            child: Text(
              '+33 6 ** ** ** 45',
              style: GoogleFonts.inter(
                color: const Color(0xFF0B1220),
                fontSize: 16 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Get.find<ForgotPasswordController>().goToEmail(),
            child: Text(
              'Modifier',
              style: GoogleFonts.inter(
                color: const Color(0xFF176BFF),
                fontSize: 14 * scale,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OtpInput extends StatelessWidget {
  const _OtpInput({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgotPasswordController>();
    return Column(
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
        SizedBox(height: 12 * scale),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(controller.codeControllers.length, (index) {
            return SizedBox(
              width: 48 * scale,
              child: TextField(
                controller: controller.codeControllers[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 1,
                decoration: InputDecoration(
                  counterText: '',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12 * scale),
                    borderSide: BorderSide(
                      color: index == 0
                          ? const Color(0xFF176BFF)
                          : const Color(0xFFE2E8F0),
                      width: 2,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _ResendHelp extends StatelessWidget {
  const _ResendHelp({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Vous n'avez pas reçu le code ?",
          style: GoogleFonts.inter(
            color: const Color(0xFF475569),
            fontSize: 14 * scale,
          ),
        ),
        SizedBox(height: 8 * scale),
        Obx(() {
          final controller = Get.find<ForgotPasswordController>();
          final isEnabled = controller.resendSeconds.value == 0;
          return GestureDetector(
            onTap: isEnabled ? controller.resendCode : null,
            child: Text(
              'Renvoyer le code',
              style: GoogleFonts.inter(
                color: const Color(0xFF176BFF).withValues(alpha: isEnabled ? 1 : 0.4),
                fontSize: 16 * scale,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _VerifyButton extends StatelessWidget {
  const _VerifyButton({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgotPasswordController>();
    return GestureDetector(
      onTap: controller.verifyCode,
      child: Container(
        height: 60 * scale,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
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
          'Vérifier le code',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18 * scale,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _SecurityInfoCard extends StatelessWidget {
  const _SecurityInfoCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32 * scale,
            height: 32 * scale,
            decoration: BoxDecoration(
              color: const Color(0x190EA5E9),
              borderRadius: BorderRadius.circular(12 * scale),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.shield_outlined, size: 16 * scale, color: const Color(0xFF0EA5E9)),
          ),
          SizedBox(width: 16 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sécurité renforcée',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF0B1220),
                    fontSize: 18 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 12 * scale),
                Text(
                  'Ce code à usage unique expire dans 2 minutes et garantit la sécurité de votre compte. Ne le partagez jamais.',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF475569),
                    fontSize: 14 * scale,
                    height: 1.54,
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

class _HelpOptionsList extends StatelessWidget {
  const _HelpOptionsList({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final options = [
      (
        color: const Color(0x19F59E0B),
        icon: Icons.sms_failed_outlined,
        title: 'Code non reçu ?',
        subtitle: 'Vérifiez vos messages ou spam',
      ),
      (
        color: const Color(0x19EF4444),
        icon: Icons.update_outlined,
        title: 'Code expiré ?',
        subtitle: 'Demandez un nouveau code',
      ),
      (
        color: const Color(0x190EA5E9),
        icon: Icons.support_agent_outlined,
        title: 'Problème technique ?',
        subtitle: 'Contactez notre support',
      ),
    ];
    final controller = Get.find<ForgotPasswordController>();
    return Container(
      padding: EdgeInsets.all(24 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Besoin d'aide ?",
            style: GoogleFonts.poppins(
              color: const Color(0xFF0B1220),
              fontSize: 18 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16 * scale),
          ...options.map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: 12 * scale),
              child: Container(
                padding: EdgeInsets.all(16 * scale),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12 * scale),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 32 * scale,
                      height: 32 * scale,
                      decoration: BoxDecoration(
                        color: item.color,
                        borderRadius: BorderRadius.circular(9999),
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                      ),
                      alignment: Alignment.center,
                      child: Icon(item.icon, size: 16 * scale, color: const Color(0xFF0B1220)),
                    ),
                    SizedBox(width: 12 * scale),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: GoogleFonts.inter(
                              color: const Color(0xFF0B1220),
                              fontSize: 14 * scale,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 6 * scale),
                          Text(
                            item.subtitle,
                            style: GoogleFonts.inter(
                              color: const Color(0xFF475569),
                              fontSize: 12 * scale,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right, size: 20 * scale, color: const Color(0xFF94A3B8)),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: controller.contactSupport,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16 * scale),
              alignment: Alignment.center,
              child: Text(
                'Contactez le support',
                style: GoogleFonts.inter(
                  color: const Color(0xFF176BFF),
                  fontSize: 14 * scale,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialConnect extends StatelessWidget {
  const _SocialConnect({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Ou connectez-vous avec',
          style: GoogleFonts.inter(
            color: const Color(0xFF475569),
            fontSize: 14 * scale,
          ),
        ),
        SizedBox(height: 16 * scale),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12 * scale),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14 * scale),
                  backgroundColor: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.g_mobiledata_rounded, size: 20 * scale, color: const Color(0xFF0B1220)),
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
            SizedBox(width: 16 * scale),
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12 * scale),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14 * scale),
                  backgroundColor: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.apple, size: 20 * scale, color: const Color(0xFF0B1220)),
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
        ),
      ],
    );
  }
}

class _VerifyFooter extends StatelessWidget {
  const _VerifyFooter({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'En continuant, vous acceptez nos',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: const Color(0xFF475569),
            fontSize: 12 * scale,
          ),
        ),
        SizedBox(height: 12 * scale),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _FooterLinkButton(
              label: 'Conditions d\'utilisation',
              onTap: () {},
              scale: scale,
            ),
            SizedBox(width: 16 * scale),
            _FooterLinkButton(
              label: 'Politique de confidentialité',
              onTap: () {},
              scale: scale,
            ),
          ],
        ),
      ],
    );
  }
}

class _FooterLinkButton extends StatelessWidget {
  const _FooterLinkButton({required this.label, required this.onTap, required this.scale});

  final String label;
  final VoidCallback onTap;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: const Color(0xFF176BFF),
          fontSize: 12 * scale,
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({required this.icon, required this.onTap, required this.scale});

  final IconData icon;
  final VoidCallback onTap;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40 * scale,
        height: 40 * scale,
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(12 * scale),
          border: Border.all(color: const Color(0xFFE5E7EB)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 6 * scale,
              offset: Offset(0, 3 * scale),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Icon(icon, size: 18 * scale, color: const Color(0xFF0B1220)),
      ),
    );
  }
}

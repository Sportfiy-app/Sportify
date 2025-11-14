import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/forgot_password_controller.dart';
import '../controllers/login_controller.dart';

class ForgotPasswordRequestView extends GetView<ForgotPasswordController> {
  const ForgotPasswordRequestView({super.key});

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
          final scale = (maxWidth / baseWidth).clamp(0.72, 1.15);
          return Container(
            color: const Color(0xFFF7FAFF),
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: maxWidth,
              child: _ForgotPasswordRequestContent(scale: scale),
            ),
          );
        },
      ),
    );
  }
}

class _ForgotPasswordRequestContent extends StatelessWidget {
  const _ForgotPasswordRequestContent({required this.scale});

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
            _HeaderStepper(scale: scale),
            Expanded(
              child: SingleChildScrollView(
                padding:
                    EdgeInsets.symmetric(horizontal: s(24), vertical: s(32)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _HeroCard(scale: scale),
                    SizedBox(height: s(32)),
                    _EmailForm(scale: scale),
                    SizedBox(height: s(32)),
                    _OtherOptions(scale: scale),
                    SizedBox(height: s(24)),
                    _SecurityBanner(scale: scale),
                    SizedBox(height: s(24)),
                    _RecentActivity(scale: scale),
                    SizedBox(height: s(24)),
                    _HelpOptions(scale: scale),
                    SizedBox(height: s(24)),
                    _TipsCard(scale: scale),
                    SizedBox(height: s(24)),
                    _LegalFooter(scale: scale),
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

class _HeaderStepper extends StatelessWidget {
  const _HeaderStepper({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgotPasswordController>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24 * scale, vertical: 12 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SafeArea(
            bottom: false,
            child: Row(
              children: [
                _CircleButton(
                  icon: Icons.arrow_back_ios_new_rounded,
                  onTap: Get.back,
                  scale: scale,
                ),
                Expanded(
                  child: Text(
                    'Mot de passe oublié',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 14 * scale,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0B1220),
                    ),
                  ),
                ),
                SizedBox(width: 40 * scale),
              ],
            ),
          ),
          SizedBox(height: 24 * scale),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 18 * scale,
              horizontal: 20 * scale,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20 * scale),
              border: Border.all(color: const Color(0xFFE2E8F0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 20 * scale,
                  offset: Offset(0, 12 * scale),
                ),
              ],
            ),
            child: Obx(
              () {
                final step = controller.currentStep.value;
                return Row(
                  children: [
                    _StepChip(
                      scale: scale,
                      label: 'Email',
                      index: 1,
                      isActive: step == ForgotPasswordStep.email,
                      isCompleted: step != ForgotPasswordStep.email,
                    ),
                    _StepDivider(scale: scale),
                    _StepChip(
                      scale: scale,
                      label: 'Code',
                      index: 2,
                      isActive: step == ForgotPasswordStep.verify,
                      isCompleted: step == ForgotPasswordStep.done,
                    ),
                    _StepDivider(scale: scale),
                    _StepChip(
                      scale: scale,
                      label: 'Nouveau',
                      index: 3,
                      isActive: step == ForgotPasswordStep.done,
                      isCompleted: false,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _StepChip extends StatelessWidget {
  const _StepChip({
    required this.scale,
    required this.label,
    required this.index,
    required this.isActive,
    required this.isCompleted,
  });

  final double scale;
  final String label;
  final int index;
  final bool isActive;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    final Color background;
    final Color textColor;
    if (isActive) {
      background = const Color(0xFF176BFF);
      textColor = Colors.white;
    } else if (isCompleted) {
      background = const Color(0xFFE2E8F0);
      textColor = const Color(0xFF0B1220);
    } else {
      background = const Color(0xFFE2E8F0);
      textColor = const Color(0xFF475569);
    }

    return Expanded(
      child: Column(
        children: [
          Container(
            width: 32 * scale,
            height: 32 * scale,
            decoration: BoxDecoration(
              color: background,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            alignment: Alignment.center,
            child: Text(
              index.toString(),
              style: GoogleFonts.inter(
                color: textColor,
                fontWeight: FontWeight.w600,
                fontSize: 14 * scale,
              ),
            ),
          ),
          SizedBox(height: 8 * scale),
          Text(
            label,
            style: GoogleFonts.inter(
              color:
                  isActive ? const Color(0xFF176BFF) : const Color(0xFF475569),
              fontSize: 12 * scale,
            ),
          ),
        ],
      ),
    );
  }
}

class _StepDivider extends StatelessWidget {
  const _StepDivider({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48 * scale,
      height: 2,
      margin: EdgeInsets.symmetric(horizontal: 6 * scale),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        gradient: const LinearGradient(
          colors: [Color(0xFFE5ECFF), Color(0xFFD9E3FF)],
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({
    required this.icon,
    required this.onTap,
    required this.scale,
  });

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
        ),
        alignment: Alignment.center,
        child: Icon(icon, size: 18 * scale, color: const Color(0xFF0B1220)),
      ),
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
      ),
      child: Column(
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
                BoxShadow(
                  color: const Color(0x51176BFF),
                  blurRadius: 8 * scale,
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
          SizedBox(height: 24 * scale),
          Text(
            'Récupération de mot de passe',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: const Color(0xFF0B1220),
              fontSize: 24 * scale,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16 * scale),
          Text(
            'Saisissez votre adresse email pour recevoir un code de vérification.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF475569),
              fontSize: 16 * scale,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmailForm extends StatelessWidget {
  const _EmailForm({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgotPasswordController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Adresse email',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 14 * scale,
            color: const Color(0xFF0B1220),
          ),
        ),
        SizedBox(height: 12 * scale),
        Container(
          height: 60 * scale,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12 * scale),
            border: Border.all(color: const Color(0xFFE2E8F0), width: 2),
            boxShadow: [
              BoxShadow(
                color: const Color(0x1A176BFF),
                blurRadius: 25 * scale,
                offset: Offset(0, 10 * scale),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 16 * scale),
          alignment: Alignment.center,
          child: TextField(
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'votre.email@exemple.com',
              border: InputBorder.none,
              hintStyle: GoogleFonts.inter(
                color: const Color(0xFFADAEBC),
                fontSize: 16 * scale,
              ),
            ),
            style: GoogleFonts.inter(
              fontSize: 16 * scale,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0B1220),
            ),
          ),
        ),
        SizedBox(height: 24 * scale),
        GestureDetector(
          onTap: controller.goToVerify,
          child: Container(
            height: 56 * scale,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
              ),
              borderRadius: BorderRadius.circular(12 * scale),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 15 * scale,
                  offset: Offset(0, 10 * scale),
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 6 * scale,
                  offset: Offset(0, 4 * scale),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.send_rounded, color: Colors.white, size: 18 * scale),
                SizedBox(width: 12 * scale),
                Text(
                  'Envoyer le code',
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
        SizedBox(height: 16 * scale),
        OutlinedButton(
          onPressed: Get.back,
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
      ],
    );
  }
}

class _OtherOptions extends StatelessWidget {
  const _OtherOptions({required this.scale});

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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 15 * scale,
            offset: Offset(0, 10 * scale),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Autres options',
            style: GoogleFonts.poppins(
              fontSize: 18 * scale,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0B1220),
            ),
          ),
          SizedBox(height: 16 * scale),
          _OptionTile(
            scale: scale,
            icon: Icons.sms_outlined,
            iconBg: const Color(0x190EA5E9),
            title: 'Récupération par SMS',
            subtitle: 'Code envoyé sur votre téléphone',
            onTap: () => Get.find<LoginController>().setMode(LoginMode.phone),
          ),
          SizedBox(height: 12 * scale),
          _OptionTile(
            scale: scale,
            icon: Icons.lock_outline,
            iconBg: const Color(0x19F59E0B),
            title: 'Questions de sécurité',
            subtitle: 'Répondez à vos questions secrètes',
            onTap: controller.contactSupport,
          ),
        ],
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.scale,
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final double scale;
  final IconData icon;
  final Color iconBg;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16 * scale),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(12 * scale),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Row(
          children: [
            Container(
              width: 40 * scale,
              height: 40 * scale,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(12 * scale),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              alignment: Alignment.center,
              child: Icon(
                icon,
                color: const Color(0xFF0B1220),
                size: 20 * scale,
              ),
            ),
            SizedBox(width: 16 * scale),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF0B1220),
                      fontSize: 16 * scale,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4 * scale),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF475569),
                      fontSize: 14 * scale,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: const Color(0xFF94A3B8),
              size: 20 * scale,
            ),
          ],
        ),
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
        color: const Color(0x0C0EA5E9),
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0x330EA5E9)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32 * scale,
            height: 32 * scale,
            decoration: BoxDecoration(
              color: const Color(0x19176BFF),
              borderRadius: BorderRadius.circular(12 * scale),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.info_outline,
              color: const Color(0xFF176BFF),
              size: 18 * scale,
            ),
          ),
          SizedBox(width: 16 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Information de sécurité',
                  style: GoogleFonts.inter(
                    fontSize: 16 * scale,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0B1220),
                  ),
                ),
                SizedBox(height: 8 * scale),
                Text(
                  'Le code de vérification sera valide pendant 10 minutes. Vérifiez aussi vos spams si vous ne recevez pas l\'email.',
                  style: GoogleFonts.inter(
                    fontSize: 14 * scale,
                    color: const Color(0xFF475569),
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

class _RecentActivity extends StatelessWidget {
  const _RecentActivity({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final items = [
      (
        icon: Icons.smartphone_outlined,
        bg: const Color(0x3316A34A),
        title: 'Dernière connexion',
        subtitle: 'iPhone • Aujourd\'hui à 14:30',
        active: true,
      ),
      (
        icon: Icons.laptop_mac_outlined,
        bg: const Color(0x19F59E0B),
        title: 'Tentative échouée',
        subtitle: 'Web • Hier à 22:15',
        active: false,
      ),
    ];

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
            'Activité récente',
            style: GoogleFonts.poppins(
              fontSize: 18 * scale,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0B1220),
            ),
          ),
          SizedBox(height: 16 * scale),
          for (final item in items)
            Padding(
              padding: EdgeInsets.only(bottom: 12 * scale),
              child: Container(
                padding: EdgeInsets.all(16 * scale),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(12 * scale),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40 * scale,
                      height: 40 * scale,
                      decoration: BoxDecoration(
                        color: item.bg,
                        borderRadius: BorderRadius.circular(12 * scale),
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        item.icon,
                        size: 18 * scale,
                        color: const Color(0xFF0B1220),
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
                              fontSize: 16 * scale,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF0B1220),
                            ),
                          ),
                          SizedBox(height: 4 * scale),
                          Text(
                            item.subtitle,
                            style: GoogleFonts.inter(
                              fontSize: 14 * scale,
                              color: const Color(0xFF475569),
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
      ),
    );
  }
}

class _HelpOptions extends StatelessWidget {
  const _HelpOptions({required this.scale});

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
            'Besoin d\'aide ?',
            style: GoogleFonts.poppins(
              fontSize: 18 * scale,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0B1220),
            ),
          ),
          SizedBox(height: 16 * scale),
          _HelpTile(
            scale: scale,
            icon: Icons.email_outlined,
            label: 'Mot de passe oublié',
            onTap: controller.resendCode,
          ),
          SizedBox(height: 12 * scale),
          _HelpTile(
            scale: scale,
            icon: Icons.support_agent_outlined,
            label: 'Contacter le support',
            onTap: controller.contactSupport,
          ),
        ],
      ),
    );
  }
}

class _HelpTile extends StatelessWidget {
  const _HelpTile({
    required this.scale,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final double scale;
  final IconData icon;
  final String label;
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

class _TipsCard extends StatelessWidget {
  const _TipsCard({required this.scale});

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
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15 * scale,
            offset: Offset(0, 10 * scale),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 64 * scale,
            height: 64 * scale,
            decoration: BoxDecoration(
              color: const Color(0x19176BFF),
              borderRadius: BorderRadius.circular(9999),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.security_outlined,
              color: const Color(0xFF176BFF),
              size: 28 * scale,
            ),
          ),
          SizedBox(height: 16 * scale),
          Text(
            'Toujours bloqué ?',
            style: GoogleFonts.poppins(
              fontSize: 18 * scale,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0B1220),
            ),
          ),
          SizedBox(height: 12 * scale),
          Text(
            'Notre équipe support est là pour vous aider 24h/24.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14 * scale,
              color: const Color(0xFF475569),
              height: 1.5,
            ),
          ),
          SizedBox(height: 20 * scale),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap:
                      () =>
                          Get.find<ForgotPasswordController>().contactSupport(),
                  child: Container(
                    height: 48 * scale,
                    decoration: BoxDecoration(
                      color: const Color(0xFF176BFF),
                      borderRadius: BorderRadius.circular(12 * scale),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Appeler',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16 * scale,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16 * scale),
              Expanded(
                child: OutlinedButton(
                  onPressed:
                      () =>
                          Get.find<ForgotPasswordController>().contactSupport(),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF176BFF), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12 * scale),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14 * scale),
                    backgroundColor: const Color(0x19FFB800),
                  ),
                  child: Text(
                    'Email',
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
        ],
      ),
    );
  }
}

class _LegalFooter extends StatelessWidget {
  const _LegalFooter({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'En continuant, vous acceptez nos',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 12 * scale,
            color: const Color(0xFF475569),
          ),
        ),
        SizedBox(height: 8 * scale),
        Text(
          'conditions d\'utilisation',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 12 * scale,
            color: const Color(0xFF176BFF),
            decoration: TextDecoration.underline,
          ),
        ),
        SizedBox(height: 8 * scale),
        Text(
          'et notre politique de confidentialité',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 12 * scale,
            color: const Color(0xFF176BFF),
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }
}

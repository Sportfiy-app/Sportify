import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/profile_security_phone_controller.dart';

class ProfileSecurityPhoneView extends GetView<ProfileSecurityPhoneController> {
  const ProfileSecurityPhoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: SafeArea(
        child: Column(
          children: [
            _Header(onBack: Get.back),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  const designWidth = 375.0;
                  final width = constraints.hasBoundedWidth ? constraints.maxWidth : MediaQuery.of(context).size.width;
                  final scale = (width / designWidth).clamp(0.9, 1.1);

                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 24 * scale),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: designWidth * scale),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _HeroBanner(scale: scale),
                          SizedBox(height: 18 * scale),
                          _InfoBubble(scale: scale),
                          SizedBox(height: 22 * scale),
                          _CurrentPhoneCard(scale: scale),
                          SizedBox(height: 22 * scale),
                          _UpdateCard(scale: scale),
                          SizedBox(height: 16 * scale),
                          _VerificationNote(scale: scale),
                          SizedBox(height: 20 * scale),
                          _PrimaryAction(scale: scale, onTap: controller.submit),
                          SizedBox(height: 28 * scale),
                          _UsageSection(scale: scale),
                          SizedBox(height: 24 * scale),
                          _SecurityFeaturesSection(scale: scale),
                          SizedBox(height: 24 * scale),
                          _AlternativeMethodsSection(scale: scale),
                          SizedBox(height: 24 * scale),
                          _ActivityTimeline(scale: scale),
                          SizedBox(height: 24 * scale),
                          _FaqSection(scale: scale),
                          SizedBox(height: 28 * scale),
                          _SupportCard(scale: scale),
                          SizedBox(height: 20 * scale),
                          _Footer(scale: scale),
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
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
            style: IconButton.styleFrom(
              backgroundColor: const Color(0xFFF1F5F9),
              padding: const EdgeInsets.all(10),
              shape: const CircleBorder(),
            ),
          ),
          Expanded(
            child: Text(
              'Mon numéro de téléphone',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 19, fontWeight: FontWeight.w600),
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
        borderRadius: BorderRadius.circular(20 * scale),
        gradient: const LinearGradient(
          colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(color: const Color(0x33176BFF), blurRadius: 24 * scale, offset: Offset(0, 16 * scale)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56 * scale,
            height: 56 * scale,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16 * scale),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.phone_iphone_rounded, color: Colors.white, size: 30 * scale),
          ),
          SizedBox(width: 18 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sécurisez vos accès',
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 18 * scale, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 6 * scale),
                Text(
                  'Ce numéro protège votre compte Sportify, reçoit les codes de connexion et vous alerte en cas d’activité suspecte.',
                  style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.85), fontSize: 14 * scale, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoBubble extends StatelessWidget {
  const _InfoBubble({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: const Color(0x190EA5E9),
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0x330EA5E9)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, color: const Color(0xFF0EA5E9), size: 22 * scale),
          SizedBox(width: 12 * scale),
          Expanded(
            child: Text(
              'Ce numéro est utilisé pour la vérification 2FA, la récupération de compte et les notifications critiques.',
              style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 13.5 * scale, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _CurrentPhoneCard extends GetView<ProfileSecurityPhoneController> {
  const _CurrentPhoneCard({required this.scale});

  final double scale;

  String _maskedNumber(String value) {
    if (value.length <= 6) {
      return value;
    }
    final dialCodeEnd = value.indexOf(' ');
    if (dialCodeEnd == -1) return value;
    final prefix = value.substring(0, dialCodeEnd + 2);
    final suffix = value.substring(value.length - 2);
    return '$prefix•• •• •• $suffix';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 18 * scale, offset: Offset(0, 10 * scale)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Numéro actuel', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 4 * scale),
                decoration: BoxDecoration(
                  color: const Color(0x3316A34A),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  children: [
                    Icon(Icons.verified_rounded, color: const Color(0xFF16A34A), size: 16 * scale),
                    SizedBox(width: 6 * scale),
                    Text('Actif', style: GoogleFonts.inter(color: const Color(0xFF15803D), fontSize: 12 * scale, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 18 * scale),
          Obx(
            () => Text(
              _maskedNumber(controller.currentPhone.value),
              style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 20 * scale, fontWeight: FontWeight.w700, letterSpacing: 0.5),
            ),
          ),
          SizedBox(height: 8 * scale),
          Text(
            'Vérifié récemment • Dernière mise à jour le ${DateTime.now().day} ${_monthLabel(DateTime.now().month)} ${DateTime.now().year}',
            style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale),
          ),
        ],
      ),
    );
  }

  String _monthLabel(int month) {
    const months = [
      'janv.',
      'févr.',
      'mars',
      'avr.',
      'mai',
      'juin',
      'juil.',
      'août',
      'sept.',
      'oct.',
      'nov.',
      'déc.'
    ];
    return months[(month - 1).clamp(0, months.length - 1)];
  }
}

class _UpdateCard extends GetView<ProfileSecurityPhoneController> {
  const _UpdateCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Modifier mon numéro', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
          SizedBox(height: 6 * scale),
          Text('Choisissez le pays puis saisissez votre nouveau numéro de téléphone.', style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 13 * scale)),
          SizedBox(height: 18 * scale),
          Obx(
            () => GestureDetector(
              onTap: controller.openCountryPicker,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 14 * scale),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.circular(14 * scale),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    Text(controller.selectedCountry.value.flag, style: TextStyle(fontSize: 20 * scale)),
                    SizedBox(width: 12 * scale),
                    Expanded(
                      child: Text(
                        '${controller.selectedCountry.value.name} (${controller.selectedCountry.value.dialCode})',
                        style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Icon(Icons.expand_more_rounded, color: const Color(0xFF94A3B8), size: 20 * scale),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 14 * scale),
          Row(
            children: [
              Obx(
                () => Container(
                  padding: EdgeInsets.symmetric(horizontal: 14 * scale, vertical: 16 * scale),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F7F7),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14 * scale),
                      bottomLeft: Radius.circular(14 * scale),
                    ),
                  ),
                  child: Text(
                    controller.selectedCountry.value.dialCode,
                    style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Expanded(
                child: Obx(
                  () => TextField(
                    controller: controller.phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: '6 12 34 56 78',
                      hintStyle: GoogleFonts.inter(color: const Color(0xFFB8B8B8)),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 16 * scale),
                      filled: true,
                      fillColor: const Color(0xFFF7F7F7),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(14 * scale),
                          bottomRight: Radius.circular(14 * scale),
                        ),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(14 * scale),
                          bottomRight: Radius.circular(14 * scale),
                        ),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(14 * scale),
                          bottomRight: Radius.circular(14 * scale),
                        ),
                        borderSide: const BorderSide(color: Color(0xFF176BFF)),
                      ),
                      errorText: controller.phoneError.value.isEmpty ? null : controller.phoneError.value,
                      errorStyle: GoogleFonts.inter(color: const Color(0xFFEF4444), fontSize: 12 * scale),
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

class _VerificationNote extends StatelessWidget {
  const _VerificationNote({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.sms_outlined, color: const Color(0xFF176BFF), size: 18 * scale),
        SizedBox(width: 8 * scale),
        Expanded(
          child: Text(
            'Après validation, un code de vérification sera envoyé par SMS pour confirmer la possession du nouveau numéro.',
            style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale, height: 1.5),
          ),
        ),
      ],
    );
  }
}

class _PrimaryAction extends StatelessWidget {
  const _PrimaryAction({required this.scale, required this.onTap});

  final double scale;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 56 * scale,
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16 * scale)),
            ),
            child: Ink(
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF0055FF), Color(0xFF33AAFF)]),
                borderRadius: BorderRadius.circular(16 * scale),
              ),
              child: Center(
                child: Text('Modifier le numéro', style: GoogleFonts.inter(color: Colors.white, fontSize: 16 * scale, fontWeight: FontWeight.w600)),
              ),
            ),
          ),
        ),
        SizedBox(height: 10 * scale),
        Text(
          'Cette action lancera une vérification instantanée.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 12.5 * scale),
        ),
      ],
    );
  }
}

class _UsageSection extends StatelessWidget {
  const _UsageSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final items = [
      (
        icon: Icons.shield_outlined,
        color: const Color(0x3316A34A),
        title: 'Authentification 2FA',
        description: 'Double vérification pour vos connexions sensibles.'
      ),
      (
        icon: Icons.lock_reset_outlined,
        color: const Color(0x33F59E0B),
        title: 'Récupération de compte',
        description: 'Réinitialisation rapide de votre mot de passe en cas d’oubli.'
      ),
      (
        icon: Icons.notifications_active_outlined,
        color: const Color(0x33176BFF),
        title: 'Alertes de sécurité',
        description: 'Notifications immédiates sur les actions critiques du compte.'
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Utilisation de votre numéro', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600)),
        SizedBox(height: 12 * scale),
        ...items.map(
          (item) => Padding(
            padding: EdgeInsets.only(bottom: 12 * scale),
            child: Container(
              padding: EdgeInsets.all(16 * scale),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16 * scale),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 44 * scale,
                    height: 44 * scale,
                    decoration: BoxDecoration(color: item.color, borderRadius: BorderRadius.circular(14 * scale)),
                    alignment: Alignment.center,
                    child: Icon(item.icon, color: const Color(0xFF0B1220), size: 20 * scale),
                  ),
                  SizedBox(width: 14 * scale),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.title, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600)),
                        SizedBox(height: 6 * scale),
                        Text(item.description, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale, height: 1.45)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SecurityFeaturesSection extends StatelessWidget {
  const _SecurityFeaturesSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final features = [
      ('Chiffrement de bout en bout', 'Vos données et messages sont protégés par un chiffrement avancé.'),
      ('Validation obligatoire', 'Chaque changement doit être confirmé par un code OTP unique.'),
      ('Détection de doublons', 'Un même numéro ne peut pas être utilisé sur plusieurs comptes.'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Fonctionnalités de sécurité', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600)),
        SizedBox(height: 12 * scale),
        ...features.map(
          (item) => Padding(
            padding: EdgeInsets.only(bottom: 12 * scale),
            child: Container(
              padding: EdgeInsets.all(16 * scale),
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
                      color: const Color(0xFF16A34A).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12 * scale),
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.check_rounded, color: const Color(0xFF16A34A), size: 18 * scale),
                  ),
                  SizedBox(width: 12 * scale),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.$1, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600)),
                        SizedBox(height: 4 * scale),
                        Text(item.$2, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale, height: 1.45)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AlternativeMethodsSection extends StatelessWidget {
  const _AlternativeMethodsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final alternatives = [
      (
        title: 'Application d’authentification',
        subtitle: 'Configurez Google Authenticator ou Authy pour générer des codes temporaires.',
        icon: Icons.qr_code_scanner_rounded
      ),
      (
        title: 'Codes de secours',
        subtitle: 'Téléchargez des codes uniques à conserver en lieu sûr pour débloquer votre compte.',
        icon: Icons.key_rounded
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Options alternatives', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600)),
        SizedBox(height: 12 * scale),
        ...alternatives.map(
          (item) => Padding(
            padding: EdgeInsets.only(bottom: 12 * scale),
            child: Container(
              padding: EdgeInsets.all(16 * scale),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16 * scale),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 44 * scale,
                    height: 44 * scale,
                    decoration: BoxDecoration(color: const Color(0x19176BFF), borderRadius: BorderRadius.circular(14 * scale)),
                    alignment: Alignment.center,
                    child: Icon(item.icon, color: const Color(0xFF176BFF), size: 22 * scale),
                  ),
                  SizedBox(width: 12 * scale),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.title, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600)),
                        SizedBox(height: 6 * scale),
                        Text(item.subtitle, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale, height: 1.45)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ActivityTimeline extends StatelessWidget {
  const _ActivityTimeline({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final activities = [
      ('Connexion vérifiée', 'Aujourd’hui • iPhone 15', Icons.check_circle_outline_rounded),
      ('Code SMS envoyé', 'Hier • Tentative de connexion', Icons.sms_outlined),
      ('Mot de passe modifié', '12 oct. • Via application', Icons.lock_reset_outlined),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Activité récente', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600)),
        SizedBox(height: 12 * scale),
        Container(
          padding: EdgeInsets.all(18 * scale),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16 * scale),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            children: activities
                .map(
                  (activity) => Padding(
                    padding: EdgeInsets.only(bottom: activity == activities.last ? 0 : 14 * scale),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 32 * scale,
                          height: 32 * scale,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(12 * scale),
                          ),
                          alignment: Alignment.center,
                          child: Icon(activity.$3, color: const Color(0xFF176BFF), size: 18 * scale),
                        ),
                        SizedBox(width: 12 * scale),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(activity.$1, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14.5 * scale, fontWeight: FontWeight.w600)),
                              SizedBox(height: 4 * scale),
                              Text(activity.$2, style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 12.5 * scale)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _FaqSection extends StatelessWidget {
  const _FaqSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final questions = [
      'Pourquoi dois-je vérifier mon numéro ?',
      'Que se passe-t-il si je ne reçois pas le SMS ?',
      'Puis-je utiliser un numéro étranger ?',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Questions fréquentes', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600)),
        SizedBox(height: 12 * scale),
        ...questions.map(
          (question) => Container(
            margin: EdgeInsets.only(bottom: 12 * scale),
            padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 14 * scale),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14 * scale),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                Expanded(child: Text(question, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14.5 * scale, fontWeight: FontWeight.w500))),
                Icon(Icons.expand_more_rounded, color: const Color(0xFF94A3B8), size: 20 * scale),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SupportCard extends StatelessWidget {
  const _SupportCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)]),
        borderRadius: BorderRadius.circular(18 * scale),
        boxShadow: [
          BoxShadow(color: const Color(0x33176BFF), blurRadius: 18 * scale, offset: Offset(0, 12 * scale)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44 * scale,
                height: 44 * scale,
                decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(14 * scale)),
                alignment: Alignment.center,
                child: Icon(Icons.headset_mic_rounded, color: Colors.white, size: 22 * scale),
              ),
              SizedBox(width: 12 * scale),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Besoin d’aide ?', style: GoogleFonts.inter(color: Colors.white, fontSize: 15.5 * scale, fontWeight: FontWeight.w600)),
                    SizedBox(height: 4 * scale),
                    Text('Notre équipe sécurité est disponible pour vous accompagner 7j/7.', style: GoogleFonts.inter(color: Colors.white70, fontSize: 13 * scale)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 18 * scale),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Get.snackbar('Support', 'Ouverture du chat très bientôt.'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF176BFF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 14 * scale),
                  ),
                  child: Text('Chat en direct', style: GoogleFonts.inter(fontSize: 14 * scale, fontWeight: FontWeight.w600)),
                ),
              ),
              SizedBox(width: 12 * scale),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Get.snackbar('Support', 'Contact email prochainement.'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white70),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
                    padding: EdgeInsets.symmetric(vertical: 14 * scale),
                  ),
                  child: Text('Envoyer un email', style: GoogleFonts.inter(fontSize: 14 * scale, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
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
    return Column(
      children: [
        Text('Sportify v1.0.0', style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 12 * scale)),
        SizedBox(height: 6 * scale),
        Text('© 2024 Sportify. Tous droits réservés.', style: GoogleFonts.inter(color: const Color(0xFFCBD5F5), fontSize: 12 * scale)),
      ],
    );
  }
}


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/register_controller.dart';

class RegisterTermsAndPrivacyView extends GetView<RegisterController> {
  const RegisterTermsAndPrivacyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
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
              child: _TermsContent(scale: scale),
            ),
          );
        },
      ),
    );
  }
}

class _TermsContent extends StatelessWidget {
  const _TermsContent({required this.scale});

  final double scale;

  double s(double value) => value * scale;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          border: const Border(
            left: BorderSide(color: Color(0xFFE5E7EB)),
            right: BorderSide(color: Color(0xFFE5E7EB)),
          ),
        ),
        child: Column(
          children: [
            _TermsTopBar(scale: scale),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: s(24)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: s(24)),
                    _TermsStepProgress(scale: scale),
                    SizedBox(height: s(24)),
                    _IntroText(scale: scale),
                    SizedBox(height: s(24)),
                    _DocumentCard(scale: scale),
                    SizedBox(height: s(24)),
                    _ConsentCard(scale: scale),
                    SizedBox(height: s(24)),
                    _InfoCards(scale: scale),
                    SizedBox(height: s(24)),
                    _StatsCard(scale: scale),
                    SizedBox(height: s(24)),
                    _ContinueSection(scale: scale),
                    SizedBox(height: s(32)),
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

class _TermsTopBar extends StatelessWidget {
  const _TermsTopBar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72 * scale,
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: [
          _TopButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: Get.back,
            scale: scale,
          ),
          const Spacer(),
          Row(
            mainAxisSize: MainAxisSize.min,
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
          SizedBox(width: 16 * scale),
          const SizedBox(width: 40),
        ],
      ),
    );
  }
}

class _TermsStepProgress extends StatelessWidget {
  const _TermsStepProgress({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Étape 2 sur 5',
              style: GoogleFonts.inter(
                color: const Color(0xFF475569),
                fontSize: 14 * scale,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Text(
              '40%',
              style: GoogleFonts.inter(
                color: const Color(0xFF176BFF),
                fontSize: 14 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 12 * scale),
        ClipRRect(
          borderRadius: BorderRadius.circular(9999),
          child: LinearProgressIndicator(
            value: 0.4,
            minHeight: 8 * scale,
            backgroundColor: const Color(0xFFE2E8F0),
            valueColor: const AlwaysStoppedAnimation(Color(0xFF176BFF)),
          ),
        ),
      ],
    );
  }
}

class _IntroText extends StatelessWidget {
  const _IntroText({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CGVU et Politique de confidentialité',
          style: GoogleFonts.poppins(
            color: const Color(0xFF0B1220),
            fontSize: 24 * scale,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 12 * scale),
        Text(
          'Veuillez lire et accepter nos conditions générales de vente et d\'utilisation ainsi que notre politique de confidentialité pour continuer.',
          style: GoogleFonts.inter(
            color: const Color(0xFF475569),
            fontSize: 16 * scale,
            height: 1.55,
          ),
        ),
      ],
    );
  }
}

class _DocumentCard extends StatelessWidget {
  const _DocumentCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final sections = _termsSections;
    return Container(
      padding: EdgeInsets.all(24 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 18 * scale,
            offset: Offset(0, 10 * scale),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final section in sections) ...[
            _SectionHeader(title: section.title, scale: scale, accent: section.accent),
            SizedBox(height: 12 * scale),
            if (section.subtitle != null)
              Padding(
                padding: EdgeInsets.only(bottom: 12 * scale),
                child: Text(
                  section.subtitle!,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF0B1220),
                    fontSize: 14 * scale,
                    height: 1.6,
                  ),
                ),
              ),
            ...section.paragraphs.map(
              (paragraph) => Padding(
                padding: EdgeInsets.only(bottom: 12 * scale),
                child: Text(
                  paragraph,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF0B1220),
                    fontSize: 14 * scale,
                    height: 1.6,
                  ),
                ),
              ),
            ),
            if (section.bullets.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(left: 8 * scale, bottom: 16 * scale),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: section.bullets
                      .map(
                        (bullet) => Padding(
                          padding: EdgeInsets.only(bottom: 8 * scale),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 16 * scale,
                                child: Text('•',
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFF0B1220),
                                      fontSize: 14 * scale,
                                    )),
                              ),
                              Expanded(
                                child: Text(
                                  bullet,
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF0B1220),
                                    fontSize: 14 * scale,
                                    height: 1.6,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            if (section != sections.last) SizedBox(height: 16 * scale),
          ],
          Text(
            'Dernière mise à jour : 15 octobre 2024',
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

class _ConsentCard extends GetView<RegisterController> {
  const _ConsentCard({required this.scale});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                      color: const Color(0xFF0B1220),
                      height: 1.6,
                    ),
                    children: const [
                      TextSpan(text: "J'accepte la "),
                      TextSpan(
                        text: "politique de confidentialité",
                        style: TextStyle(color: Color(0xFF176BFF), decoration: TextDecoration.underline),
                      ),
                      TextSpan(text: ' et les '),
                      TextSpan(
                        text: 'conditions générales de vente et d\'utilisation',
                        style: TextStyle(color: Color(0xFF176BFF), decoration: TextDecoration.underline),
                      ),
                      TextSpan(text: ' de Sportify.'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20 * scale),
          Container(
            padding: EdgeInsets.all(20 * scale),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(12 * scale),
              border: Border.all(color: const Color(0xFFDBEAFE)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 16 * scale,
                  height: 16 * scale,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4 * scale),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.info_outline,
                      size: 12 * scale, color: const Color(0xFF176BFF)),
                ),
                SizedBox(width: 12 * scale),
                Expanded(
                  child: Text(
                    'Ces documents définissent vos droits et nos engagements pour une utilisation sécurisée et transparente de Sportify.',
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
        ],
      ),
    );
  }
}

class _InfoCards extends StatelessWidget {
  const _InfoCards({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final cards = [
      _InfoCardData(
        icon: Icons.shield_outlined,
        iconBg: const Color(0x19176BFF),
        title: 'Protection des données',
        description: 'Vos données sont protégées selon le RGPD et hébergées en France.',
      ),
      _InfoCardData(
        icon: Icons.verified_user_outlined,
        iconBg: const Color(0x1916A34A),
        title: 'Droits utilisateur',
        description: 'Accès, rectification, effacement de vos données à tout moment.',
      ),
      _InfoCardData(
        icon: Icons.policy_outlined,
        iconBg: const Color(0x19FFB800),
        title: 'Conditions transparentes',
        description: 'Pas de clauses abusives, conditions claires et équitables.',
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
            'Informations légales',
            style: GoogleFonts.poppins(
              color: const Color(0xFF0B1220),
              fontSize: 18 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 20 * scale),
          Column(
            children: cards
                .map(
                  (card) => Padding(
                    padding: EdgeInsets.only(bottom: 16 * scale),
                    child: _InfoCardItem(scale: scale, data: card),
                  ),
                )
                .toList(),
          ),
          SizedBox(height: 24 * scale),
          Column(
            children: [
              Text(
                'Des questions ? Contactez-nous à',
                style: GoogleFonts.inter(
                  color: const Color(0xFF475569),
                  fontSize: 12 * scale,
                ),
              ),
              SizedBox(height: 6 * scale),
              Text(
                'support@sportify.com',
                style: GoogleFonts.inter(
                  color: const Color(0xFF176BFF),
                  fontSize: 16 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  const _StatsCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final stats = [
      _StatItem(value: '15K+', label: 'Sportifs actifs', color: const Color(0xFF176BFF)),
      _StatItem(value: '500+', label: 'Terrains partenaires', color: const Color(0xFF16A34A)),
      _StatItem(value: '4.8', label: 'Note moyenne', color: const Color(0xFFFFB800)),
    ];
    return Container(
      padding: EdgeInsets.all(24 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Text(
            'Rejoignez la communauté Sportify',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: const Color(0xFF0B1220),
              fontSize: 18 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 24 * scale),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: stats
                .map(
                  (item) => Expanded(
                    child: Column(
                      children: [
                        Text(
                          item.value,
                          style: GoogleFonts.poppins(
                            color: item.color,
                            fontSize: 24 * scale,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 8 * scale),
                        Text(
                          item.label,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            color: const Color(0xFF475569),
                            fontSize: 12 * scale,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _ContinueSection extends GetView<RegisterController> {
  const _ContinueSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Obx(
            () => ElevatedButton(
              onPressed: controller.acceptsTerms.value
                  ? controller.continueRegistration
                  : null,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 18 * scale),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12 * scale),
                ),
                backgroundColor: const Color(0xFF176BFF),
                disabledBackgroundColor: const Color(0xFFE2E8F0),
              ),
              child: Text(
                'Continuer',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 16 * scale),
        Container(
          padding: EdgeInsets.all(20 * scale),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16 * scale),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            children: [
              Text(
                'Ou continuez avec',
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
                        side: const BorderSide(color: Color(0xFFE2E8F0), width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12 * scale),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14 * scale),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.g_mobiledata_rounded,
                              color: const Color(0xFF0B1220), size: 20 * scale),
                          SizedBox(width: 8 * scale),
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12 * scale),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14 * scale),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.apple,
                              color: const Color(0xFF0B1220), size: 20 * scale),
                          SizedBox(width: 8 * scale),
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
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.scale,
    this.accent = Colors.transparent,
  });

  final String title;
  final double scale;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            color: accent == Colors.transparent ? const Color(0xFF0B1220) : accent,
            fontSize: 18 * scale,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4 * scale),
        Container(
          width: 48 * scale,
          height: 2 * scale,
          decoration: BoxDecoration(
            color: accent == Colors.transparent ? const Color(0xFFE2E8F0) : accent,
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ],
    );
  }
}

class _TopButton extends StatelessWidget {
  const _TopButton({required this.icon, required this.onTap, required this.scale});

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
        child: Icon(icon, color: const Color(0xFF0B1220), size: 18 * scale),
      ),
    );
  }
}

class _InfoCardData {
  const _InfoCardData({
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final Color iconBg;
  final String title;
  final String description;
}

class _InfoCardItem extends StatelessWidget {
  const _InfoCardItem({required this.scale, required this.data});

  final double scale;
  final _InfoCardData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32 * scale,
            height: 32 * scale,
            decoration: BoxDecoration(
              color: data.iconBg,
              borderRadius: BorderRadius.circular(12 * scale),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            alignment: Alignment.center,
            child: Icon(data.icon, size: 16 * scale, color: const Color(0xFF0B1220)),
          ),
          SizedBox(height: 12 * scale),
          Text(
            data.title,
            style: GoogleFonts.inter(
              color: const Color(0xFF0B1220),
              fontSize: 14 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6 * scale),
          Text(
            data.description,
            style: GoogleFonts.inter(
              color: const Color(0xFF475569),
              fontSize: 12 * scale,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem {
  const _StatItem({required this.value, required this.label, required this.color});

  final String value;
  final String label;
  final Color color;
}

class TermsSection {
  const TermsSection({
    required this.title,
    required this.paragraphs,
    this.subtitle,
    this.bullets = const [],
    this.accent = const Color(0xFF176BFF),
  });

  final String title;
  final String? subtitle;
  final List<String> paragraphs;
  final List<String> bullets;
  final Color accent;
}

final List<TermsSection> _termsSections = [
  const TermsSection(
    title: 'Conditions Générales de Vente et d\'Utilisation',
    paragraphs: [
      "Les présentes conditions régissent l'utilisation de l'application Sportify. L'utilisation de la plateforme implique l'acceptation pleine et entière des CGVU.",
    ],
    bullets: [
      "Services proposés : réservations, mise en relation, organisation d'événements, messagerie intégrée.",
      "Inscription et compte utilisateur : informations exactes, confidentialité des identifiants.",
      "Utilisation des services : interdiction d'usage frauduleux, diffusion de contenus illicites, harcèlement.",
      "Tarification et paiement : tarifs TTC, paiement sécurisé, frais clairement indiqués.",
      "Annulation et remboursement : selon les modalités précisées lors de la réservation.",
      "Responsabilité : Sportify agit comme intermédiaire entre utilisateurs et prestataires.",
    ],
  ),
  const TermsSection(
    title: 'Politique de Confidentialité',
    paragraphs: [
      "Nous collectons uniquement les données nécessaires à la bonne exécution de nos services : identification, localisation, historique sportif et données de paiement sécurisées.",
    ],
    bullets: [
      "Finalités : fournir et améliorer les services, proposer des partenaires compatibles, personnaliser l'expérience.",
      'Base légale : consentement, exécution du contrat, intérêt légitime, obligations légales.',
      'Partage : prestataires sportifs, partenaires techniques, autorités sur demande.',
      "Conservation : durée limitée aux finalités, respect des obligations légales.",
      'Sécurité : chiffrement SSL, hébergement en France, conformité RGPD.',
      "Cookies : amélioration de l'expérience, gestion dans les paramètres.",
      "Droits : accès, rectification, effacement, limitation, portabilité, opposition, retrait du consentement (contact : dpo@sportify.com).",
    ],
    accent: Color(0xFF176BFF),
  ),
];

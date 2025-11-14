import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/profile_terms_controller.dart';

class ProfileTermsView extends GetView<ProfileTermsController> {
  const ProfileTermsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            const designWidth = 375.0;
            final width = constraints.hasBoundedWidth ? constraints.maxWidth : MediaQuery.of(context).size.width;
            final scale = (width / designWidth).clamp(0.85, 1.1);

            return Column(
              children: [
                _Header(scale: scale),
                _HeroSection(scale: scale),
                _TabBar(scale: scale),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 20 * scale),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: designWidth * scale),
                      child: Column(
                        children: [
                          _PrivacySettingsCard(scale: scale),
                          SizedBox(height: 24 * scale),
                          _TermsSection(scale: scale),
                          SizedBox(height: 24 * scale),
                          _PrivacySection(scale: scale),
                          SizedBox(height: 24 * scale),
                          _UsageSection(scale: scale),
                          SizedBox(height: 24 * scale),
                          _CookiesSection(scale: scale),
                          SizedBox(height: 24 * scale),
                          _RightsSection(scale: scale),
                          SizedBox(height: 24 * scale),
                          _SupportSection(scale: scale),
                          SizedBox(height: 24 * scale),
                          _UpdatesSection(scale: scale),
                          SizedBox(height: 24 * scale),
                          _ClosingSection(scale: scale),
                          SizedBox(height: 32 * scale),
                        ],
                      ),
                    ),
                  ),
                ),
                _StickyActions(scale: scale),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 14 * scale),
      child: Row(
        children: [
          IconButton(
            onPressed: Get.back,
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
            style: IconButton.styleFrom(
              backgroundColor: const Color(0xFFF3F4F6),
              padding: EdgeInsets.all(10 * scale),
              shape: const CircleBorder(),
            ),
          ),
          Expanded(
            child: Text(
              'Conditions & Confidentialité',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: const Color(0xFF0B1220),
                fontSize: 19 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: 44 * scale),
        ],
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16 * scale, 16 * scale, 16 * scale, 12 * scale),
      padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 18 * scale),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(24 * scale),
        boxShadow: [BoxShadow(color: const Color(0x33176BFF), blurRadius: 24 * scale, offset: Offset(0, 16 * scale))],
      ),
      child: Column(
        children: [
          Container(
            width: 64 * scale,
            height: 64 * scale,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.policy_rounded, color: Colors.white, size: 32 * scale),
          ),
          SizedBox(height: 16 * scale),
          Text(
            'Votre confiance, notre priorité',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 20 * scale, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 10 * scale),
          Text(
            'Découvrez comment nous protégeons vos données et respectons votre vie privée sur Sportify',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.9), fontSize: 14 * scale, height: 1.5),
          ),
          SizedBox(height: 12 * scale),
          Text(
            'Dernière mise à jour : 15 octobre 2024',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.7), fontSize: 12 * scale),
          ),
        ],
      ),
    );
  }
}

class _TabBar extends GetView<ProfileTermsController> {
  const _TabBar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44 * scale,
      child: Obx(
        () => ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16 * scale),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final tab = controller.tabs[index];
            final isActive = controller.activeTabId.value == tab.id;
            return GestureDetector(
              onTap: () => controller.setActiveTab(tab.id),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 18 * scale, vertical: 10 * scale),
                decoration: BoxDecoration(
                  color: isActive ? const Color(0xFF176BFF) : const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: isActive ? const Color(0xFF176BFF) : const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.circle,
                      size: 10 * scale,
                      color: isActive ? Colors.white : const Color(0xFF94A3B8),
                    ),
                    SizedBox(width: 8 * scale),
                    Text(
                      tab.label,
                      style: GoogleFonts.inter(
                        color: isActive ? Colors.white : const Color(0xFF0B1220),
                        fontSize: 14 * scale,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (_, __) => SizedBox(width: 12 * scale),
          itemCount: controller.tabs.length,
        ),
      ),
    );
  }
}

class _PrivacySettingsCard extends StatelessWidget {
  const _PrivacySettingsCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final settings = [
      (
        title: 'Partage de données analytiques',
        description: 'Nous aider à améliorer l’application',
        enabled: true,
      ),
      (
        title: 'Notifications marketing',
        description: 'Recevoir des offres personnalisées',
        enabled: false,
      ),
      (
        title: 'Géolocalisation',
        description: 'Trouver des terrains près de vous',
        enabled: true,
      ),
      (
        title: 'Profil public',
        description: 'Être visible par d’autres joueurs',
        enabled: true,
      ),
    ];

    return _Card(
      scale: scale,
      title: 'Paramètres de confidentialité',
      child: Column(
        children: settings
            .map(
              (setting) => Container(
                margin: EdgeInsets.only(bottom: 12 * scale),
                padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 14 * scale),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFDFEFF), Color(0xFFF8FAFC)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16 * scale),
                  border: Border.all(color: const Color(0xFFE2E8F0).withValues(alpha: 0.6)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            setting.title,
                            style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 4 * scale),
                          Text(
                            setting.description,
                            style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: setting.enabled,
                      onChanged: (_) => Get.snackbar(setting.title, 'Modification gérée ailleurs dans l’app.'),
                      activeColor: Colors.white,
                      activeTrackColor: const Color(0xFF176BFF),
                      inactiveTrackColor: const Color(0xFFCBD5E1),
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

class _TermsSection extends StatelessWidget {
  const _TermsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return _Card(
      scale: scale,
      title: 'Conditions Générales d’Utilisation',
      subtitle: 'Version 2.1 – Effective du 15 octobre 2024',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionBlock(
            scale: scale,
            title: '1. Acceptation des conditions',
            content:
                'En utilisant l’application Sportify, vous acceptez d’être lié par ces conditions générales d’utilisation. Si vous n’acceptez pas ces conditions, veuillez ne pas utiliser notre service.',
            highlights: const [
              'L’utilisation implique l’acceptation complète',
              'Mise à jour des conditions notifiée',
              'Âge minimum requis : 16 ans',
            ],
          ),
          SizedBox(height: 16 * scale),
          _SectionBlock(
            scale: scale,
            title: '2. Compte utilisateur et responsabilités',
            content:
                'Vous êtes responsable de maintenir la confidentialité de votre compte et de toutes les activités qui se produisent sous votre compte.',
            highlights: const [
              'Fournir des informations exactes et à jour',
              'Protéger vos identifiants de connexion',
              'Respecter les autres utilisateurs',
              'Ne pas créer de faux comptes',
            ],
            highlightColor: const Color(0xFFF59E0B),
          ),
          SizedBox(height: 16 * scale),
          _SectionBlock(
            scale: scale,
            title: '3. Réservations et paiements',
            content: 'Toutes les réservations sont soumises à disponibilité et aux conditions spécifiques de chaque établissement partenaire.',
            highlights: const [
              'Paiement sécurisé par carte bancaire',
              'Facturation immédiate lors de la réservation',
              'Remboursement selon conditions d’annulation',
              'Annulation gratuite jusqu’à 2h avant',
              'Aucun remboursement moins de 30min avant',
            ],
            highlightColor: const Color(0xFF16A34A),
            secondaryHighlights: const [
              'Annulation gratuite jusqu’à 2h avant',
              'Frais d’annulation de 30% entre 2h et 30min',
              'Aucun remboursement moins de 30min avant',
            ],
            secondaryColor: const Color(0xFF0EA5E9),
          ),
          SizedBox(height: 16 * scale),
          _SectionBlock(
            scale: scale,
            title: '4. Comportements interdits',
            highlights: const [
              'Harcèlement – Tout comportement abusif envers d’autres utilisateurs',
              'Contenu inapproprié – Publication de contenu offensant ou illégal',
              'Fraude – Utilisation frauduleuse des services de paiement',
            ],
            highlightColor: const Color(0xFFEF4444),
          ),
        ],
      ),
    );
  }
}

class _PrivacySection extends StatelessWidget {
  const _PrivacySection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return _Card(
      scale: scale,
      title: 'Politique de Confidentialité',
      subtitle: 'Protection et utilisation de vos données personnelles',
      backgroundColor: const Color(0xFFF9FAFB),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SubTitle(scale: scale, icon: Icons.person_outline, text: 'Données que nous collectons'),
          SizedBox(height: 12 * scale),
          _InfoCard(
            scale: scale,
            title: 'Informations personnelles',
            color: const Color(0xFF176BFF),
            entries: const ['Nom, prénom, adresse email', 'Numéro de téléphone', 'Photo de profil (optionnelle)', 'Préférences sportives'],
          ),
          SizedBox(height: 12 * scale),
          _InfoCard(
            scale: scale,
            title: 'Données de localisation',
            color: const Color(0xFF16A34A),
            entries: const ['Position GPS (avec votre autorisation)', 'Adresses de réservation', 'Historique des lieux fréquentés'],
          ),
          SizedBox(height: 12 * scale),
          _InfoCard(
            scale: scale,
            title: 'Données d’utilisation',
            color: const Color(0xFF0EA5E9),
            entries: const [
              'Historique des réservations',
              'Interactions avec l’application',
              'Préférences et paramètres',
              'Données de performance (anonymisées)',
            ],
          ),
          SizedBox(height: 20 * scale),
          _SubTitle(scale: scale, icon: Icons.lock_outline, text: 'Comment nous utilisons vos données'),
          SizedBox(height: 12 * scale),
          _MultiLineCard(
            scale: scale,
            sections: const [
              ('Amélioration du service', 'Personnaliser votre expérience et recommander des terrains adaptés'),
              ('Communications', 'Vous informer des réservations, promotions et nouveautés'),
              ('Sécurité et fraude', 'Protéger votre compte et prévenir les activités frauduleuses'),
            ],
            colors: const [Color(0xFF176BFF), Color(0xFF16A34A), Color(0xFFF59E0B)],
          ),
        ],
      ),
    );
  }
}

class _UsageSection extends StatelessWidget {
  const _UsageSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return _Card(
      scale: scale,
      title: 'Utilisation des données',
      subtitle: 'Transparence sur le traitement de vos informations',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionBlock(
            scale: scale,
            title: 'Partage de données',
            content: 'Nous partageons certaines informations avec les établissements sportifs pour faciliter vos réservations.',
            highlights: const ['Données partagées : Nom, téléphone, créneaux réservés'],
            highlightColor: const Color(0xFF176BFF),
          ),
          SizedBox(height: 16 * scale),
          _SectionBlock(
            scale: scale,
            title: 'Nous ne vendons jamais vos données',
            content: 'Vos informations personnelles ne sont jamais vendues à des tiers à des fins commerciales.',
            highlightColor: const Color(0xFF16A34A),
          ),
          SizedBox(height: 16 * scale),
          _SectionBlock(
            scale: scale,
            title: 'Durée de conservation',
            highlights: const [
              'Données de profil – Tant que votre compte est actif – Permanent',
              'Historique réservations – Pour le suivi fiscal et légal – 3 ans',
              'Données analytiques – Anonymisées après traitement – 1 an',
            ],
          ),
        ],
      ),
    );
  }
}

class _CookiesSection extends StatelessWidget {
  const _CookiesSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return _Card(
      scale: scale,
      title: 'Politique des Cookies',
      subtitle: 'Comment nous utilisons les cookies et technologies similaires',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionBlock(
            scale: scale,
            title: 'Types de cookies utilisés',
            entries: const [
              'Cookies essentiels – Nécessaires au fonctionnement de l’application – Exemples : Session utilisateur, panier de réservation, préférences de langue',
              'Cookies analytiques – Pour comprendre l’utilisation de l’app – Exemples : Pages visitées, temps de session, fonctionnalités utilisées',
              'Cookies marketing – Pour personnaliser le contenu et les offres – Exemples : Recommandations personnalisées, publicités ciblées',
            ],
          ),
          SizedBox(height: 16 * scale),
          _SectionBlock(
            scale: scale,
            title: 'Gestion des cookies',
            content: 'Vous pouvez modifier vos préférences de cookies à tout moment dans les paramètres de l’application.',
            highlights: const ['Désactiver certains cookies peut affecter le fonctionnement de l’application.'],
            highlightColor: const Color(0xFFF59E0B),
          ),
          SizedBox(height: 16 * scale),
          _PrimaryButton(
            scale: scale,
            icon: Icons.tune_rounded,
            label: 'Gérer les cookies',
            backgroundColor: const Color(0xFF0EA5E9),
            onTap: () => Get.snackbar('Cookies', 'Gestion des cookies prochainement disponible.'),
          ),
        ],
      ),
    );
  }
}

class _RightsSection extends StatelessWidget {
  const _RightsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final rights = [
      (
        title: 'Droit d’accès',
        description: 'Consulter toutes les données personnelles que nous détenons sur vous.',
        action: 'Demander l’accès →',
        color: const Color(0xFF176BFF),
      ),
      (
        title: 'Droit de rectification',
        description: 'Corriger ou mettre à jour vos informations personnelles.',
        action: 'Modifier mes données →',
        color: const Color(0xFFFFB800),
      ),
      (
        title: 'Droit à l’effacement',
        description: 'Supprimer définitivement vos données personnelles.',
        action: 'Supprimer mon compte →',
        color: const Color(0xFFEF4444),
      ),
      (
        title: 'Droit à la portabilité',
        description: 'Récupérer vos données dans un format structuré.',
        action: 'Exporter mes données →',
        color: const Color(0xFF0EA5E9),
      ),
      (
        title: 'Droit d’opposition',
        description: 'Vous opposer au traitement de vos données à des fins marketing.',
        action: 'Gérer mes préférences →',
        color: const Color(0xFFF59E0B),
      ),
    ];

    return _Card(
      scale: scale,
      title: 'Vos Droits',
      subtitle: 'Conformément au RGPD, vous disposez de plusieurs droits',
      child: Column(
        children: rights
            .map(
              (right) => Container(
                margin: EdgeInsets.only(bottom: 12 * scale),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16 * scale),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 16 * scale, offset: Offset(0, 12 * scale))],
                ),
                padding: EdgeInsets.all(16 * scale),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44 * scale,
                      height: 44 * scale,
                      decoration: BoxDecoration(
                        color: right.color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12 * scale),
                      ),
                      alignment: Alignment.center,
                      child: Icon(Icons.shield_outlined, color: right.color, size: 20 * scale),
                    ),
                    SizedBox(width: 14 * scale),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(right.title, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
                          SizedBox(height: 6 * scale),
                          Text(right.description, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale, height: 1.5)),
                          SizedBox(height: 10 * scale),
                          GestureDetector(
                            onTap: () => Get.snackbar(right.title, 'Processus en cours de mise en place.'),
                            child: Text(
                              right.action,
                              style: GoogleFonts.inter(color: right.color, fontSize: 13 * scale, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
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

class _SupportSection extends StatelessWidget {
  const _SupportSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final contacts = [
      (
        icon: Icons.mail_outline,
        title: 'Email',
        subtitle: 'privacy@sportify.app',
        color: const Color(0xFF176BFF),
      ),
      (
        icon: Icons.chat_bubble_outline,
        title: 'Chat en direct',
        subtitle: 'Disponible 9h-18h',
        color: const Color(0xFF16A34A),
      ),
      (
        icon: Icons.help_outline,
        title: 'FAQ',
        subtitle: 'Réponses instantanées',
        color: const Color(0xFFFFB800),
      ),
    ];

    return _Card(
      scale: scale,
      title: 'Support & Contact',
      subtitle: 'Nous sommes là pour vous aider',
      child: Column(
        children: [
          ...contacts.map(
            (contact) => Container(
              margin: EdgeInsets.only(bottom: 12 * scale),
              padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 14 * scale),
              decoration: BoxDecoration(
                color: contact.color.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(16 * scale),
                border: Border.all(color: contact.color.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40 * scale,
                    height: 40 * scale,
                    decoration: BoxDecoration(color: contact.color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(12 * scale)),
                    alignment: Alignment.center,
                    child: Icon(contact.icon, color: contact.color, size: 20 * scale),
                  ),
                  SizedBox(width: 14 * scale),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(contact.title, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600)),
                        SizedBox(height: 4 * scale),
                        Text(contact.subtitle, style: GoogleFonts.inter(color: contact.color, fontSize: 13 * scale)),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right_rounded, color: const Color(0xFFCBD5F5), size: 20 * scale),
                ],
              ),
            ),
          ),
          SizedBox(height: 12 * scale),
          _SectionBlock(
            scale: scale,
            title: 'Informations légales',
            entries: const [
              'Société — Sportify SAS',
              'SIRET — 123 456 789 00012',
              'Adresse — 123 Rue du Sport 75001 Paris',
              'DPO — dpo@sportify.app',
            ],
          ),
        ],
      ),
    );
  }
}

class _UpdatesSection extends StatelessWidget {
  const _UpdatesSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final history = [
      (
        version: 'Version 2.1',
        date: '15 octobre 2024',
        highlights: [
          'Ajout de la gestion des cookies marketing',
          'Clarification des droits RGPD',
          'Mise à jour des coordonnées de contact',
        ],
        active: true,
      ),
      (
        version: 'Version 2.0',
        date: '1 septembre 2024',
        highlights: [
          'Refonte complète de la politique de confidentialité',
          'Ajout de la section sur les cookies',
          'Amélioration de la transparence sur l’utilisation des données',
        ],
        active: false,
      ),
      (
        version: 'Version 1.5',
        date: '15 juin 2024',
        highlights: [
          'Ajout des conditions de remboursement',
          'Précisions sur les comportements interdits',
        ],
        active: false,
      ),
    ];

    return _Card(
      scale: scale,
      title: 'Mises à jour',
      subtitle: 'Historique des modifications de nos politiques',
      child: Column(
        children: [
          _SectionBlock(
            scale: scale,
            title: 'Historique des versions',
            timeline: history,
          ),
          SizedBox(height: 16 * scale),
          _SectionBlock(
            scale: scale,
            title: 'Notifications de mise à jour',
            highlights: const [
              'Email de notification 30 jours avant l’entrée en vigueur',
              'Notification dans l’application',
              'Résumé des principales modifications',
            ],
            highlightColor: const Color(0xFF0EA5E9),
          ),
          SizedBox(height: 16 * scale),
          _PrimaryButton(
            scale: scale,
            icon: Icons.notifications_active_outlined,
            label: 'Être notifié des changements',
            onTap: () => Get.snackbar('Notifications', 'Nous vous informerons des prochaines mises à jour.'),
          ),
        ],
      ),
    );
  }
}

class _ClosingSection extends StatelessWidget {
  const _ClosingSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 18 * scale, offset: Offset(0, 12 * scale))],
      ),
      child: Column(
        children: [
          Container(
            width: 64 * scale,
            height: 64 * scale,
            decoration: BoxDecoration(color: const Color(0xFF16A34A).withValues(alpha: 0.1), shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Icon(Icons.verified_outlined, color: const Color(0xFF16A34A), size: 32 * scale),
          ),
          SizedBox(height: 16 * scale),
          Text(
            'Merci de votre confiance',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10 * scale),
          Text(
            'Nous nous engageons à protéger vos données et à respecter votre vie privée sur Sportify.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale, height: 1.6),
          ),
        ],
      ),
    );
  }
}

class _StickyActions extends StatelessWidget {
  const _StickyActions({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      padding: EdgeInsets.fromLTRB(16 * scale, 16 * scale, 16 * scale, 24 * scale),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              height: 56 * scale,
              child: ElevatedButton.icon(
                onPressed: () => Get.snackbar('Conditions acceptées', 'Merci d’avoir consulté nos politiques.'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF176BFF),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
                ),
                icon: Icon(Icons.check_circle_outline, size: 20 * scale, color: Colors.white),
                label: Text(
                  'J’accepte ces conditions',
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 15 * scale, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(height: 12 * scale),
            SizedBox(
              width: double.infinity,
              height: 52 * scale,
              child: OutlinedButton.icon(
                onPressed: () => Get.snackbar('Téléchargement', 'Le PDF sera bientôt disponible.'),
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xFFF3F4F6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                icon: Icon(Icons.picture_as_pdf_rounded, size: 20 * scale, color: const Color(0xFF0B1220)),
                label: Text(
                  'Télécharger en PDF',
                  style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionBlock extends StatelessWidget {
  const _SectionBlock({
    required this.scale,
    required this.title,
    this.content,
    this.entries,
    this.highlights,
    this.secondaryHighlights,
    this.timeline,
    this.highlightColor,
    this.secondaryColor,
  });

  final double scale;
  final String title;
  final String? content;
  final List<String>? entries;
  final List<String>? highlights;
  final List<String>? secondaryHighlights;
  final List<({String version, String date, List<String> highlights, bool active})>? timeline;
  final Color? highlightColor;
  final Color? secondaryColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
          if (content != null) ...[
            SizedBox(height: 12 * scale),
            Text(content!, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale, height: 1.5)),
          ],
          if (entries != null) ...[
            SizedBox(height: 12 * scale),
            ...entries!.map(
              (entry) => Padding(
                padding: EdgeInsets.only(bottom: 6 * scale),
                child: Text('• $entry', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
              ),
            ),
          ],
          if (highlights != null) ...[
            SizedBox(height: 12 * scale),
            _HighlightCard(scale: scale, color: highlightColor ?? const Color(0xFF176BFF), entries: highlights!),
          ],
          if (secondaryHighlights != null) ...[
            SizedBox(height: 12 * scale),
            _HighlightCard(scale: scale, color: secondaryColor ?? const Color(0xFF0EA5E9), entries: secondaryHighlights!),
          ],
          if (timeline != null) ...[
            SizedBox(height: 12 * scale),
            Column(
              children: timeline!
                  .map(
                    (item) => Container(
                      margin: EdgeInsets.only(bottom: 12 * scale),
                      padding: EdgeInsets.all(16 * scale),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14 * scale),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                        color: item.active ? const Color(0x19176BFF) : Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(item.version, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600)),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 6 * scale),
                                decoration: BoxDecoration(
                                  color: item.active ? const Color(0xFF176BFF).withValues(alpha: 0.12) : const Color(0xFFF1F5F9),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  item.active ? 'Actuelle' : item.date,
                                  style: GoogleFonts.inter(
                                    color: item.active ? const Color(0xFF176BFF) : const Color(0xFF475569),
                                    fontSize: 11.5 * scale,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (!item.active)
                            Padding(
                              padding: EdgeInsets.only(top: 6 * scale),
                              child: Text(item.date, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
                            ),
                          SizedBox(height: 10 * scale),
                          ...item.highlights.map(
                            (entry) => Padding(
                              padding: EdgeInsets.only(bottom: 4 * scale),
                              child: Text('• $entry', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}

class _HighlightCard extends StatelessWidget {
  const _HighlightCard({required this.scale, required this.color, required this.entries});

  final double scale;
  final Color color;
  final List<String> entries;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14 * scale),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: entries
            .map(
              (entry) => Padding(
                padding: EdgeInsets.only(bottom: 6 * scale),
                child: Text('• $entry', style: GoogleFonts.inter(color: color.darken(), fontSize: 13 * scale)),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _MultiLineCard extends StatelessWidget {
  const _MultiLineCard({required this.scale, required this.sections, required this.colors});

  final double scale;
  final List<(String title, String description)> sections;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        sections.length,
        (index) {
          final section = sections[index];
          final color = colors[index % colors.length];
          return Container(
            margin: EdgeInsets.only(bottom: 12 * scale),
            padding: EdgeInsets.all(16 * scale),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(14 * scale),
              border: Border.all(color: color.withValues(alpha: 0.25)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 32 * scale,
                  height: 32 * scale,
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.6), borderRadius: BorderRadius.circular(12 * scale)),
                  alignment: Alignment.center,
                  child: Icon(Icons.bolt_rounded, color: color, size: 18 * scale),
                ),
                SizedBox(width: 12 * scale),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(section.$1, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600)),
                      SizedBox(height: 6 * scale),
                      Text(section.$2, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.scale, required this.title, required this.color, required this.entries});

  final double scale;
  final String title;
  final Color color;
  final List<String> entries;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 18 * scale,
                height: 18 * scale,
                decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(999)),
              ),
              SizedBox(width: 12 * scale),
              Text(title, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600)),
            ],
          ),
          SizedBox(height: 12 * scale),
          ...entries.map(
            (entry) => Padding(
              padding: EdgeInsets.only(bottom: 6 * scale),
              child: Text('• $entry', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
            ),
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.scale, required this.title, required this.child, this.subtitle, this.backgroundColor});

  final double scale;
  final String title;
  final String? subtitle;
  final Widget child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16 * scale),
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 18 * scale, offset: Offset(0, 12 * scale))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600)),
          if (subtitle != null) ...[
            SizedBox(height: 6 * scale),
            Text(subtitle!, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
          ],
          SizedBox(height: 16 * scale),
          child,
        ],
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({required this.scale, required this.icon, required this.text});

  final double scale;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32 * scale,
          height: 32 * scale,
          decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(12 * scale)),
          alignment: Alignment.center,
          child: Icon(icon, color: const Color(0xFF176BFF), size: 18 * scale),
        ),
        SizedBox(width: 10 * scale),
        Text(text, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({required this.scale, required this.icon, required this.label, this.backgroundColor, this.onTap});

  final double scale;
  final IconData icon;
  final String label;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48 * scale,
      child: ElevatedButton.icon(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? const Color(0xFF176BFF),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
        ),
        icon: Icon(icon, size: 18 * scale, color: Colors.white),
        label: Text(
          label,
          style: GoogleFonts.inter(color: Colors.white, fontSize: 14 * scale, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

extension _ColorHelpers on Color {
  Color darken([double amount = .2]) {
    final hsl = HSLColor.fromColor(this);
    return hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0)).toColor();
  }
}


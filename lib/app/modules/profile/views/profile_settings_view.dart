import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/profile_settings_controller.dart';

class ProfileSettingsView extends GetView<ProfileSettingsController> {
  const ProfileSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            const designWidth = 375.0;
            final width = constraints.hasBoundedWidth ? constraints.maxWidth : MediaQuery.of(context).size.width;
            final scale = (width / designWidth).clamp(0.85, 1.05);

            return Column(
              children: [
                _SettingsHeader(scale: scale),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 22 * scale),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: designWidth * scale),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _ProfileHero(scale: scale),
                            SizedBox(height: 20 * scale),
                            _StatsRow(scale: scale),
                            SizedBox(height: 24 * scale),
                            _SectionTitle(scale: scale, title: 'Compte'),
                            SizedBox(height: 12 * scale),
                            _AccountSection(scale: scale),
                            SizedBox(height: 24 * scale),
                            _SectionTitle(scale: scale, title: 'Préférences'),
                            SizedBox(height: 12 * scale),
                            _PreferencesSection(scale: scale),
                            SizedBox(height: 24 * scale),
                            _SectionTitle(scale: scale, title: 'Confidentialité'),
                            SizedBox(height: 12 * scale),
                            _PrivacySection(scale: scale),
                            SizedBox(height: 24 * scale),
                            _SectionTitle(scale: scale, title: 'Sports favoris'),
                            SizedBox(height: 12 * scale),
                            _FavoriteSportsSection(scale: scale),
                            SizedBox(height: 24 * scale),
                            _SectionTitle(scale: scale, title: 'Types de notifications'),
                            SizedBox(height: 12 * scale),
                            _NotificationTypesSection(scale: scale),
                            SizedBox(height: 24 * scale),
                            _SectionTitle(scale: scale, title: 'Support'),
                            SizedBox(height: 12 * scale),
                            _SupportSection(scale: scale),
                            SizedBox(height: 24 * scale),
                            _SectionTitle(scale: scale, title: 'À propos'),
                            SizedBox(height: 12 * scale),
                            _AboutSection(scale: scale),
                            SizedBox(height: 24 * scale),
                            _DangerZoneSection(scale: scale),
                            SizedBox(height: 32 * scale),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SettingsHeader extends StatelessWidget {
  const _SettingsHeader({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 14 * scale),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
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
              'Paramètres',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: const Color(0xFF0B1220),
                fontSize: 20 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            onPressed: Get.back,
            icon: const Icon(Icons.close_rounded, size: 20),
            style: IconButton.styleFrom(
              backgroundColor: const Color(0xFFF3F4F6),
              padding: EdgeInsets.all(10 * scale),
              shape: const CircleBorder(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileHero extends GetView<ProfileSettingsController> {
  const _ProfileHero({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: EdgeInsets.all(20 * scale),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24 * scale),
          boxShadow: [
            BoxShadow(
              color: const Color(0x33176BFF),
              blurRadius: 24 * scale,
              offset: Offset(0, 16 * scale),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 68 * scale,
                      height: 68 * scale,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9999),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.35), width: 2 * scale),
                        image: const DecorationImage(
                          image: NetworkImage('https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=200&q=60'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -2 * scale,
                      right: -2 * scale,
                      child: Container(
                        width: 24 * scale,
                        height: 24 * scale,
                        decoration: BoxDecoration(
                          color: const Color(0xFF16A34A),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3 * scale),
                        ),
                        child: Icon(Icons.check_rounded, color: Colors.white, size: 14 * scale),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 18 * scale),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.userName.value,
                        style: GoogleFonts.poppins(color: Colors.white, fontSize: 20 * scale, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 6 * scale),
                      Text(
                        '${controller.membership.value} • ${controller.level.value}',
                        style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.85), fontSize: 14 * scale),
                      ),
                      SizedBox(height: 6 * scale),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined, color: Colors.white.withValues(alpha: 0.8), size: 16 * scale),
                          SizedBox(width: 6 * scale),
                          Text(
                            controller.location.value,
                            style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.8), fontSize: 13 * scale),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: controller.openPersonalInfo,
                  icon: const Icon(Icons.edit_outlined),
                  color: Colors.white,
                ),
              ],
            ),
            SizedBox(height: 20 * scale),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 12 * scale),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(14 * scale),
              ),
              child: Row(
                children: [
                  _HeroStat(
                    scale: scale,
                    icon: Icons.sports_soccer_outlined,
                    value: controller.reservationCount.value.toString(),
                    label: 'Réservations',
                  ),
                  _HeroDivider(scale: scale),
                  _HeroStat(
                    scale: scale,
                    icon: Icons.groups_outlined,
                    value: controller.partnerCount.value.toString(),
                    label: 'Partenaires',
                  ),
                  _HeroDivider(scale: scale),
                  _HeroStat(
                    scale: scale,
                    icon: Icons.emoji_events_outlined,
                    value: controller.trophiesCount.value.toString(),
                    label: 'Trophées',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroStat extends StatelessWidget {
  const _HeroStat({
    required this.scale,
    required this.icon,
    required this.value,
    required this.label,
  });

  final double scale;
  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 18 * scale),
          SizedBox(height: 6 * scale),
          Text(value, style: GoogleFonts.poppins(color: Colors.white, fontSize: 16 * scale, fontWeight: FontWeight.w600)),
          SizedBox(height: 2 * scale),
          Text(label, style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.8), fontSize: 11 * scale)),
        ],
      ),
    );
  }
}

class _HeroDivider extends StatelessWidget {
  const _HeroDivider({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1 * scale,
      height: 44 * scale,
      margin: EdgeInsets.symmetric(horizontal: 12 * scale),
      color: Colors.white.withValues(alpha: 0.25),
    );
  }
}

class _StatsRow extends GetView<ProfileSettingsController> {
  const _StatsRow({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _SmallCard(
            scale: scale,
            gradient: const [Color(0x19176BFF), Color(0x0C0F5AE0)],
            icon: Icons.calendar_today_outlined,
            label: 'Calendrier',
            value: 'Synchronisé',
            onTap: () => Get.snackbar('Calendrier', 'Accès au calendrier à venir.'),
          ),
        ),
        SizedBox(width: 12 * scale),
        Expanded(
          child: _SmallCard(
            scale: scale,
            gradient: const [Color(0x1916A34A), Color(0x0C16A34A)],
            icon: Icons.notifications_outlined,
            label: 'Notifications',
            value: 'Personnalisées',
            onTap: controller.openNotificationsSettings,
          ),
        ),
      ],
    );
  }
}

class _SmallCard extends StatelessWidget {
  const _SmallCard({
    required this.scale,
    required this.gradient,
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  final double scale;
  final List<Color> gradient;
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18 * scale),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16 * scale),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFF0B1220), size: 20 * scale),
            SizedBox(height: 16 * scale),
            Text(label, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600)),
            SizedBox(height: 4 * scale),
            Text(value, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
          ],
        ),
      ),
    );
  }
}

class _AccountSection extends GetView<ProfileSettingsController> {
  const _AccountSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      scale: scale,
      children: [
        _NavigationTile(
          scale: scale,
          icon: Icons.person_outline_rounded,
          iconColor: const Color(0xFF176BFF),
          title: 'Informations personnelles',
          subtitle: 'Nom, email, téléphone',
          onTap: controller.openPersonalInfo,
        ),
        _Divider(scale: scale),
        _NavigationTile(
          scale: scale,
          icon: Icons.shield_outlined,
          iconColor: const Color(0xFF16A34A),
          title: 'Sécurité',
          subtitle: 'Mot de passe, 2FA',
          onTap: controller.openSecurity,
        ),
        _Divider(scale: scale),
        _NavigationTile(
          scale: scale,
          icon: Icons.workspace_premium_outlined,
          iconColor: const Color(0xFFFFB800),
          title: 'Abonnement Premium',
          subtitle: 'Gérer votre abonnement',
          trailing: const _Badge(label: 'ACTIF', color: Color(0xFFFFB800)),
          onTap: controller.openSubscription,
        ),
        _Divider(scale: scale),
        _NavigationTile(
          scale: scale,
          icon: Icons.credit_card_outlined,
          iconColor: const Color(0xFF0EA5E9),
          title: 'Moyens de paiement',
          subtitle: 'Cartes, Wallet Sportify',
          onTap: controller.openPaymentMethods,
        ),
      ],
    );
  }
}

class _PreferencesSection extends GetView<ProfileSettingsController> {
  const _PreferencesSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      scale: scale,
      children: [
        _ToggleTile(
          scale: scale,
          icon: Icons.notifications_outlined,
          iconColor: const Color(0xFF176BFF),
          title: 'Notifications',
          subtitle: 'Matchs, messages, rappels',
          valueListenable: controller.notificationsEnabled,
          onChanged: controller.toggleNotifications,
        ),
        _Divider(scale: scale),
        _ToggleTile(
          scale: scale,
          icon: Icons.dark_mode_outlined,
          iconColor: const Color(0xFF1F2937),
          title: 'Mode sombre',
          subtitle: 'Thème de l’application',
          valueListenable: controller.darkModeEnabled,
          onChanged: controller.toggleDarkMode,
        ),
        _Divider(scale: scale),
        _NavigationTile(
          scale: scale,
          icon: Icons.language_outlined,
          iconColor: const Color(0xFF16A34A),
          title: 'Langue',
          subtitle: controller.language.value,
          onTap: controller.openLanguagePicker,
        ),
        _Divider(scale: scale),
        _NavigationTile(
          scale: scale,
          icon: Icons.location_on_outlined,
          iconColor: const Color(0xFF0EA5E9),
          title: 'Localisation',
          subtitle: controller.location.value,
          onTap: controller.openLocationSettings,
        ),
      ],
    );
  }
}

class _PrivacySection extends GetView<ProfileSettingsController> {
  const _PrivacySection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      scale: scale,
      children: [
        _ToggleTile(
          scale: scale,
          icon: Icons.public_outlined,
          iconColor: const Color(0xFF16A34A),
          title: 'Profil public',
          subtitle: 'Visible par tous les utilisateurs',
          valueListenable: controller.profilePublic,
          onChanged: controller.toggleProfilePublic,
        ),
        _Divider(scale: scale),
        _ToggleTile(
          scale: scale,
          icon: Icons.mail_outline_rounded,
          iconColor: const Color(0xFF0EA5E9),
          title: 'Invitations automatiques',
          subtitle: 'Recevoir des invitations de matchs',
          valueListenable: controller.autoInviteEnabled,
          onChanged: controller.toggleAutoInvite,
        ),
        _Divider(scale: scale),
        _NavigationTile(
          scale: scale,
          icon: Icons.block_outlined,
          iconColor: const Color(0xFFEF4444),
          title: 'Utilisateurs bloqués',
          subtitle: '3 utilisateurs bloqués',
          onTap: controller.openBlockedUsers,
        ),
        _Divider(scale: scale),
        _NavigationTile(
          scale: scale,
          icon: Icons.storage_outlined,
          iconColor: const Color(0xFF6366F1),
          title: 'Données personnelles',
          subtitle: controller.dataExportStatus.value,
          onTap: controller.downloadData,
        ),
      ],
    );
  }
}

class _FavoriteSportsSection extends GetView<ProfileSettingsController> {
  const _FavoriteSportsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      scale: scale,
      padding: EdgeInsets.all(18 * scale),
      children: [
        Obx(
          () => Wrap(
            spacing: 12 * scale,
            runSpacing: 12 * scale,
            children: controller.favoriteSports
                .map(
                  (sport) => Container(
                    width: 95 * scale,
                    height: 84 * scale,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16 * scale),
                      border: Border.all(color: sport.color.withValues(alpha: 0.3), width: 2 * scale),
                      color: sport.color.withValues(alpha: 0.1),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      sport.name,
                      style: GoogleFonts.inter(color: sport.color, fontSize: 13 * scale, fontWeight: FontWeight.w600),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(height: 16 * scale),
        SizedBox(
          width: double.infinity,
          height: 48 * scale,
          child: OutlinedButton.icon(
            onPressed: controller.addSport,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFE5E7EB), width: 2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
            ),
            icon: Icon(Icons.add_rounded, color: const Color(0xFF475569), size: 20 * scale),
            label: Text(
              'Ajouter un sport',
              style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 15 * scale, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
}

class _NotificationTypesSection extends GetView<ProfileSettingsController> {
  const _NotificationTypesSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      scale: scale,
      children: [
        _ToggleTile(
          scale: scale,
          icon: Icons.mail_outline_rounded,
          iconColor: const Color(0xFF16A34A),
          title: 'Nouvelles invitations',
          subtitle: 'Nouvel événement ou session',
          valueListenable: controller.invitationAlerts,
          onChanged: controller.toggleInvitationAlerts,
        ),
        _Divider(scale: scale),
        _ToggleTile(
          scale: scale,
          icon: Icons.message_outlined,
          iconColor: const Color(0xFF176BFF),
          title: 'Messages',
          subtitle: 'Messages directs et commentaires',
          valueListenable: controller.messageNotifications,
          onChanged: controller.toggleMessageNotifications,
        ),
        _Divider(scale: scale),
        _ToggleTile(
          scale: scale,
          icon: Icons.alarm_outlined,
          iconColor: const Color(0xFFF59E0B),
          title: 'Rappels de matchs',
          subtitle: 'Notifications avant le coup d’envoi',
          valueListenable: controller.matchReminders,
          onChanged: controller.toggleMatchReminders,
        ),
        _Divider(scale: scale),
        _ToggleTile(
          scale: scale,
          icon: Icons.emoji_events_outlined,
          iconColor: const Color(0xFF4B5563),
          title: 'Récompenses',
          subtitle: 'Badges, succès et promotions',
          valueListenable: controller.rewardsEnabled,
          onChanged: controller.toggleRewards,
        ),
      ],
    );
  }
}

class _SupportSection extends GetView<ProfileSettingsController> {
  const _SupportSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      scale: scale,
      children: [
        _NavigationTile(
          scale: scale,
          icon: Icons.help_outline_rounded,
          iconColor: const Color(0xFF0EA5E9),
          title: 'Centre d’aide',
          subtitle: 'FAQ, guides, tutoriels',
          onTap: controller.openHelpCenter,
        ),
        _Divider(scale: scale),
        _NavigationTile(
          scale: scale,
          icon: Icons.headset_mic_outlined,
          iconColor: const Color(0xFF176BFF),
          title: 'Contacter le support',
          subtitle: 'Chat en direct disponible',
          trailing: const _StatusDot(color: Color(0xFF16A34A)),
          onTap: controller.contactSupport,
        ),
        _Divider(scale: scale),
        _NavigationTile(
          scale: scale,
          icon: Icons.report_problem_outlined,
          iconColor: const Color(0xFFF59E0B),
          title: 'Signaler un problème',
          subtitle: 'Bug, erreur, suggestion',
          onTap: controller.reportIssue,
        ),
        _Divider(scale: scale),
        _NavigationTile(
          scale: scale,
          icon: Icons.star_rate_outlined,
          iconColor: const Color(0xFFFFB800),
          title: 'Noter l’application',
          subtitle: 'Votre avis nous aide',
          onTap: controller.rateApp,
        ),
      ],
    );
  }
}

class _AboutSection extends GetView<ProfileSettingsController> {
  const _AboutSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      scale: scale,
      children: [
        _NavigationTile(
          scale: scale,
          icon: Icons.article_outlined,
          iconColor: const Color(0xFF4B5563),
          title: 'Conditions d’utilisation',
          subtitle: '',
          onTap: controller.viewTerms,
        ),
        _Divider(scale: scale),
        _NavigationTile(
          scale: scale,
          icon: Icons.privacy_tip_outlined,
          iconColor: const Color(0xFF176BFF),
          title: 'Politique de confidentialité',
          subtitle: '',
          onTap: controller.viewPrivacyPolicy,
        ),
        _Divider(scale: scale),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10 * scale),
          child: Column(
            children: [
              Text(
                controller.versionLabel,
                style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale),
              ),
              SizedBox(height: 4 * scale),
              Text(
                '© 2024 Sportify. Tous droits réservés.',
                style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 12 * scale),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DangerZoneSection extends GetView<ProfileSettingsController> {
  const _DangerZoneSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Zone dangereuse',
          style: GoogleFonts.poppins(color: const Color(0xFFEF4444), fontSize: 18 * scale, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 12 * scale),
        _SectionCard(
          scale: scale,
          borderColor: const Color(0x4CEF4444),
          children: [
            _NavigationTile(
              scale: scale,
              icon: Icons.logout_rounded,
              iconColor: const Color(0xFFEF4444),
              title: 'Se déconnecter',
              subtitle: 'Déconnexion de tous les appareils',
              onTap: controller.logoutAllDevices,
            ),
            _Divider(scale: scale, color: const Color(0x33EF4444)),
            SizedBox(
              width: double.infinity,
              height: 50 * scale,
              child: ElevatedButton(
                onPressed: controller.deleteAccount,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEF4444),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
                ),
                child: Text(
                  'Supprimer le compte',
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 15 * scale, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.scale, required this.title});

  final double scale;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.scale,
    required this.children,
    this.padding,
    this.borderColor,
  });

  final double scale;
  final List<Widget> children;
  final EdgeInsets? padding;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18 * scale),
        side: BorderSide(color: borderColor ?? const Color(0xFFE2E8F0)),
      ),
      child: Padding(
        padding: padding ?? EdgeInsets.symmetric(horizontal: 18 * scale, vertical: 16 * scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}

class _NavigationTile extends StatelessWidget {
  const _NavigationTile({
    required this.scale,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    this.trailing,
    required this.onTap,
  });

  final double scale;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16 * scale),
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4 * scale),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40 * scale,
              height: 40 * scale,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14 * scale),
              ),
              alignment: Alignment.center,
              child: Icon(icon, color: iconColor, size: 20 * scale),
            ),
            SizedBox(width: 14 * scale),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600)),
                  if (subtitle.isNotEmpty) ...[
                    SizedBox(height: 4 * scale),
                    Text(subtitle, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
                  ],
                ],
              ),
            ),
            trailing ??
                Icon(
                  Icons.chevron_right_rounded,
                  color: const Color(0xFFCBD5F5),
                  size: 22 * scale,
                ),
          ],
        ),
      ),
    );
  }
}

class _ToggleTile extends StatelessWidget {
  const _ToggleTile({
    required this.scale,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.valueListenable,
    required this.onChanged,
  });

  final double scale;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final RxBool valueListenable;
  final void Function(bool value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(vertical: 4 * scale),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40 * scale,
              height: 40 * scale,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14 * scale),
              ),
              alignment: Alignment.center,
              child: Icon(icon, color: iconColor, size: 20 * scale),
            ),
            SizedBox(width: 14 * scale),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600)),
                  SizedBox(height: 4 * scale),
                  Text(subtitle, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
                ],
              ),
            ),
            Switch(
              value: valueListenable.value,
              onChanged: onChanged,
              activeColor: Colors.white,
              activeTrackColor: const Color(0xFF176BFF),
              inactiveTrackColor: const Color(0xFFD1D5DB),
            ),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({required this.scale, this.color});

  final double scale;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 20 * scale,
      thickness: 1,
      color: color ?? const Color(0xFFE5E7EB),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _StatusDot extends StatelessWidget {
  const _StatusDot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          'En ligne',
          style: GoogleFonts.inter(color: const Color(0xFF16A34A), fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}


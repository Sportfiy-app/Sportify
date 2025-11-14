import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/profile_security_controller.dart';

class ProfileSecurityView extends GetView<ProfileSecurityController> {
  const ProfileSecurityView({super.key});

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
                _PageHeader(scale: scale),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 20 * scale),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: designWidth * scale),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _SecurityHeroCard(scale: scale),
                            SizedBox(height: 20 * scale),
                            _QuickStatsRow(scale: scale),
                            SizedBox(height: 24 * scale),
                            _SectionTitle(scale: scale, title: 'Connexion & authentification'),
                            SizedBox(height: 12 * scale),
                            _ConnectionAuthSection(scale: scale),
                            SizedBox(height: 24 * scale),
                            _SectionTitle(scale: scale, title: 'Appareils connectés'),
                            SizedBox(height: 12 * scale),
                            _DevicesSection(scale: scale),
                            SizedBox(height: 24 * scale),
                            _SectionTitle(scale: scale, title: 'Confidentialité'),
                            SizedBox(height: 12 * scale),
                            _PrivacySection(scale: scale),
                            SizedBox(height: 24 * scale),
                            _SectionTitle(scale: scale, title: 'Sécurité du compte'),
                            SizedBox(height: 12 * scale),
                            _AccountSecuritySection(scale: scale),
                            SizedBox(height: 24 * scale),
                            _SectionTitle(scale: scale, title: 'Recommandations de sécurité'),
                            SizedBox(height: 12 * scale),
                            _RecommendationsSection(scale: scale),
                            SizedBox(height: 24 * scale),
                            _SectionTitle(scale: scale, title: 'Données & confidentialité'),
                            SizedBox(height: 12 * scale),
                            _DataPrivacySection(scale: scale),
                            SizedBox(height: 24 * scale),
                            _SecurityTipsSection(scale: scale),
                            SizedBox(height: 24 * scale),
                            _SupportSection(scale: scale),
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

class _PageHeader extends StatelessWidget {
  const _PageHeader({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 14 * scale),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFE2E8F0)),
        ),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Connexions & sécurité',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF0B1220),
                    fontSize: 19 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2 * scale),
                Text(
                  'Gérez votre confidentialité',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF475569),
                    fontSize: 12 * scale,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
            decoration: BoxDecoration(
              color: const Color(0xFF16A34A).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              children: [
                Container(
                  width: 8 * scale,
                  height: 8 * scale,
                  decoration: const BoxDecoration(
                    color: Color(0xFF16A34A),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 6 * scale),
                Text(
                  'Sécurisé',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF16A34A),
                    fontSize: 12 * scale,
                    fontWeight: FontWeight.w600,
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

class _SecurityHeroCard extends GetView<ProfileSecurityController> {
  const _SecurityHeroCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final score = controller.securityScore.value.clamp(0.0, 1.0);
        final percentLabel = '${(score * 100).round()}%';
        final recommended = controller.recommendedActionsCount.value;

        return Container(
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
                blurRadius: 28 * scale,
                offset: Offset(0, 18 * scale),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 56 * scale,
                    height: 56 * scale,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF16A34A), Color(0xFF15803D)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.verified_user_outlined, color: Colors.white, size: 28 * scale),
                  ),
                  SizedBox(width: 16 * scale),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Niveau de sécurité',
                          style: GoogleFonts.poppins(color: Colors.white, fontSize: 20 * scale, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 4 * scale),
                        Text(
                          'Votre compte est bien protégé',
                          style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.9), fontSize: 14 * scale),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        percentLabel,
                        style: GoogleFonts.poppins(color: Colors.white, fontSize: 22 * scale, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 4 * scale),
                      Text(
                        '3 actions recommandées',
                        style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.8), fontSize: 12 * scale),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 18 * scale),
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  value: score,
                  minHeight: 10 * scale,
                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFFB800)),
                ),
              ),
              SizedBox(height: 12 * scale),
              Text(
                '$recommended actions pour atteindre 100%',
                style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.85), fontSize: 13 * scale),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _QuickStatsRow extends GetView<ProfileSecurityController> {
  const _QuickStatsRow({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: _QuickStatCard(
              scale: scale,
              title: 'Mot de passe',
              subtitle: controller.passwordUpdatedLabel.value,
              icon: Icons.lock_outline_rounded,
              gradient: const [Color(0xFF176BFF), Color(0xFF1D4ED8)],
              actionLabel: 'Modifier',
              onTap: controller.openChangePassword,
            ),
          ),
          SizedBox(width: 12 * scale),
          Expanded(
            child: _QuickStatCard(
              scale: scale,
              title: 'Authentification',
              subtitle: controller.isTwoFactorEnabled.value ? '2FA activée' : '2FA désactivée',
              icon: Icons.shield_outlined,
              gradient: const [Color(0xFF16A34A), Color(0xFF15803D)],
              actionLabel: controller.isTwoFactorEnabled.value ? 'Gérer' : 'Activer',
              onTap: () => controller.toggleTwoFactor(!controller.isTwoFactorEnabled.value),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickStatCard extends StatelessWidget {
  const _QuickStatCard({
    required this.scale,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradient,
    required this.actionLabel,
    required this.onTap,
  });

  final double scale;
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> gradient;
  final String actionLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18 * scale),
        boxShadow: [
          BoxShadow(
            color: gradient.last.withValues(alpha: 0.15),
            blurRadius: 18 * scale,
            offset: Offset(0, 10 * scale),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40 * scale,
            height: 40 * scale,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(14 * scale),
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: Colors.white, size: 22 * scale),
          ),
          SizedBox(height: 14 * scale),
          Text(
            title,
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 16 * scale, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 4 * scale),
          Text(
            subtitle,
            style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.9), fontSize: 13 * scale),
          ),
          SizedBox(height: 16 * scale),
          TextButton(
            onPressed: onTap,
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              padding: EdgeInsets.zero,
              textStyle: GoogleFonts.inter(fontSize: 13 * scale, fontWeight: FontWeight.w600),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(actionLabel),
                SizedBox(width: 6 * scale),
                Icon(Icons.chevron_right_rounded, size: 18 * scale),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ConnectionAuthSection extends GetView<ProfileSecurityController> {
  const _ConnectionAuthSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18 * scale)),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(20 * scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TileRow(
              scale: scale,
              icon: Icons.lock_outline_rounded,
              iconColor: const Color(0xFF176BFF),
              title: 'Mot de passe',
              subtitle: controller.passwordUpdatedLabel.value,
              trailing: _GhostButton(
                scale: scale,
                label: 'Modifier',
                onTap: controller.openChangePassword,
              ),
            ),
            SizedBox(height: 16 * scale),
            _ToggleRow(
              scale: scale,
              icon: Icons.shield_outlined,
              iconColor: const Color(0xFF16A34A),
              title: 'Authentification à deux facteurs',
              subtitle: 'Protection renforcée lors de chaque connexion',
              valueListenable: controller.isTwoFactorEnabled,
              onChanged: controller.toggleTwoFactor,
            ),
            SizedBox(height: 12 * scale),
            _ToggleRow(
              scale: scale,
              icon: Icons.fingerprint_rounded,
              iconColor: const Color(0xFF2563EB),
              title: 'Connexion biométrique',
              subtitle: 'Touch ID, Face ID ou empreinte digitale',
              valueListenable: controller.isBiometricEnabled,
              onChanged: controller.toggleBiometric,
            ),
            SizedBox(height: 12 * scale),
            _ToggleRow(
              scale: scale,
              icon: Icons.notifications_active_outlined,
              iconColor: const Color(0xFFF59E0B),
              title: 'Alertes de connexion',
              subtitle: 'Soyez averti lors d’une nouvelle session',
              valueListenable: controller.alertsEnabled,
              onChanged: controller.toggleAlerts,
            ),
          ],
        ),
      ),
    );
  }
}

class _DevicesSection extends GetView<ProfileSecurityController> {
  const _DevicesSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final devices = controller.connectedDevices;
    ConnectedDevice? currentDevice;
    for (final device in devices) {
      if (device.isCurrent) {
        currentDevice = device;
        break;
      }
    }
    final otherDevices = devices.where((element) => !element.isCurrent).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (currentDevice != null) _CurrentDeviceCard(scale: scale, device: currentDevice),
        SizedBox(height: 16 * scale),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18 * scale)),
          child: Padding(
            padding: EdgeInsets.all(18 * scale),
            child: Column(
              children: [
                ...otherDevices.map(
                  (device) => Padding(
                    padding: EdgeInsets.only(bottom: 14 * scale),
                    child: _DeviceTile(scale: scale, device: device),
                  ),
                ),
                if (otherDevices.isNotEmpty) SizedBox(height: 4 * scale),
                _GhostButton(
                  scale: scale,
                  label: 'Gérer les sessions',
                  onTap: controller.manageSessions,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16 * scale),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18 * scale)),
          child: Padding(
            padding: EdgeInsets.all(18 * scale),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Historique récent',
                  style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 12 * scale),
                ...controller.recentSessions.map(
                  (session) => Padding(
                    padding: EdgeInsets.only(bottom: 12 * scale),
                    child: _SessionTile(scale: scale, session: session),
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

class _PrivacySection extends GetView<ProfileSecurityController> {
  const _PrivacySection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18 * scale)),
      child: Padding(
        padding: EdgeInsets.all(18 * scale),
        child: Column(
          children: [
            _PrivacyTile(
              scale: scale,
              icon: Icons.visibility_outlined,
              iconColor: const Color(0xFF176BFF),
              title: 'Visibilité du profil',
              subtitle: 'Qui peut voir votre profil complet',
              trailing: Obx(
                () => _ValuePill(
                  scale: scale,
                  label: controller.profileVisibility.value,
                  color: const Color(0xFF176BFF),
                ),
              ),
              onTap: controller.chooseVisibility,
            ),
            SizedBox(height: 12 * scale),
            _ToggleRow(
              scale: scale,
              icon: Icons.location_on_outlined,
              iconColor: const Color(0xFF16A34A),
              title: 'Partage de localisation',
              subtitle: 'Pour trouver des terrains proches de vous',
              valueListenable: controller.shareLocation,
              onChanged: controller.toggleShareLocation,
            ),
            SizedBox(height: 12 * scale),
            _ToggleRow(
              scale: scale,
              icon: Icons.circle_outlined,
              iconColor: const Color(0xFFF97316),
              title: 'Statut d’activité',
              subtitle: 'Afficher quand vous êtes en ligne',
              valueListenable: controller.showStatus,
              onChanged: controller.toggleShowStatus,
            ),
            SizedBox(height: 12 * scale),
            _ToggleRow(
              scale: scale,
              icon: Icons.analytics_outlined,
              iconColor: const Color(0xFF6366F1),
              title: 'Analyses de données',
              subtitle: 'Améliorer l’expérience utilisateur',
              valueListenable: controller.analyticsEnabled,
              onChanged: controller.toggleAnalytics,
            ),
          ],
        ),
      ),
    );
  }
}

class _AccountSecuritySection extends GetView<ProfileSecurityController> {
  const _AccountSecuritySection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18 * scale)),
      child: Padding(
        padding: EdgeInsets.all(18 * scale),
        child: Column(
          children: [
            _NavigationTile(
              scale: scale,
              icon: Icons.block_flipped,
              iconColor: const Color(0xFFEF4444),
              title: 'Utilisateurs bloqués',
              subtitle: '2 utilisateurs bloqués',
              onTap: controller.openBlockedUsers,
            ),
            SizedBox(height: 12 * scale),
            _NavigationTile(
              scale: scale,
              icon: Icons.report_gmailerrorred_outlined,
              iconColor: const Color(0xFFF59E0B),
              title: 'Historique des signalements',
              subtitle: 'Vos signalements et rapports',
              onTap: controller.openReportHistory,
            ),
            SizedBox(height: 12 * scale),
            _NavigationTile(
              scale: scale,
              icon: Icons.history_rounded,
              iconColor: const Color(0xFF2563EB),
              title: 'Historique de connexion',
              subtitle: 'Voir toutes les connexions récentes',
              onTap: controller.openLoginHistory,
            ),
          ],
        ),
      ),
    );
  }
}

class _RecommendationsSection extends GetView<ProfileSecurityController> {
  const _RecommendationsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final items = controller.recommendations;
    return Column(
      children: items
          .map(
            (item) => Container(
              margin: EdgeInsets.only(bottom: 14 * scale),
              padding: EdgeInsets.all(18 * scale),
              decoration: BoxDecoration(
                color: item.accentColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(18 * scale),
                border: Border.all(color: item.accentColor.withValues(alpha: 0.25)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 6 * scale),
                  Text(
                    item.description,
                    style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale, height: 1.5),
                  ),
                  SizedBox(height: 14 * scale),
                  SizedBox(
                    width: double.infinity,
                    height: 44 * scale,
                    child: ElevatedButton(
                      onPressed: item.onTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: item.accentColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scale)),
                      ),
                      child: Text(
                        item.actionLabel,
                        style: GoogleFonts.inter(color: Colors.white, fontSize: 14 * scale, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _DataPrivacySection extends GetView<ProfileSecurityController> {
  const _DataPrivacySection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18 * scale)),
      child: Padding(
        padding: EdgeInsets.all(18 * scale),
        child: Column(
          children: [
            _NavigationTile(
              scale: scale,
              icon: Icons.cloud_download_outlined,
              iconColor: const Color(0xFF176BFF),
              title: 'Télécharger mes données',
              subtitle: 'Exportez toutes vos informations',
              onTap: controller.downloadData,
            ),
            SizedBox(height: 12 * scale),
            _NavigationTile(
              scale: scale,
              icon: Icons.delete_sweep_outlined,
              iconColor: const Color(0xFFEF4444),
              title: 'Supprimer mon compte',
              subtitle: 'Action irréversible',
              onTap: controller.deleteAccount,
            ),
          ],
        ),
      ),
    );
  }
}

class _SecurityTipsSection extends GetView<ProfileSecurityController> {
  const _SecurityTipsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final tips = controller.securityTips;
    return Container(
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0EA5E9), Color(0xFF2563EB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20 * scale),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48 * scale,
                height: 48 * scale,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(16 * scale),
                ),
                alignment: Alignment.center,
                child: Icon(Icons.tips_and_updates_outlined, color: Colors.white, size: 24 * scale),
              ),
              SizedBox(width: 14 * scale),
              Expanded(
                child: Text(
                  'Conseils de sécurité',
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 18 * scale, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          SizedBox(height: 16 * scale),
          ...tips.map(
            (tip) => Padding(
              padding: EdgeInsets.only(bottom: 10 * scale),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 6 * scale,
                    height: 6 * scale,
                    margin: EdgeInsets.only(top: 8 * scale),
                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  ),
                  SizedBox(width: 12 * scale),
                  Expanded(
                    child: Text(
                      tip,
                      style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.92), fontSize: 13 * scale, height: 1.5),
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

class _SupportSection extends GetView<ProfileSecurityController> {
  const _SupportSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Container(
            width: 60 * scale,
            height: 60 * scale,
            decoration: BoxDecoration(
              color: const Color(0x19176BFF),
              borderRadius: BorderRadius.circular(20 * scale),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.support_agent_rounded, color: const Color(0xFF176BFF), size: 26 * scale),
          ),
          SizedBox(height: 16 * scale),
          Text(
            'Besoin d’aide ?',
            style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8 * scale),
          Text(
            'Notre équipe support est là pour vous aider',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale),
          ),
          SizedBox(height: 16 * scale),
          SizedBox(
            width: double.infinity,
            height: 48 * scale,
            child: ElevatedButton(
              onPressed: controller.openNotificationsHelp,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF176BFF),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
              ),
              child: Text(
                'Contacter le support',
                style: GoogleFonts.inter(color: Colors.white, fontSize: 15 * scale, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TileRow extends StatelessWidget {
  const _TileRow({
    required this.scale,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    this.trailing,
  });

  final double scale;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48 * scale,
          height: 48 * scale,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(16 * scale),
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: iconColor, size: 22 * scale),
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
        if (trailing != null) trailing!,
      ],
    );
  }
}

class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
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
      () => Container(
        padding: EdgeInsets.symmetric(vertical: 6 * scale),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48 * scale,
              height: 48 * scale,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(16 * scale),
              ),
              alignment: Alignment.center,
              child: Icon(icon, color: iconColor, size: 22 * scale),
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
              inactiveTrackColor: const Color(0xFFE2E8F0),
            ),
          ],
        ),
      ),
    );
  }
}

class _CurrentDeviceCard extends StatelessWidget {
  const _CurrentDeviceCard({required this.scale, required this.device});

  final double scale;
  final ConnectedDevice device;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18 * scale),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0x19176BFF), Color(0x0C0F5AE0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52 * scale,
            height: 52 * scale,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16 * scale),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            alignment: Alignment.center,
            child: Icon(device.icon, color: device.accentColor, size: 26 * scale),
          ),
          SizedBox(width: 14 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        device.name,
                        style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600),
                      ),
                    ),
                    _ValuePill(scale: scale, label: device.statusLabel, color: device.statusColor),
                  ],
                ),
                SizedBox(height: 6 * scale),
                Text(device.location, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
                SizedBox(height: 4 * scale),
                Text(device.platform, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DeviceTile extends StatelessWidget {
  const _DeviceTile({required this.scale, required this.device});

  final double scale;
  final ConnectedDevice device;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44 * scale,
          height: 44 * scale,
          decoration: BoxDecoration(
            color: device.accentColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(14 * scale),
          ),
          alignment: Alignment.center,
          child: Icon(device.icon, color: device.accentColor, size: 22 * scale),
        ),
        SizedBox(width: 12 * scale),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(device.name, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
                  ),
                  _StatusDot(scale: scale, color: device.statusColor),
                ],
              ),
              SizedBox(height: 4 * scale),
              Text(device.location, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
              SizedBox(height: 2 * scale),
              Text(device.platform, style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 11 * scale)),
            ],
          ),
        ),
      ],
    );
  }
}

class _SessionTile extends StatelessWidget {
  const _SessionTile({required this.scale, required this.session});

  final double scale;
  final SessionLog session;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.devices_outlined, color: const Color(0xFF94A3B8), size: 20 * scale),
        SizedBox(width: 12 * scale),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(session.device, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 13 * scale, fontWeight: FontWeight.w600)),
              SizedBox(height: 2 * scale),
              Text('${session.location} • ${session.timestamp}', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
              SizedBox(height: 2 * scale),
              Text(session.platform, style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 11 * scale)),
            ],
          ),
        ),
        _ValuePill(scale: scale, label: session.statusLabel, color: session.statusColor),
      ],
    );
  }
}

class _PrivacyTile extends StatelessWidget {
  const _PrivacyTile({
    required this.scale,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.trailing,
    this.onTap,
  });

  final double scale;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final Widget trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16 * scale),
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 48 * scale,
            height: 48 * scale,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16 * scale),
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: iconColor, size: 22 * scale),
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
          trailing,
        ],
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
    required this.onTap,
  });

  final double scale;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16 * scale),
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 48 * scale,
            height: 48 * scale,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16 * scale),
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: iconColor, size: 22 * scale),
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
          Icon(Icons.chevron_right_rounded, color: const Color(0xFFCBD5F5), size: 22 * scale),
        ],
      ),
    );
  }
}

class _GhostButton extends StatelessWidget {
  const _GhostButton({required this.scale, required this.label, required this.onTap});

  final double scale;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 8 * scale),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scale)),
        side: const BorderSide(color: Color(0xFFE2E8F0)),
        foregroundColor: const Color(0xFF0B1220),
        textStyle: GoogleFonts.inter(fontSize: 13 * scale, fontWeight: FontWeight.w600),
      ),
      child: Text(label),
    );
  }
}

class _ValuePill extends StatelessWidget {
  const _ValuePill({required this.scale, required this.label, required this.color});

  final double scale;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(color: color, fontSize: 12 * scale, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _StatusDot extends StatelessWidget {
  const _StatusDot({required this.scale, required this.color});

  final double scale;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8 * scale,
      height: 8 * scale,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
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


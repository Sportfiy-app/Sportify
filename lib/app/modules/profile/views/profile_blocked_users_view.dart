import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/profile_blocked_users_controller.dart';

class ProfileBlockedUsersView extends GetView<ProfileBlockedUsersController> {
  const ProfileBlockedUsersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const designWidth = 375.0;
          final width = constraints.maxWidth.isFinite ? constraints.maxWidth : MediaQuery.of(context).size.width;
          final scale = (width / designWidth).clamp(0.9, 1.1);

          return Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFF7FAFF), Colors.white],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 12 * scale),
                      child: _Header(scale: scale),
                    ),
                    Expanded(
                      child: Obx(
                        () => SingleChildScrollView(
                          padding: EdgeInsets.symmetric(horizontal: 16 * scale).copyWith(bottom: 140 * scale),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _HeroCard(scale: scale, blockedCount: controller.blockedUsers.length, onUnblockAll: controller.unblockAll),
                              SizedBox(height: 20 * scale),
                              _SearchField(scale: scale),
                              SizedBox(height: 20 * scale),
                              if (controller.blockedUsers.isEmpty)
                                _EmptyState(scale: scale)
                              else
                                _BlockedUsersList(scale: scale),
                              SizedBox(height: 24 * scale),
                              _HistoryCard(scale: scale),
                              SizedBox(height: 24 * scale),
                              _InfoCard(scale: scale),
                              SizedBox(height: 24 * scale),
                              _QuickActions(scale: scale),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: Get.back,
          child: Container(
            width: 42 * scale,
            height: 42 * scale,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.arrow_back_ios_new_rounded, color: const Color(0xFF0B1220), size: 18 * scale),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'Utilisateurs bloqués',
              style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Container(
          width: 42 * scale,
          height: 42 * scale,
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          alignment: Alignment.center,
          child: Icon(Icons.more_horiz_rounded, color: const Color(0xFF475569), size: 18 * scale),
        ),
      ],
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.scale, required this.blockedCount, required this.onUnblockAll});

  final double scale;
  final int blockedCount;
  final VoidCallback onUnblockAll;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 14 * scale, offset: Offset(0, 8 * scale)),
        ],
      ),
      padding: EdgeInsets.all(20 * scale),
      child: Row(
        children: [
          Container(
            width: 56 * scale,
            height: 56 * scale,
            decoration: BoxDecoration(
              color: const Color(0x19EF4444),
              borderRadius: BorderRadius.circular(16 * scale),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.block_flipped, color: const Color(0xFFEF4444), size: 26 * scale),
          ),
          SizedBox(width: 16 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Gestion des blocages', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
                SizedBox(height: 6 * scale),
                Text(
                  blockedCount == 0 ? 'Vous n’avez bloqué aucun utilisateur.' : '$blockedCount utilisateur(s) actuellement bloqué(s)',
                  style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale),
                ),
              ],
            ),
          ),
          SizedBox(width: 12 * scale),
          TextButton(
            onPressed: blockedCount == 0 ? null : onUnblockAll,
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 10 * scale),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
              foregroundColor: const Color(0xFF176BFF),
            ),
            child: Text('Tout débloquer', style: GoogleFonts.inter(fontSize: 13 * scale, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

class _SearchField extends GetView<ProfileBlockedUsersController> {
  const _SearchField({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller.searchController,
      onChanged: controller.toggleSearch,
      decoration: InputDecoration(
        hintText: 'Rechercher un utilisateur bloqué...',
        prefixIcon: Icon(Icons.search_rounded, color: const Color(0xFF94A3B8), size: 20 * scale),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 14 * scale),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12 * scale),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12 * scale),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12 * scale),
          borderSide: const BorderSide(color: Color(0xFF2563EB)),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: EdgeInsets.symmetric(vertical: 40 * scale, horizontal: 20 * scale),
      child: Column(
        children: [
          Icon(Icons.emoji_people_rounded, color: const Color(0xFF94A3B8), size: 48 * scale),
          SizedBox(height: 12 * scale),
          Text('Aucun utilisateur bloqué', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 17 * scale, fontWeight: FontWeight.w600)),
          SizedBox(height: 8 * scale),
          Text(
            'Vous n’avez bloqué personne pour le moment. Si vous bloquez un utilisateur, il apparaîtra ici.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale, height: 1.5),
          ),
        ],
      ),
    );
  }
}

class _BlockedUsersList extends GetView<ProfileBlockedUsersController> {
  const _BlockedUsersList({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final items = controller.filteredBlockedUsers;
    if (items.isEmpty) {
      return _EmptyState(scale: scale);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Liste actuelle', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
        SizedBox(height: 12 * scale),
        ...items.map(
          (user) => Padding(
            padding: EdgeInsets.only(bottom: 14 * scale),
            child: _BlockedUserTile(scale: scale, user: user),
          ),
        ),
      ],
    );
  }
}

class _BlockedUserTile extends GetView<ProfileBlockedUsersController> {
  const _BlockedUserTile({required this.scale, required this.user});

  final double scale;
  final BlockedUser user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.snackbar(user.name, 'Affichage détaillé à venir.'),
      borderRadius: BorderRadius.circular(18 * scale),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 12 * scale, offset: Offset(0, 8 * scale)),
          ],
        ),
        padding: EdgeInsets.all(16 * scale),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CircleAvatar(radius: 28 * scale, backgroundImage: NetworkImage(user.avatarUrl)),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 22 * scale,
                    height: 22 * scale,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEF4444),
                      borderRadius: BorderRadius.circular(12 * scale),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.block, color: Colors.white, size: 12 * scale),
                  ),
                ),
              ],
            ),
            SizedBox(width: 16 * scale),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(user.name, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
                      ),
                      Icon(Icons.chevron_right_rounded, color: const Color(0xFFCBD5F5), size: 22 * scale),
                    ],
                  ),
                  SizedBox(height: 4 * scale),
                  Text(user.username, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale)),
                  SizedBox(height: 4 * scale),
                  Text(user.blockedAgoLabel, style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 12.5 * scale)),
                  SizedBox(height: 12 * scale),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: OutlinedButton(
                      onPressed: () => controller.confirmUnblock(user),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF16A34A)),
                        foregroundColor: const Color(0xFF16A34A),
                        padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 10 * scale),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                      ),
                      child: Text('Débloquer', style: GoogleFonts.inter(fontSize: 13.5 * scale, fontWeight: FontWeight.w600)),
                    ),
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

class _HistoryCard extends GetView<ProfileBlockedUsersController> {
  const _HistoryCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    if (controller.history.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: EdgeInsets.all(20 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text('Historique des blocages', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
              ),
              TextButton(
                onPressed: () => Get.snackbar('Historique complet', 'Fonctionnalité à venir.'),
                child: Text('Voir tout', style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 13 * scale, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          SizedBox(height: 12 * scale),
          ...controller.history.map(
            (entry) => Container(
              margin: EdgeInsets.only(bottom: 10 * scale),
              padding: EdgeInsets.symmetric(horizontal: 14 * scale, vertical: 12 * scale),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(14 * scale),
              ),
              child: Row(
                children: [
                  Container(
                    width: 32 * scale,
                    height: 32 * scale,
                    decoration: BoxDecoration(
                      color: const Color(0x33EF4444),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.history_rounded, color: const Color(0xFFEF4444), size: 16 * scale),
                  ),
                  SizedBox(width: 12 * scale),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(entry.user, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
                        SizedBox(height: 2 * scale),
                        Text(entry.relativeTime, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 6 * scale),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2E8F0),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(entry.statusLabel, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale, fontWeight: FontWeight.w600)),
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

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0x190EA5E9),
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: const Color(0x330EA5E9)),
      ),
      padding: EdgeInsets.all(20 * scale),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36 * scale,
            height: 36 * scale,
            decoration: BoxDecoration(
              color: const Color(0x330EA5E9),
              borderRadius: BorderRadius.circular(14 * scale),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.info_outline_rounded, color: const Color(0xFF0EA5E9), size: 20 * scale),
          ),
          SizedBox(width: 14 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('À savoir', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
                SizedBox(height: 8 * scale),
                ...const [
                  '• Les utilisateurs bloqués ne peuvent plus vous contacter.',
                  '• Ils ne voient plus vos publications et événements.',
                  '• Le déblocage restaure immédiatement les interactions.',
                  '• L’historique des messages reste conservé.',
                ].map(
                  (line) => Padding(
                    padding: EdgeInsets.only(bottom: 6 * scale),
                    child: Text(line, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13.5 * scale, height: 1.45)),
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

class _QuickActions extends StatelessWidget {
  const _QuickActions({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: EdgeInsets.all(20 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Actions rapides', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
          SizedBox(height: 16 * scale),
          Row(
            children: [
              Expanded(
                child: _QuickActionCard(
                  scale: scale,
                  icon: Icons.shield_outlined,
                  label: 'Confidentialité',
                  color: const Color(0xFF176BFF),
                  onTap: () => Get.snackbar('Confidentialité', 'Paramètres de confidentialité à venir.'),
                ),
              ),
              SizedBox(width: 12 * scale),
              Expanded(
                child: _QuickActionCard(
                  scale: scale,
                  icon: Icons.support_agent_rounded,
                  label: 'Contacter le support',
                  color: const Color(0xFFF59E0B),
                  onTap: () => Get.snackbar('Support', 'Notre équipe vous aide rapidement.'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({required this.scale, required this.icon, required this.label, required this.color, required this.onTap});

  final double scale;
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14 * scale),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 18 * scale),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(14 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48 * scale,
              height: 48 * scale,
              decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(999)),
              alignment: Alignment.center,
              child: Icon(icon, color: color, size: 24 * scale),
            ),
            SizedBox(height: 12 * scale),
            Text(label, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/profile_annonces_controller.dart';

class ProfileAnnoncesView extends GetView<ProfileAnnoncesController> {
  const ProfileAnnoncesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const designWidth = 375.0;
          final width = constraints.maxWidth.isFinite ? constraints.maxWidth : MediaQuery.of(context).size.width;
          final scale = (width / designWidth).clamp(0.9, 1.1);
          final padding = MediaQuery.of(context).padding;

          return SafeArea(
            child: Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 140 * scale),
                        child: Column(
                          children: [
                            _Header(scale: scale),
                            _HeroSummary(scale: scale),
                            _QuickActions(scale: scale),
                            _FilterBar(scale: scale),
                            _AnnoncesList(scale: scale),
                            _LoadMoreButton(scale: scale),
                            _InsightsSection(scale: scale),
                            _ActivitySection(scale: scale),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: _BottomNavigation(scale: scale),
                ),
                Positioned(
                  right: 20 * scale,
                  bottom: 96 * scale + padding.bottom,
                  child: _FloatingCTA(scale: scale),
                ),
              ],
            ),
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 18 * scale),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: [
          _RoundButton(
            scale: scale,
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: Get.back,
          ),
          SizedBox(width: 12 * scale),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Mes annonces', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 20 * scale, fontWeight: FontWeight.w700)),
              SizedBox(height: 2 * scale),
              Text('Gestion et performances', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
            ],
          ),
          const Spacer(),
          _RoundButton(
            scale: scale,
            icon: Icons.settings_outlined,
            onTap: () => Get.snackbar('Paramètres', 'Paramètres des annonces à venir.'),
          ),
        ],
      ),
    );
  }
}

class _HeroSummary extends GetView<ProfileAnnoncesController> {
  const _HeroSummary({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final summary = controller.summary;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 20 * scale),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
          begin: Alignment(0.3, 0.3),
          end: Alignment(0.9, -0.4),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _SummaryMetric(scale: scale, label: 'Total', value: summary.total.toString()),
              SizedBox(width: 12 * scale),
              _SummaryMetric(scale: scale, label: 'Actives', value: summary.active.toString()),
              SizedBox(width: 12 * scale),
              _SummaryMetric(scale: scale, label: 'Vues', value: summary.views.toString()),
              SizedBox(width: 12 * scale),
              _SummaryMetric(scale: scale, label: 'Likes', value: summary.likes.toString()),
            ],
          ),
          SizedBox(height: 20 * scale),
          Container(
          padding: EdgeInsets.all(16 * scale),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(16 * scale),
            border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
          ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Page vues cette semaine', style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.85), fontSize: 12 * scale)),
                          SizedBox(height: 6 * scale),
                          Text(
                            '+${summary.newViews}',
                            style: GoogleFonts.poppins(color: Colors.white, fontSize: 22 * scale, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 4 * scale),
                          Text(
                            '+23% vs semaine dernière',
                            style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.75), fontSize: 12 * scale),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nouveaux likes', style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.85), fontSize: 12 * scale)),
                          SizedBox(height: 6 * scale),
                          Text(
                            '+${summary.newLikes}',
                            style: GoogleFonts.poppins(color: Colors.white, fontSize: 22 * scale, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 4 * scale),
                          Text(
                            '+15% vs semaine dernière',
                            style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.75), fontSize: 12 * scale),
                          ),
                        ],
                      ),
                    ),
                  ],
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 16 * scale),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: ElevatedButton.icon(
              onPressed: () => Get.snackbar('Annonce', 'Création de nouvelle annonce prochainement.'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF176BFF),
                padding: EdgeInsets.symmetric(vertical: 14 * scale),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
              ),
              icon: Icon(Icons.add_rounded, color: Colors.white, size: 18 * scale),
              label: Text('Nouvelle annonce', style: GoogleFonts.inter(color: Colors.white, fontSize: 14 * scale, fontWeight: FontWeight.w600)),
            ),
          ),
          SizedBox(width: 12 * scale),
          _SquareButton(
            scale: scale,
            icon: Icons.tune_rounded,
            onTap: () => Get.snackbar('Filtres', 'Filtrer vos annonces prochainement.'),
          ),
          SizedBox(width: 12 * scale),
          _SquareButton(
            scale: scale,
            icon: Icons.more_horiz_rounded,
            onTap: () => Get.snackbar('Options', 'Options rapides à venir.'),
          ),
        ],
      ),
    );
  }
}

class _FilterBar extends GetView<ProfileAnnoncesController> {
  const _FilterBar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 12 * scale),
      child: Obx(
        () {
          final selected = controller.filter.value;
          return Wrap(
            spacing: 8 * scale,
            runSpacing: 8 * scale,
            children: [
              _FilterChip(
                scale: scale,
                label: 'Toutes (${controller.summary.total})',
                isSelected: selected == AnnonceFilter.all,
                onTap: () => controller.setFilter(AnnonceFilter.all),
              ),
              _FilterChip(
                scale: scale,
                label: 'Actives (${controller.summary.active})',
                isSelected: selected == AnnonceFilter.active,
                onTap: () => controller.setFilter(AnnonceFilter.active),
              ),
              _FilterChip(
                scale: scale,
                label: 'Expirées (5)',
                isSelected: selected == AnnonceFilter.expired,
                onTap: () => controller.setFilter(AnnonceFilter.expired),
              ),
              _FilterChip(
                scale: scale,
                label: 'Brouillons (2)',
                isSelected: selected == AnnonceFilter.draft,
                onTap: () => controller.setFilter(AnnonceFilter.draft),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _AnnoncesList extends GetView<ProfileAnnoncesController> {
  const _AnnoncesList({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final items = controller.filteredAnnonces;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16 * scale),
          child: Column(
            children: items.map((annonce) => _AnnonceCard(scale: scale, annonce: annonce)).toList(),
          ),
        );
      },
    );
  }
}

class _AnnonceCard extends StatelessWidget {
  const _AnnonceCard({required this.scale, required this.annonce});

  final double scale;
  final AnnonceCard annonce;

  @override
  Widget build(BuildContext context) {
    final statusColor = annonceStatusColor(annonce.status);
    final controller = Get.find<ProfileAnnoncesController>();

    return Container(
      margin: EdgeInsets.only(bottom: 14 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 12 * scale, offset: Offset(0, 6 * scale)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(18 * scale)),
                child: AspectRatio(
                  aspectRatio: 343 / 192,
                  child: Image.network(annonce.imageUrl, fit: BoxFit.cover),
                ),
              ),
              Positioned(
                left: 16 * scale,
                top: 16 * scale,
                child: Wrap(
                  spacing: 8 * scale,
                  children: [
                    ...annonce.badges.map(
                      (badge) => Container(
                        padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFB800),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: Colors.white, width: 1 * scale),
                        ),
                        child: Text(
                          badge,
                          style: GoogleFonts.inter(color: Colors.white, fontSize: 12 * scale, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: Colors.white, width: 1 * scale),
                      ),
                      child: Text(
                        annonceStatusLabel(annonce.status),
                        style: GoogleFonts.inter(color: Colors.white, fontSize: 12 * scale, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 16 * scale,
                top: 16 * scale,
                child: _IconBadge(
                  scale: scale,
                  icon: Icons.more_horiz_rounded,
                  onTap: () => Get.snackbar('Options', 'Menu contextuel à venir.'),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16 * scale, 16 * scale, 16 * scale, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 18 * scale,
                      backgroundImage: const NetworkImage('https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=200&q=60'),
                    ),
                    SizedBox(width: 12 * scale),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(annonce.title, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
                          SizedBox(height: 2 * scale),
                          Text(
                            '${annonce.subtitle} • ${annonce.timeAgo}',
                            style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale),
                          ),
                        ],
                      ),
                    ),
                    _IconBadge(
                      scale: scale,
                      icon: Icons.stacked_bar_chart_rounded,
                      onTap: () => Get.snackbar('Statistiques', 'Statistiques détaillées en préparation.'),
                    ),
                  ],
                ),
                SizedBox(height: 12 * scale),
                Text(
                  annonce.description,
                  style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale, height: 1.55),
                ),
                SizedBox(height: 16 * scale),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _StatRow(
                      scale: scale,
                      stats: [
                        _StatItem(icon: Icons.favorite_border_rounded, value: annonce.stats.likes),
                        _StatItem(icon: Icons.chat_bubble_outline_rounded, value: annonce.stats.comments),
                        _StatItem(icon: Icons.reply_outlined, value: annonce.stats.shares),
                        _StatItem(icon: Icons.visibility_outlined, value: annonce.stats.views),
                      ],
                    ),
                    TextButton(
                      onPressed: () => _showManageAnnonceSheet(controller),
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF176BFF),
                        padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 10 * scale),
                        textStyle: GoogleFonts.inter(fontSize: 13 * scale, fontWeight: FontWeight.w600),
                      ),
                      child: const Text('Gérer'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showManageAnnonceSheet(ProfileAnnoncesController controller) {
    Get.bottomSheet(
      _ManageAnnonceSheet(scale: scale, annonce: annonce, controller: controller),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}

class _LoadMoreButton extends GetView<ProfileAnnoncesController> {
  const _LoadMoreButton({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 16 * scale),
      child: OutlinedButton.icon(
        onPressed: controller.loadMore,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 14 * scale),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
          side: BorderSide(color: const Color(0xFF176BFF), width: 1.5 * scale),
        ),
        icon: Icon(Icons.refresh_rounded, color: const Color(0xFF176BFF), size: 18 * scale),
        label: Text('Charger plus d’annonces', style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
      ),
    );
  }
}

class _InsightsSection extends GetView<ProfileAnnoncesController> {
  const _InsightsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final summary = controller.summary;
    final engagementColor = summary.engagementDelta >= 0 ? const Color(0xFF16A34A) : const Color(0xFFEF4444);

    return Padding(
      padding: EdgeInsets.fromLTRB(16 * scale, 8 * scale, 16 * scale, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Performances cette semaine', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600)),
              Text('+${summary.engagementDelta.toStringAsFixed(1)}%', style: GoogleFonts.inter(color: engagementColor, fontSize: 14 * scale, fontWeight: FontWeight.w600)),
            ],
          ),
          SizedBox(height: 14 * scale),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16 * scale),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)]),
                    borderRadius: BorderRadius.circular(16 * scale),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.visibility_outlined, color: Colors.white, size: 20 * scale),
                      SizedBox(height: 12 * scale),
                      Text('+${summary.newViews}', style: GoogleFonts.poppins(color: Colors.white, fontSize: 20 * scale, fontWeight: FontWeight.w700)),
                      SizedBox(height: 4 * scale),
                      Text('Nouvelles vues', style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.85), fontSize: 12 * scale)),
                      Text('+23% vs semaine dernière', style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.7), fontSize: 11 * scale)),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12 * scale),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16 * scale),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xFF16A34A), Color(0xFF22C55E)]),
                    borderRadius: BorderRadius.circular(16 * scale),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.favorite_border_rounded, color: Colors.white, size: 20 * scale),
                      SizedBox(height: 12 * scale),
                      Text('+${summary.newLikes}', style: GoogleFonts.poppins(color: Colors.white, fontSize: 20 * scale, fontWeight: FontWeight.w700)),
                      SizedBox(height: 4 * scale),
                      Text('Nouveaux likes', style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.85), fontSize: 12 * scale)),
                      Text('+15% vs semaine dernière', style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.7), fontSize: 11 * scale)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16 * scale),
          Container(
            padding: EdgeInsets.all(16 * scale),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(16 * scale),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Taux d’engagement', style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600)),
                    Text('+${summary.engagementDelta.toStringAsFixed(1)}%', style: GoogleFonts.inter(color: engagementColor, fontSize: 13 * scale, fontWeight: FontWeight.w600)),
                  ],
                ),
                SizedBox(height: 12 * scale),
                Container(
                  height: 8 * scale,
                  decoration: BoxDecoration(color: const Color(0xFFE2E8F0), borderRadius: BorderRadius.circular(999)),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: 0.68,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [Color(0xFF176BFF), Color(0xFF22C55E)]),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12 * scale),
                Text('68% d’engagement moyen sur vos annonces actives cette semaine.', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
              ],
            ),
          ),
          SizedBox(height: 16 * scale),
          Container(
            padding: EdgeInsets.all(16 * scale),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFFFFB800), Color(0xFFFACC15)]),
              borderRadius: BorderRadius.circular(16 * scale),
            ),
            child: Row(
              children: [
                Container(
                  width: 40 * scale,
                  height: 40 * scale,
                  decoration: BoxDecoration(color: const Color(0xFFFFB800), borderRadius: BorderRadius.circular(14 * scale)),
                  alignment: Alignment.center,
                  child: Icon(Icons.lightbulb_outline_rounded, color: Colors.white, size: 22 * scale),
                ),
                SizedBox(width: 14 * scale),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Conseil du jour', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
                      SizedBox(height: 4 * scale),
                      Text(
                        'Ajoutez des photos de qualité à vos annonces pour augmenter l’engagement de 40% en moyenne.',
                        style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 12 * scale),
                      ),
                      SizedBox(height: 8 * scale),
                      GestureDetector(
                        onTap: () => Get.snackbar('Conseils', 'Article détaillé à venir.'),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('En savoir plus', style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 12 * scale, fontWeight: FontWeight.w600)),
                            SizedBox(width: 4 * scale),
                            Icon(Icons.arrow_forward_ios_rounded, color: const Color(0xFF176BFF), size: 12 * scale),
                          ],
                        ),
                      ),
                    ],
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

class _ActivitySection extends GetView<ProfileAnnoncesController> {
  const _ActivitySection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final activities = controller.activities;

    Color toneColorFor(ActivityTone tone) {
      switch (tone) {
        case ActivityTone.primary:
          return const Color(0xFFEFF6FF);
        case ActivityTone.success:
          return const Color(0xFFF0FDF4);
        case ActivityTone.warning:
          return const Color(0xFFFEFCE8);
      }
    }

    Color iconColorFor(ActivityTone tone) {
      switch (tone) {
        case ActivityTone.primary:
          return const Color(0xFF176BFF);
        case ActivityTone.success:
          return const Color(0xFF16A34A);
        case ActivityTone.warning:
          return const Color(0xFFFFB800);
      }
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(16 * scale, 20 * scale, 16 * scale, 120 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Activité récente', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600)),
          SizedBox(height: 14 * scale),
          Column(
            children: activities
                .map(
                  (activity) => Container(
                    margin: EdgeInsets.only(bottom: 12 * scale),
                    padding: EdgeInsets.all(16 * scale),
                    decoration: BoxDecoration(
                      color: toneColorFor(activity.tone),
                      borderRadius: BorderRadius.circular(14 * scale),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36 * scale,
                          height: 36 * scale,
                          decoration: BoxDecoration(
                    color: iconColorFor(activity.tone).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12 * scale),
                          ),
                          alignment: Alignment.center,
                          child: Icon(Icons.campaign_rounded, color: iconColorFor(activity.tone), size: 18 * scale),
                        ),
                        SizedBox(width: 12 * scale),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(activity.message, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 13 * scale, fontWeight: FontWeight.w600)),
                              SizedBox(height: 4 * scale),
                              Text(activity.timeAgo, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
                            ],
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

class _BottomNavigation extends StatelessWidget {
  const _BottomNavigation({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84 * scale + MediaQuery.of(context).padding.bottom,
      padding: EdgeInsets.only(top: 10 * scale, bottom: 16 * scale + MediaQuery.of(context).padding.bottom),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          _NavItem(icon: Icons.home_rounded, label: 'À la une'),
          _NavItem(icon: Icons.search_rounded, label: 'Trouver'),
          _NavItem(icon: Icons.calendar_month_rounded, label: 'Réserver'),
          _NavItem(icon: Icons.person_outline_rounded, label: 'Profil', active: true),
        ],
      ),
    );
  }
}

class _FloatingCTA extends StatelessWidget {
  const _FloatingCTA({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFF176BFF),
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(color: const Color(0x19176BFF), blurRadius: 18 * scale, offset: Offset(0, 10 * scale)),
        ],
      ),
      child: Icon(Icons.add_rounded, color: Colors.white, size: 26 * scale),
    );
  }
}

class _SummaryMetric extends StatelessWidget {
  const _SummaryMetric({required this.scale, required this.label, required this.value});

  final double scale;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14 * scale),
        decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14 * scale),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      ),
        child: Column(
          children: [
            Text(value, style: GoogleFonts.poppins(color: Colors.white, fontSize: 18 * scale, fontWeight: FontWeight.w700)),
            SizedBox(height: 4 * scale),
            Text(label, style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.7), fontSize: 12 * scale)),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.scale, required this.label, required this.isSelected, required this.onTap});

  final double scale;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 10 * scale),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF176BFF) : const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: isSelected ? const Color(0xFF176BFF) : const Color(0xFFE2E8F0)),
          boxShadow: isSelected ? [BoxShadow(color: const Color(0x33176BFF), blurRadius: 12 * scale, offset: Offset(0, 6 * scale))] : null,
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: isSelected ? Colors.white : const Color(0xFF475569),
            fontSize: 13 * scale,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({required this.scale, required this.stats});

  final double scale;
  final List<_StatItem> stats;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: stats
          .map(
            (item) => Padding(
              padding: EdgeInsets.only(right: 12 * scale),
              child: Row(
                children: [
                  Icon(item.icon, color: const Color(0xFF475569), size: 16 * scale),
                  SizedBox(width: 4 * scale),
                  Text(item.value.toString(), style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _StatItem {
  const _StatItem({required this.icon, required this.value});

  final IconData icon;
  final int value;
}

class _NavItem extends StatelessWidget {
  const _NavItem({required this.icon, required this.label, this.active = false});

  final IconData icon;
  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: active ? const Color(0xFF176BFF) : const Color(0xFF475569)),
        SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.inter(
            color: active ? const Color(0xFF176BFF) : const Color(0xFF475569),
            fontSize: 12,
            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        SizedBox(height: 6),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: active ? 24 : 0,
          height: 3,
          decoration: BoxDecoration(
            color: active ? const Color(0xFF176BFF) : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ],
    );
  }
}

class _IconBadge extends StatelessWidget {
  const _IconBadge({required this.scale, required this.icon, required this.onTap});

  final double scale;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36 * scale,
        height: 36 * scale,
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(12 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: const Color(0xFF475569), size: 18 * scale),
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  const _RoundButton({required this.scale, required this.icon, required this.onTap});

  final double scale;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42 * scale,
        height: 42 * scale,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: const Color(0xFF475569), size: 18 * scale),
      ),
    );
  }
}

class _SquareButton extends StatelessWidget {
  const _SquareButton({required this.scale, required this.icon, required this.onTap});

  final double scale;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48 * scale,
        height: 48 * scale,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: const Color(0xFF475569), size: 20 * scale),
      ),
    );
  }
}

class _ManageAnnonceSheet extends StatelessWidget {
  const _ManageAnnonceSheet({
    required this.scale,
    required this.annonce,
    required this.controller,
  });

  final double scale;
  final AnnonceCard annonce;
  final ProfileAnnoncesController controller;

  @override
  Widget build(BuildContext context) {
    final statusColor = annonceStatusColor(annonce.status);
    final statusLabel = annonceStatusLabel(annonce.status);

    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28 * scale)),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 20 * scale, offset: Offset(0, -12 * scale)),
          ],
        ),
        padding: EdgeInsets.fromLTRB(
          20 * scale,
          12 * scale,
          20 * scale,
          20 * scale + MediaQuery.of(context).padding.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 44 * scale,
                height: 4 * scale,
                decoration: BoxDecoration(color: const Color(0xFFE2E8F0), borderRadius: BorderRadius.circular(999)),
              ),
            ),
            SizedBox(height: 16 * scale),
            Text('Gérer mon annonce', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600)),
            SizedBox(height: 12 * scale),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(annonce.title, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
                      SizedBox(height: 4 * scale),
                      Text(annonce.subtitle, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                  decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(999)),
                  child: Text(statusLabel, style: GoogleFonts.inter(color: statusColor, fontSize: 12 * scale, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            if (annonce.description.isNotEmpty) ...[
              SizedBox(height: 12 * scale),
              Text(
                annonce.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 12 * scale, height: 1.4),
              ),
            ],
            SizedBox(height: 20 * scale),
            ElevatedButton(
              onPressed: () => controller.editAnnonce(annonce),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF176BFF),
                padding: EdgeInsets.symmetric(vertical: 14 * scale),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
                textStyle: GoogleFonts.inter(fontSize: 15 * scale, fontWeight: FontWeight.w600),
              ),
              child: const Text('Modifier l’annonce'),
            ),
            SizedBox(height: 12 * scale),
            OutlinedButton(
              onPressed: () => controller.duplicateAnnonce(annonce),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF176BFF),
                side: const BorderSide(color: Color(0xFFDBEAFE)),
                padding: EdgeInsets.symmetric(vertical: 14 * scale),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
                textStyle: GoogleFonts.inter(fontSize: 14 * scale, fontWeight: FontWeight.w600),
              ),
              child: const Text('Dupliquer l’annonce'),
            ),
            SizedBox(height: 12 * scale),
            TextButton(
              onPressed: () => controller.confirmDeletion(annonce),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFEF4444),
                padding: EdgeInsets.symmetric(vertical: 12 * scale),
                textStyle: GoogleFonts.inter(fontSize: 14 * scale, fontWeight: FontWeight.w600),
              ),
              child: const Text('Supprimer l’annonce'),
            ),
            SizedBox(height: 12 * scale),
            TextButton(
              onPressed: Get.back,
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF0B1220),
                padding: EdgeInsets.symmetric(vertical: 14 * scale),
                textStyle: GoogleFonts.inter(fontSize: 14 * scale, fontWeight: FontWeight.w600),
              ),
              child: const Text('Annuler'),
            ),
          ],
        ),
      ),
    );
  }
}

Color annonceStatusColor(AnnonceStatus status) {
  switch (status) {
    case AnnonceStatus.active:
      return const Color(0xFF16A34A);
    case AnnonceStatus.expiring:
      return const Color(0xFFF59E0B);
    case AnnonceStatus.expired:
      return const Color(0xFFEF4444);
    case AnnonceStatus.draft:
      return const Color(0xFF94A3B8);
  }
}

String annonceStatusLabel(AnnonceStatus status) {
  switch (status) {
    case AnnonceStatus.active:
      return 'Active';
    case AnnonceStatus.expiring:
      return 'Expire bientôt';
    case AnnonceStatus.expired:
      return 'Expirée';
    case AnnonceStatus.draft:
      return 'Brouillon';
  }
}


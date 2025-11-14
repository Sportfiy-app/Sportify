import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/groups_controller.dart';

class GroupsView extends GetView<GroupsController> {
  const GroupsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const designWidth = 375.0;
          final width = constraints.maxWidth.isFinite ? constraints.maxWidth : MediaQuery.of(context).size.width;
          final scale = (width / designWidth).clamp(0.9, 1.1);

          return SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 16 * scale).copyWith(bottom: 110 * scale),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _TopNavigation(scale: scale),
                      SizedBox(height: 18 * scale),
                      _SearchBar(scale: scale),
                      SizedBox(height: 16 * scale),
                      _FilterChips(scale: scale),
                      SizedBox(height: 20 * scale),
                      _StatsSection(scale: scale),
                      SizedBox(height: 24 * scale),
                      _MyGroupsSection(scale: scale),
                      SizedBox(height: 28 * scale),
                      _RecommendationsSection(scale: scale),
                      SizedBox(height: 28 * scale),
                      _PopularGroupsSection(scale: scale),
                      SizedBox(height: 28 * scale),
                      _UpcomingEventsSection(scale: scale),
                      SizedBox(height: 28 * scale),
                      _CategoriesSection(scale: scale),
                      SizedBox(height: 28 * scale),
                      _CommunityFeaturesSection(scale: scale),
                      SizedBox(height: 28 * scale),
                      _RecentActivitySection(scale: scale),
                    ],
                  ),
                ),
                Positioned(
                  right: 24 * scale,
                  bottom: 84 * scale,
                  child: _FloatingCreateButton(scale: scale),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: _BottomNavigation(scale: scale),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _TopNavigation extends GetView<GroupsController> {
  const _TopNavigation({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CircleButton(
          scale: scale,
          icon: Icons.arrow_back_ios_new_rounded,
          onTap: Get.back,
        ),
        SizedBox(width: 12 * scale),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Groupes de sport', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 20 * scale, fontWeight: FontWeight.w700)),
              SizedBox(height: 4 * scale),
              Text('Rejoignez votre communauté', style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 13 * scale)),
            ],
          ),
        ),
        _CircleButton(
          scale: scale,
          icon: Icons.notifications_none_rounded,
          badgeLabel: '3',
          onTap: () => Get.snackbar('Notifications', 'Aucune nouvelle alerte pour le moment.'),
        ),
        SizedBox(width: 12 * scale),
        _CircleButton(
          scale: scale,
          icon: Icons.chat_bubble_outline_rounded,
          badgeLabel: '2',
          onTap: () => Get.snackbar('Messages', 'Ouverture de la messagerie.'),
        ),
      ],
    );
  }
}

class _SearchBar extends GetView<GroupsController> {
  const _SearchBar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48 * scale,
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(14 * scale),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 14 * scale),
            child: Row(
              children: [
                Icon(Icons.search_rounded, color: const Color(0xFF94A3B8), size: 20 * scale),
                SizedBox(width: 10 * scale),
                Expanded(
                  child: TextField(
                    controller: TextEditingController(text: controller.searchQuery.value),
                    onChanged: (value) => controller.searchQuery.value = value,
                    decoration: InputDecoration(
                      hintText: 'Rechercher un groupe...',
                      hintStyle: GoogleFonts.inter(color: const Color(0xFFADAEBC), fontSize: 14 * scale),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 12 * scale),
        GestureDetector(
          onTap: () => Get.snackbar('Filtres', 'Module filtres avancés bientôt disponible.'),
          child: Container(
            width: 48 * scale,
            height: 48 * scale,
            decoration: BoxDecoration(
              color: const Color(0xFF176BFF),
              borderRadius: BorderRadius.circular(14 * scale),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.tune_rounded, color: Colors.white, size: 22 * scale),
          ),
        ),
      ],
    );
  }
}

class _FilterChips extends GetView<GroupsController> {
  const _FilterChips({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44 * scale,
      child: Obx(
        () => ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: controller.filters.length,
          separatorBuilder: (_, __) => SizedBox(width: 12 * scale),
          itemBuilder: (context, index) {
            final chip = controller.filters[index];
            final isSelected = controller.selectedFilter.value == chip.label;
            return GestureDetector(
              onTap: () => controller.selectedFilter.value = chip.label,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 10 * scale),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? const LinearGradient(colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)], begin: Alignment(-0.2, 0.8), end: Alignment(0.8, -0.6))
                      : null,
                  color: isSelected ? null : const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    Icon(chip.icon, size: 16 * scale, color: isSelected ? Colors.white : const Color(0xFF475569)),
                    SizedBox(width: 8 * scale),
                    Text(
                      chip.label,
                      style: GoogleFonts.inter(
                        fontSize: 14 * scale,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? Colors.white : const Color(0xFF475569),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _StatsSection extends GetView<GroupsController> {
  const _StatsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 156 * scale,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: controller.stats
            .map(
              (stat) => Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: stat == controller.stats.last ? 0 : 12 * scale),
                  padding: EdgeInsets.all(18 * scale),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18 * scale),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 48 * scale,
                        height: 48 * scale,
                        decoration: BoxDecoration(color: stat.color.withValues(alpha: 0.1), shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: Icon(stat.icon, color: stat.color, size: 24 * scale),
                      ),
                      SizedBox(height: 16 * scale),
                      Text(stat.value, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 22 * scale, fontWeight: FontWeight.w700)),
                      SizedBox(height: 6 * scale),
                      Text(stat.label, textAlign: TextAlign.center, style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 12.5 * scale)),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.scale,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  final double scale;
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w700)),
        const Spacer(),
        if (actionLabel != null)
          TextButton(
            onPressed: onAction,
            child: Text(actionLabel!, style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 13.5 * scale, fontWeight: FontWeight.w500)),
          ),
      ],
    );
  }
}

class _MyGroupsSection extends GetView<GroupsController> {
  const _MyGroupsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(scale: scale, title: 'Mes groupes', actionLabel: 'Voir tout', onAction: () => Get.snackbar('Mes groupes', 'Navigation à venir.')),
        SizedBox(height: 12 * scale),
        Column(
          children: controller.myGroups
              .map(
                (group) => Container(
                  margin: EdgeInsets.only(bottom: 14 * scale),
                  padding: EdgeInsets.all(20 * scale),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18 * scale),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _GroupAvatar(scale: scale, color: group.badgeColor),
                      SizedBox(width: 16 * scale),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(group.title, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w700)),
                            SizedBox(height: 4 * scale),
                            Text('${group.sport} • ${group.membersLabel}', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
                            SizedBox(height: 10 * scale),
                            Row(
                              children: [
                                Icon(Icons.event_note_rounded, size: 16 * scale, color: const Color(0xFF475569)),
                                SizedBox(width: 6 * scale),
                                Expanded(
                                  child: Text(group.upcomingLabel, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12.5 * scale)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 32 * scale,
                        height: 32 * scale,
                        decoration: BoxDecoration(color: group.badgeColor.withValues(alpha: 0.1), shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: Icon(Icons.more_horiz_rounded, color: group.badgeColor, size: 18 * scale),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _GroupAvatar extends StatelessWidget {
  const _GroupAvatar({required this.scale, required this.color});

  final double scale;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 64 * scale,
          height: 64 * scale,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [color, color.withValues(alpha: 0.8)], begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(16 * scale),
          ),
          alignment: Alignment.center,
          child: Icon(Icons.groups_rounded, color: Colors.white, size: 28 * scale),
        ),
        Positioned(
          right: 2 * scale,
          bottom: 2 * scale,
          child: Container(
            width: 24 * scale,
            height: 24 * scale,
            decoration: BoxDecoration(color: const Color(0xFF16A34A), shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2 * scale)),
            alignment: Alignment.center,
            child: Icon(Icons.check_rounded, color: Colors.white, size: 14 * scale),
          ),
        ),
      ],
    );
  }
}

class _RecommendationsSection extends GetView<GroupsController> {
  const _RecommendationsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final cards = controller.recommended;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(scale: scale, title: 'Recommandés pour vous', actionLabel: 'Voir tout', onAction: () => Get.snackbar('Recommandations', 'Bientôt disponible.')),
        SizedBox(height: 14 * scale),
        Column(
          children: cards
              .map(
                (item) => Container(
                  margin: EdgeInsets.only(bottom: 16 * scale),
                  padding: EdgeInsets.all(20 * scale),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18 * scale),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _GroupCover(scale: scale),
                          SizedBox(width: 16 * scale),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.name, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w700)),
                                SizedBox(height: 4 * scale),
                                Text('${item.sport} • ${item.location}', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
                                SizedBox(height: 10 * scale),
                                Wrap(
                                  spacing: 10 * scale,
                                  runSpacing: 8 * scale,
                                  children: [
                                    _InfoPill(icon: Icons.star_rounded, label: item.rating.toStringAsFixed(1), scale: scale),
                                    _InfoPill(icon: Icons.people_alt_outlined, label: '${item.members} membres', scale: scale),
                                    _InfoPill(icon: Icons.place_outlined, label: item.distance, scale: scale),
                                    _InfoPill(icon: Icons.circle, label: item.activity, scale: scale, iconColor: const Color(0xFF16A34A)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16 * scale),
                      Row(
                        children: [
                          Expanded(
                            child: _MembersPreview(scale: scale),
                          ),
                          SizedBox(width: 14 * scale),
                          _PrimaryButton(label: 'Rejoindre', scale: scale, onTap: () => Get.snackbar('Rejoindre', 'Demande envoyée à ${item.name}.')),
                        ],
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _GroupCover extends StatelessWidget {
  const _GroupCover({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 80 * scale,
          height: 80 * scale,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18 * scale),
            image: const DecorationImage(image: NetworkImage('https://images.unsplash.com/photo-1517649763962-0c623066013b?auto=format&fit=crop&w=400&q=60'), fit: BoxFit.cover),
          ),
        ),
        Positioned(
          right: -4 * scale,
          bottom: -4 * scale,
          child: Container(
            width: 32 * scale,
            height: 32 * scale,
            decoration: BoxDecoration(color: const Color(0xFF176BFF), shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 3 * scale)),
            alignment: Alignment.center,
            child: Icon(Icons.flash_on_rounded, color: Colors.white, size: 18 * scale),
          ),
        ),
      ],
    );
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.icon, required this.label, required this.scale, this.iconColor});

  final IconData icon;
  final String label;
  final double scale;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 6 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16 * scale, color: iconColor ?? const Color(0xFF475569)),
          SizedBox(width: 6 * scale),
          Text(label, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _MembersPreview extends StatelessWidget {
  const _MembersPreview({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final avatars = List.generate(3, (index) => index);
    return SizedBox(
      height: 32 * scale,
      child: Stack(
        children: avatars
            .map(
              (index) => Positioned(
                left: index * 20 * scale,
                child: Container(
                  width: 32 * scale,
                  height: 32 * scale,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9999),
                    border: Border.all(color: Colors.white, width: 2 * scale),
                    image: DecorationImage(
                      image: NetworkImage('https://images.unsplash.com/photo-15${index + 2}361545179-dd7dfa4b8b55?auto=format&fit=crop&w=200&q=60'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            )
            .toList()
          ..add(
            Positioned(
              left: avatars.length * 20 * scale,
              child: Container(
                width: 32 * scale,
                height: 32 * scale,
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(9999),
                  border: Border.all(color: Colors.white, width: 2 * scale),
                ),
                alignment: Alignment.center,
                child: Text('+5', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale, fontWeight: FontWeight.w600)),
              ),
            ),
          ),
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({required this.label, required this.scale, required this.onTap, this.backgroundColor = const Color(0xFF176BFF)});

  final String label;
  final double scale;
  final VoidCallback onTap;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24 * scale, vertical: 12 * scale),
        decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(12 * scale)),
        child: Text(label, style: GoogleFonts.inter(color: Colors.white, fontSize: 14 * scale, fontWeight: FontWeight.w600)),
      ),
    );
  }
}

class _PopularGroupsSection extends GetView<GroupsController> {
  const _PopularGroupsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final hero = controller.featuredGroup;
    final others = controller.popularGroups;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(scale: scale, title: 'Groupes populaires', actionLabel: 'Voir tout', onAction: () => Get.snackbar('Groupes populaires', 'Navigation à venir.')),
        SizedBox(height: 14 * scale),
        _GroupHeroCard(scale: scale, card: hero, highlight: true),
        SizedBox(height: 16 * scale),
        ...others.map((card) => Padding(
              padding: EdgeInsets.only(bottom: 16 * scale),
              child: _GroupHeroCard(scale: scale, card: card),
            )),
      ],
    );
  }
}

class _GroupHeroCard extends StatelessWidget {
  const _GroupHeroCard({required this.scale, required this.card, this.highlight = false});

  final double scale;
  final GroupHeroCard card;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        gradient: highlight
            ? LinearGradient(colors: [card.accentColor, card.accentColor.withValues(alpha: 0.85)], begin: Alignment.topLeft, end: Alignment.bottomRight)
            : null,
        color: highlight ? null : Colors.white,
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: highlight ? card.accentColor.withValues(alpha: 0.4) : const Color(0xFFE2E8F0)),
        boxShadow: highlight
            ? [BoxShadow(color: card.accentColor.withValues(alpha: 0.25), blurRadius: 28 * scale, offset: Offset(0, 18 * scale))]
            : [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 14 * scale, offset: Offset(0, 8 * scale))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56 * scale,
                height: 56 * scale,
                decoration: BoxDecoration(
                  color: highlight ? Colors.white.withValues(alpha: 0.2) : card.accentColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(16 * scale),
                ),
                alignment: Alignment.center,
                child: Icon(Icons.groups_rounded, color: highlight ? Colors.white : card.accentColor, size: 26 * scale),
              ),
              SizedBox(width: 16 * scale),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      card.name,
                      style: GoogleFonts.poppins(
                        color: highlight ? Colors.white : const Color(0xFF0B1220),
                        fontSize: 18 * scale,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4 * scale),
                    Text(
                      card.sport,
                      style: GoogleFonts.inter(
                        color: highlight ? Colors.white.withValues(alpha: 0.85) : const Color(0xFF475569),
                        fontSize: 13.5 * scale,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${card.members}',
                    style: GoogleFonts.poppins(
                      color: highlight ? Colors.white : const Color(0xFF0B1220),
                      fontSize: 20 * scale,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2 * scale),
                  Text(
                    'membres',
                    style: GoogleFonts.inter(
                      color: highlight ? Colors.white.withValues(alpha: 0.75) : const Color(0xFF475569),
                      fontSize: 12 * scale,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 18 * scale),
          Wrap(
            spacing: 10 * scale,
            runSpacing: 8 * scale,
            children: card.badges
                .map(
                  (badge) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 8 * scale),
                    decoration: BoxDecoration(
                      color: highlight ? Colors.white.withValues(alpha: 0.16) : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(badge.icon, size: 16 * scale, color: highlight ? Colors.white : const Color(0xFF475569)),
                        SizedBox(width: 6 * scale),
                        Text(
                          badge.label,
                          style: GoogleFonts.inter(
                            fontSize: 12 * scale,
                            fontWeight: FontWeight.w600,
                            color: highlight ? Colors.white : const Color(0xFF475569),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
          SizedBox(height: 18 * scale),
          Align(
            alignment: Alignment.centerRight,
            child: _PrimaryButton(
              label: 'Rejoindre',
              scale: scale,
              backgroundColor: highlight ? Colors.white : card.accentColor,
              onTap: () => Get.snackbar('Rejoindre', 'Demande envoyée à ${card.name}.'),
            ),
          ),
        ],
      ),
    );
  }
}

class _UpcomingEventsSection extends GetView<GroupsController> {
  const _UpcomingEventsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final events = controller.upcomingEvents;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(scale: scale, title: 'Événements à venir', actionLabel: 'Calendrier', onAction: () => Get.snackbar('Calendrier', 'Synchronisation à venir.')),
        SizedBox(height: 14 * scale),
        Column(
          children: events
              .map(
                (event) => Container(
                  margin: EdgeInsets.only(bottom: 16 * scale),
                  padding: EdgeInsets.all(20 * scale),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18 * scale),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _DateBadge(scale: scale, event: event),
                      SizedBox(width: 16 * scale),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(event.title, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w700)),
                            SizedBox(height: 8 * scale),
                            _EventInfoRow(scale: scale, icon: Icons.access_time_rounded, label: event.timeLabel),
                            SizedBox(height: 6 * scale),
                            _EventInfoRow(scale: scale, icon: Icons.place_outlined, label: event.locationLabel),
                            SizedBox(height: 6 * scale),
                            _EventInfoRow(scale: scale, icon: Icons.people_outline_rounded, label: event.participantsLabel),
                          ],
                        ),
                      ),
                      if (event.statusLabel != null)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 14 * scale, vertical: 8 * scale),
                          decoration: BoxDecoration(color: const Color(0x1916A34A), borderRadius: BorderRadius.circular(12 * scale)),
                          child: Text(event.statusLabel!, style: GoogleFonts.inter(color: const Color(0xFF16A34A), fontSize: 12.5 * scale, fontWeight: FontWeight.w600)),
                        ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _DateBadge extends StatelessWidget {
  const _DateBadge({required this.scale, required this.event});

  final double scale;
  final GroupEventCard event;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52 * scale,
      decoration: BoxDecoration(
        color: const Color(0xFF176BFF),
        borderRadius: BorderRadius.circular(14 * scale),
      ),
      padding: EdgeInsets.symmetric(vertical: 8 * scale),
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(event.dayLabel, style: GoogleFonts.inter(color: Colors.white, fontSize: 12 * scale, fontWeight: FontWeight.w600)),
          SizedBox(height: 6 * scale),
          Text(event.dayNumber, style: GoogleFonts.poppins(color: Colors.white, fontSize: 20 * scale, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _EventInfoRow extends StatelessWidget {
  const _EventInfoRow({required this.scale, required this.icon, required this.label});

  final double scale;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16 * scale, color: const Color(0xFF475569)),
        SizedBox(width: 6 * scale),
        Expanded(child: Text(label, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12.5 * scale))),
      ],
    );
  }
}

class _CategoriesSection extends GetView<GroupsController> {
  const _CategoriesSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(scale: scale, title: 'Explorer par catégorie'),
        SizedBox(height: 14 * scale),
        Wrap(
          spacing: 16 * scale,
          runSpacing: 16 * scale,
          children: controller.categories
              .map((category) => _CategoryCard(scale: scale, category: category))
              .toList(),
        ),
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.scale, required this.category});

  final double scale;
  final GroupCategoryCard category;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 164 * scale,
      padding: EdgeInsets.all(18 * scale),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [category.color.withValues(alpha: 0.1), category.color.withValues(alpha: 0.05)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(color: category.color.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _CategoryIcon(scale: scale, color: category.color),
          SizedBox(height: 12 * scale),
          Text(category.title, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w700)),
          SizedBox(height: 6 * scale),
          Text(category.activeGroups, textAlign: TextAlign.center, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12.5 * scale)),
          SizedBox(height: 12 * scale),
          _PrimaryButton(label: 'Explorer', scale: scale, backgroundColor: category.color, onTap: () => Get.snackbar('Catégorie', 'Découvrir ${category.title}')), 
        ],
      ),
    );
  }
}

class _CategoryIcon extends StatelessWidget {
  const _CategoryIcon({required this.scale, required this.color});

  final double scale;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48 * scale,
      height: 48 * scale,
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(16 * scale)),
      alignment: Alignment.center,
      child: Icon(Icons.sports_soccer_rounded, color: Colors.white, size: 24 * scale),
    );
  }
}

class _CommunityFeaturesSection extends GetView<GroupsController> {
  const _CommunityFeaturesSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(scale: scale, title: 'Fonctionnalités communauté'),
        SizedBox(height: 14 * scale),
        Column(
          children: controller.features
              .map(
                (feature) => Container(
                  margin: EdgeInsets.only(bottom: 14 * scale),
                  padding: EdgeInsets.all(18 * scale),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18 * scale),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 48 * scale,
                        height: 48 * scale,
                        decoration: BoxDecoration(color: feature.background, borderRadius: BorderRadius.circular(14 * scale)),
                        alignment: Alignment.center,
                        child: Icon(feature.icon, color: const Color(0xFF176BFF), size: 22 * scale),
                      ),
                      SizedBox(width: 16 * scale),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(feature.title, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w700)),
                            SizedBox(height: 6 * scale),
                            Text(feature.description, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
                          ],
                        ),
                      ),
                      Icon(Icons.chevron_right_rounded, color: const Color(0xFF94A3B8), size: 22 * scale),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _RecentActivitySection extends GetView<GroupsController> {
  const _RecentActivitySection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(scale: scale, title: 'Activité récente', actionLabel: 'Tout voir', onAction: () => Get.snackbar('Activité', 'Historique complet à venir.')),
        SizedBox(height: 14 * scale),
        Column(
          children: controller.recentActivities
              .map(
                (activity) => Container(
                  margin: EdgeInsets.only(bottom: 12 * scale),
                  padding: EdgeInsets.all(18 * scale),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16 * scale),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 20 * scale,
                        backgroundImage: const NetworkImage('https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=200&q=60'),
                      ),
                      SizedBox(width: 14 * scale),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 13.5 * scale),
                                children: [
                                  TextSpan(text: activity.author, style: const TextStyle(fontWeight: FontWeight.w600)),
                                  TextSpan(text: ' ${activity.message} '),
                                  TextSpan(text: activity.target, style: const TextStyle(color: Color(0xFF176BFF), fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                            SizedBox(height: 8 * scale),
                            Text(activity.timeLabel, style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 12 * scale)),
                          ],
                        ),
                      ),
                      Icon(Icons.more_horiz_rounded, color: const Color(0xFF94A3B8), size: 20 * scale),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _FloatingCreateButton extends StatelessWidget {
  const _FloatingCreateButton({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.snackbar('Créer un groupe', 'Assistant de création à venir.'),
      child: Container(
        width: 58 * scale,
        height: 58 * scale,
        decoration: BoxDecoration(
          color: const Color(0xFF176BFF),
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: const Color(0x4C176BFF), blurRadius: 24 * scale, offset: Offset(0, 12 * scale))],
        ),
        alignment: Alignment.center,
        child: Icon(Icons.add_rounded, color: Colors.white, size: 28 * scale),
      ),
    );
  }
}

class _BottomNavigation extends StatelessWidget {
  const _BottomNavigation({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final items = [
      _BottomNavItem(label: 'Accueil', icon: Icons.home_outlined),
      _BottomNavItem(label: 'Recherche', icon: Icons.search_rounded),
      _BottomNavItem(label: 'Groupes', icon: Icons.groups_rounded, active: true),
      _BottomNavItem(label: 'Messages', icon: Icons.chat_bubble_outline_rounded, badge: '2'),
      _BottomNavItem(label: 'Profil', icon: Icons.person_outline_rounded, avatar: true),
    ];
    return Container(
      decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Color(0xFFE2E8F0)))),
      padding: EdgeInsets.only(bottom: 12 * scale, top: 10 * scale),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) => item.build(scale)).toList(),
      ),
    );
  }
}

class _BottomNavItem {
  _BottomNavItem({
    required this.label,
    required this.icon,
    this.active = false,
    this.badge,
    this.avatar = false,
  });

  final String label;
  final IconData icon;
  final bool active;
  final String? badge;
  final bool avatar;

  Widget build(double scale) {
    final color = active ? const Color(0xFF176BFF) : const Color(0xFF475569);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            avatar
                ? CircleAvatar(
                    radius: 15 * scale,
                    backgroundImage: const NetworkImage('https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=200&q=60'),
                  )
                : Icon(icon, color: color, size: 24 * scale),
            if (badge != null)
              Positioned(
                right: -6 * scale,
                top: -6 * scale,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5 * scale, vertical: 2 * scale),
                  decoration: BoxDecoration(color: const Color(0xFFEF4444), borderRadius: BorderRadius.circular(999)),
                  child: Text(badge!, style: GoogleFonts.inter(color: Colors.white, fontSize: 10 * scale, fontWeight: FontWeight.w700)),
                ),
              ),
          ],
        ),
        SizedBox(height: 6 * scale),
        Text(label, style: GoogleFonts.inter(color: color, fontSize: 11 * scale, fontWeight: active ? FontWeight.w600 : FontWeight.w500)),
      ],
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({required this.scale, required this.icon, required this.onTap, this.badgeLabel});

  final double scale;
  final IconData icon;
  final VoidCallback onTap;
  final String? badgeLabel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 40 * scale,
            height: 40 * scale,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE2E8F0)),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8 * scale, offset: Offset(0, 4 * scale))],
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: const Color(0xFF0B1220), size: 18 * scale),
          ),
          if (badgeLabel != null)
            Positioned(
              right: -2 * scale,
              top: -2 * scale,
              child: Container(
                padding: EdgeInsets.all(4 * scale),
                decoration: BoxDecoration(color: const Color(0xFFEF4444), borderRadius: BorderRadius.circular(999)),
                child: Text(badgeLabel!, style: GoogleFonts.inter(color: Colors.white, fontSize: 10 * scale, fontWeight: FontWeight.w700)),
              ),
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/profile_saved_announcements_controller.dart';

class ProfileSavedAnnouncementsView extends GetView<ProfileSavedAnnouncementsController> {
  const ProfileSavedAnnouncementsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const designWidth = 375.0;
          final width = constraints.maxWidth.isFinite ? constraints.maxWidth : MediaQuery.of(context).size.width;
          final scale = (width / designWidth).clamp(0.88, 1.1);

          return SafeArea(
            child: Column(
              children: [
                _HeaderBar(scale: scale),
                Expanded(
                  child: Obx(
                    () {
                      final announcements = controller.filteredAnnouncements;
                      return CustomScrollView(
                        physics: const BouncingScrollPhysics(),
                        slivers: [
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(16 * scale, 16 * scale, 16 * scale, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _SearchBar(scale: scale, controller: controller),
                                  SizedBox(height: 16 * scale),
                                  _FilterRow(scale: scale, controller: controller),
                                  SizedBox(height: 20 * scale),
                                  _SummaryCard(scale: scale, summary: controller.summary),
                                  SizedBox(height: 16 * scale),
                                  _QuickActions(scale: scale, controller: controller),
                                  SizedBox(height: 12 * scale),
                                  Text(
                                    '${announcements.length} annonce${announcements.length > 1 ? 's' : ''} enregistrée${announcements.length > 1 ? 's' : ''}',
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFF475569),
                                      fontSize: 12 * scale,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 12 * scale),
                                ],
                              ),
                            ),
                          ),
                          if (announcements.isEmpty)
                            SliverFillRemaining(
                              hasScrollBody: false,
                              child: _EmptyState(scale: scale, onClearAll: controller.clearAll),
                            )
                          else
                            SliverPadding(
                              padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                              sliver: SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    final announcement = announcements[index];
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 16 * scale),
                                      child: _AnnouncementCard(
                                        scale: scale,
                                        announcement: announcement,
                                        onOpen: () => controller.openAnnouncement(announcement),
                                        onMessage: () => controller.messageAuthor(announcement),
                                        onBookmark: () => controller.toggleBookmark(announcement),
                                      ),
                                    );
                                  },
                                  childCount: announcements.length,
                                ),
                              ),
                            ),
                        ],
                      );
                    },
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

class _HeaderBar extends StatelessWidget {
  const _HeaderBar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16 * scale, 12 * scale, 16 * scale, 0),
      child: Row(
        children: [
          _CircleButton(
            scale: scale,
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: Get.back,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Annonces enregistrées',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF0B1220),
                    fontSize: 20 * scale,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4 * scale),
                Text(
                  'Retrouvez vos favoris en un clin d’œil',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF64748B),
                    fontSize: 12 * scale,
                  ),
                ),
              ],
            ),
          ),
          _CircleButton(
            scale: scale,
            icon: Icons.notifications_none_rounded,
            onTap: () => Get.snackbar('Notifications', 'Alertes personnalisées à venir.'),
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({required this.scale, required this.controller});

  final double scale;
  final ProfileSavedAnnouncementsController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 12 * scale, offset: Offset(0, 6 * scale)),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 14 * scale),
      child: TextField(
        controller: controller.searchController,
        onChanged: controller.setSearchQuery,
        style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale),
        decoration: InputDecoration(
          icon: Icon(Icons.search_rounded, color: const Color(0xFF94A3B8), size: 20 * scale),
          hintText: 'Rechercher une annonce...',
          hintStyle: GoogleFonts.inter(color: const Color(0xFFADAEBC), fontSize: 14 * scale),
          border: InputBorder.none,
          suffixIcon: Obx(
            () => controller.searchQuery.value.isEmpty
                ? const SizedBox.shrink()
                : IconButton(
                    icon: Icon(Icons.close_rounded, size: 18 * scale, color: const Color(0xFF94A3B8)),
                    onPressed: controller.clearSearch,
                  ),
          ),
        ),
      ),
    );
  }
}

class _FilterRow extends StatelessWidget {
  const _FilterRow({required this.scale, required this.controller});

  final double scale;
  final ProfileSavedAnnouncementsController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 40 * scale,
            child: Obx(
              () => ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: controller.filterOptions.length,
                separatorBuilder: (_, __) => SizedBox(width: 10 * scale),
                itemBuilder: (context, index) {
                  final option = controller.filterOptions[index];
                  final selected = controller.activeFilter.value == option;
                  return ChoiceChip(
                    label: Text(
                      option,
                      style: GoogleFonts.inter(
                        fontSize: 13 * scale,
                        fontWeight: FontWeight.w600,
                        color: selected ? Colors.white : const Color(0xFF475569),
                      ),
                    ),
                    selected: selected,
                    onSelected: (_) => controller.selectFilter(option),
                    selectedColor: const Color(0xFF176BFF),
                    backgroundColor: const Color(0xFFF3F4F6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                  );
                },
              ),
            ),
          ),
        ),
        SizedBox(width: 12 * scale),
        TextButton(
          onPressed: controller.clearAll,
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF176BFF),
            textStyle: GoogleFonts.inter(fontSize: 13 * scale, fontWeight: FontWeight.w600),
          ),
          child: const Text('Effacer tout'),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.scale, required this.summary});

  final double scale;
  final SavedSummary summary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18 * scale),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(18 * scale),
        boxShadow: [
          BoxShadow(color: const Color(0x33176BFF), blurRadius: 20 * scale, offset: Offset(0, 12 * scale)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Vos statistiques',
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 18 * scale, fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              Container(
                width: 40 * scale,
                height: 40 * scale,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(999),
                ),
                alignment: Alignment.center,
                child: Icon(Icons.bar_chart_rounded, color: Colors.white, size: 20 * scale),
              ),
            ],
          ),
          SizedBox(height: 4 * scale),
          Text(
            'Cette semaine',
            style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.8), fontSize: 13 * scale),
          ),
          SizedBox(height: 16 * scale),
          Row(
            children: [
              _SummaryItem(scale: scale, value: summary.total.toString(), label: 'Sauvegardées'),
              SizedBox(width: 12 * scale),
              _SummaryItem(scale: scale, value: summary.contacted.toString(), label: 'Contactées'),
              SizedBox(width: 12 * scale),
              _SummaryItem(scale: scale, value: summary.participations.toString(), label: 'Participations'),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({required this.scale, required this.value, required this.label});

  final double scale;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12 * scale),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(14 * scale),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 20 * scale, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 4 * scale),
            Text(
              label,
              style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.8), fontSize: 12 * scale),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({required this.scale, required this.controller});

  final double scale;
  final ProfileSavedAnnouncementsController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => Get.snackbar('Sélection', 'Sélection multiple à venir.'),
            icon: Icon(Icons.select_all_rounded, color: const Color(0xFF0B1220), size: 18 * scale),
            label: Text(
              'Tout sélectionner',
              style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 13 * scale, fontWeight: FontWeight.w600),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFE2E8F0)),
              padding: EdgeInsets.symmetric(vertical: 12 * scale, horizontal: 12 * scale),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scale)),
              backgroundColor: Colors.white,
            ),
          ),
        ),
        SizedBox(width: 12 * scale),
        Expanded(
          child: TextButton.icon(
            onPressed: controller.clearAll,
            icon: Icon(Icons.delete_outline_rounded, color: const Color(0xFFEF4444), size: 18 * scale),
            label: Text(
              'Supprimer tout',
              style: GoogleFonts.inter(color: const Color(0xFFEF4444), fontSize: 13 * scale, fontWeight: FontWeight.w600),
            ),
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12 * scale, horizontal: 12 * scale),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scale)),
            ),
          ),
        ),
      ],
    );
  }
}

class _AnnouncementCard extends StatelessWidget {
  const _AnnouncementCard({
    required this.scale,
    required this.announcement,
    required this.onOpen,
    required this.onMessage,
    required this.onBookmark,
  });

  final double scale;
  final SavedAnnouncement announcement;
  final VoidCallback onOpen;
  final VoidCallback onMessage;
  final VoidCallback onBookmark;

  @override
  Widget build(BuildContext context) {
    final isExpired = announcement.isExpired;

    return GestureDetector(
      onTap: onOpen,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 12 * scale, offset: Offset(0, 6 * scale)),
          ],
        ),
        padding: EdgeInsets.all(16 * scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24 * scale,
                  backgroundImage: NetworkImage(announcement.authorAvatar),
                ),
                SizedBox(width: 12 * scale),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              announcement.authorName,
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF0B1220),
                                fontSize: 16 * scale,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: onBookmark,
                            icon: Icon(Icons.bookmark_rounded, color: const Color(0xFF176BFF), size: 20 * scale),
                          ),
                        ],
                      ),
                      SizedBox(height: 4 * scale),
                      Row(
                        children: [
                          Icon(Icons.place_outlined, size: 14 * scale, color: const Color(0xFF94A3B8)),
                          SizedBox(width: 4 * scale),
                          Expanded(
                            child: Text(
                              announcement.distanceLabel,
                              style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12.5 * scale),
                            ),
                          ),
                          SizedBox(width: 8 * scale),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 4 * scale),
                            decoration: BoxDecoration(
                              color: announcement.statusColor.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              announcement.statusLabel,
                              style: GoogleFonts.inter(
                                color: announcement.statusColor,
                                fontSize: 11.5 * scale,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 14 * scale),
            Text(
              announcement.message,
              style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 15 * scale, height: 1.5),
            ),
            if (announcement.coverImage != null) ...[
              SizedBox(height: 14 * scale),
              ClipRRect(
                borderRadius: BorderRadius.circular(14 * scale),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(announcement.coverImage!, fit: BoxFit.cover),
                ),
              ),
            ],
            if (announcement.tags.isNotEmpty) ...[
              SizedBox(height: 12 * scale),
              Wrap(
                spacing: 8 * scale,
                runSpacing: 4 * scale,
                children: announcement.tags
                    .map(
                      (tag) => _TagChip(
                        scale: scale,
                        label: tag,
                        color: announcement.status == SavedStatus.expired
                            ? const Color(0xFFF3F4F6)
                            : const Color(0xFFEFF6FF),
                        textColor: announcement.status == SavedStatus.expired
                            ? const Color(0xFF6B7280)
                            : const Color(0xFF176BFF),
                      ),
                    )
                    .toList(),
              ),
            ],
            SizedBox(height: 16 * scale),
            Row(
              children: [
                _StatIcon(
                  scale: scale,
                  icon: Icons.favorite_border_rounded,
                  label: announcement.likes.toString(),
                ),
                SizedBox(width: 12 * scale),
                _StatIcon(
                  scale: scale,
                  icon: Icons.mode_comment_outlined,
                  label: announcement.comments.toString(),
                ),
                SizedBox(width: 12 * scale),
                _StatIcon(
                  scale: scale,
                  icon: Icons.bookmark_rounded,
                  label: announcement.savedCount.toString(),
                  color: const Color(0xFF176BFF),
                ),
                SizedBox(width: 12 * scale),
                _StatIcon(
                  scale: scale,
                  icon: Icons.groups_rounded,
                  label: announcement.participants.toString(),
                ),
                const Spacer(),
                Text(
                  announcement.timeAgoLabel,
                  style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 11.5 * scale),
                ),
              ],
            ),
            SizedBox(height: 16 * scale),
            if (isExpired)
              Container(
                height: 48 * scale,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12 * scale),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Annonce expirée',
                  style: GoogleFonts.inter(color: const Color(0xFF6B7280), fontSize: 15 * scale, fontWeight: FontWeight.w600),
                ),
              )
            else
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onMessage,
                  icon: Icon(Icons.chat_bubble_outline_rounded, size: 18 * scale),
                  label: Text(
                    'Envoyer un message',
                    style: GoogleFonts.inter(fontSize: 15 * scale, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF176BFF),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 14 * scale),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scale)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _StatIcon extends StatelessWidget {
  const _StatIcon({required this.scale, required this.icon, required this.label, this.color});

  final double scale;
  final IconData icon;
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final iconColor = color ?? const Color(0xFF475569);
    return Row(
      children: [
        Icon(icon, size: 18 * scale, color: iconColor),
        SizedBox(width: 4 * scale),
        Text(
          label,
          style: GoogleFonts.inter(color: iconColor, fontSize: 13 * scale, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({required this.scale, required this.label, required this.color, required this.textColor});

  final double scale;
  final String label;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 5 * scale),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(color: textColor, fontSize: 12 * scale, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.scale, required this.onClearAll});

  final double scale;
  final VoidCallback onClearAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32 * scale),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120 * scale,
            height: 120 * scale,
            decoration: BoxDecoration(
              color: const Color(0xFFE0F2FE),
              borderRadius: BorderRadius.circular(30 * scale),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.bookmark_border_rounded, size: 48 * scale, color: const Color(0xFF0EA5E9)),
          ),
          SizedBox(height: 24 * scale),
          Text(
            'Aucune annonce enregistrée',
            style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8 * scale),
          Text(
            'Ajoutez une annonce à vos favoris pour la retrouver facilement ici.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale, height: 1.5),
          ),
          SizedBox(height: 24 * scale),
          OutlinedButton(
            onPressed: onClearAll,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFE2E8F0)),
              padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 12 * scale),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scale)),
            ),
            child: Text(
              'Explorer les annonces',
              style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 14 * scale, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({required this.scale, required this.icon, required this.onTap});

  final double scale;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40 * scale,
        height: 40 * scale,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10 * scale, offset: Offset(0, 6 * scale)),
          ],
        ),
        child: Icon(icon, color: const Color(0xFF0B1220), size: 18 * scale),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/post_detail_controller.dart';

class PostDetailUserView extends GetView<PostDetailController> {
  const PostDetailUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const designWidth = 375.0;
          final width = constraints.maxWidth.isFinite
              ? constraints.maxWidth
              : MediaQuery.of(context).size.width;
          final scale = (width / designWidth).clamp(0.9, 1.1);

          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: _HeroHeader(scale: scale)),
                  SliverToBoxAdapter(child: _ContentSheet(scale: scale)),
                  SliverToBoxAdapter(child: SizedBox(height: 200 * scale)),
                ],
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: _FloatingTopBar(scale: scale),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: _PersistentActions(scale: scale),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _HeroHeader extends GetView<PostDetailController> {
  const _HeroHeader({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final detail = controller.detail;
    return SizedBox(
      height: 380 * scale,
      child: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            controller: controller.mediaController,
            itemCount: detail.images.length,
            itemBuilder: (context, index) => Image.network(detail.images[index], fit: BoxFit.cover),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.0),
                  Colors.black.withValues(alpha: 0.1),
                  Colors.black.withValues(alpha: 0.45),
                ],
              ),
            ),
          ),
          Positioned(
            right: 16 * scale,
            top: 16 * scale,
            child: Obx(
              () => Container(
                padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.45),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  '${controller.currentImageIndex.value + 1}/${detail.images.length}',
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 12 * scale),
                ),
              ),
            ),
          ),
          Positioned(
            left: 16 * scale,
            right: 16 * scale,
            bottom: 24 * scale,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Text(detail.author.timeAgo, style: GoogleFonts.inter(color: Colors.white, fontSize: 12 * scale, fontWeight: FontWeight.w500)),
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14 * scale, vertical: 6 * scale),
                  decoration: BoxDecoration(
                    color: const Color(0xFF16A34A),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle_rounded, size: 14 * scale, color: Colors.white),
                      SizedBox(width: 6 * scale),
                      Text('Disponible', style: GoogleFonts.inter(color: Colors.white, fontSize: 12 * scale, fontWeight: FontWeight.w600)),
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

class _FloatingTopBar extends StatelessWidget {
  const _FloatingTopBar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 12 * scale),
        child: Row(
          children: [
            _TopIconButton(scale: scale, icon: Icons.arrow_back_ios_new_rounded, onTap: Get.back),
            const Spacer(),
            _TopIconButton(scale: scale, icon: Icons.bookmark_border_rounded, onTap: () => Get.snackbar('Favoris', 'Ajout bientôt disponible')),
            SizedBox(width: 12 * scale),
            _TopIconButton(scale: scale, icon: Icons.more_horiz_rounded, onTap: () => Get.snackbar('Options', 'Fonctionnalités à venir')),
          ],
        ),
      ),
    );
  }
}

class _TopIconButton extends StatelessWidget {
  const _TopIconButton({required this.scale, required this.icon, required this.onTap});

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
          color: Colors.white.withValues(alpha: 0.92),
          borderRadius: BorderRadius.circular(12 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        alignment: Alignment.center,
        child: Icon(icon, size: 18 * scale, color: const Color(0xFF0B1220)),
      ),
    );
  }
}

class _ContentSheet extends GetView<PostDetailController> {
  const _ContentSheet({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final detail = controller.detail;
    final host = controller.hostProfile;

    return Transform.translate(
      offset: Offset(0, -32 * scale),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16 * scale),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24 * scale),
            boxShadow: const [
              BoxShadow(color: Color(0x19176BFF), blurRadius: 32, offset: Offset(0, 16)),
            ],
          ),
          padding: EdgeInsets.fromLTRB(24 * scale, 24 * scale, 24 * scale, 32 * scale),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(detail.title, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 20 * scale, fontWeight: FontWeight.w700, height: 1.4)),
              SizedBox(height: 12 * scale),
              Text(host.location, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale, fontWeight: FontWeight.w500)),
              SizedBox(height: 20 * scale),
              _KpiRow(scale: scale),
              SizedBox(height: 20 * scale),
              _HostOverviewCard(scale: scale, host: host),
              SizedBox(height: 20 * scale),
              _SessionMetrics(scale: scale),
              SizedBox(height: 24 * scale),
              _DescriptionSection(scale: scale),
              SizedBox(height: 24 * scale),
              _EventOverview(scale: scale),
              SizedBox(height: 20 * scale),
              _VenueOverview(scale: scale),
              SizedBox(height: 20 * scale),
              _TagWrap(scale: scale),
              SizedBox(height: 20 * scale),
              _ParticipantsWrap(scale: scale),
            ],
          ),
        ),
      ),
    );
  }
}

class _KpiRow extends GetView<PostDetailController> {
  const _KpiRow({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final detail = controller.detail;
    return Wrap(
      spacing: 12 * scale,
      runSpacing: 12 * scale,
      children: [
        _MetricChip(scale: scale, icon: Icons.place_rounded, primary: controller.hostProfile.distanceLabel, secondary: detail.author.location.split('•').first.trim()),
        _MetricChip(scale: scale, icon: Icons.remove_red_eye_outlined, primary: '${detail.views}', secondary: 'vues'),
        _MetricChip(scale: scale, icon: Icons.favorite_border_rounded, primary: '${detail.likes}', secondary: 'likes'),
        _MetricChip(scale: scale, icon: Icons.share_rounded, primary: '${detail.shares}', secondary: 'partages'),
      ],
    );
  }
}

class _MetricChip extends StatelessWidget {
  const _MetricChip({required this.scale, required this.icon, required this.primary, required this.secondary});

  final double scale;
  final IconData icon;
  final String primary;
  final String secondary;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150 * scale,
      padding: EdgeInsets.symmetric(horizontal: 14 * scale, vertical: 12 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20 * scale, color: const Color(0xFF176BFF)),
          SizedBox(width: 10 * scale),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(primary, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
              Text(secondary, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
            ],
          ),
        ],
      ),
    );
  }
}

class _HostOverviewCard extends StatelessWidget {
  const _HostOverviewCard({required this.scale, required this.host});

  final double scale;
  final HostProfile host;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(radius: 24 * scale, backgroundImage: NetworkImage(host.avatarUrl)),
              SizedBox(width: 12 * scale),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(host.name, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
                    SizedBox(height: 4 * scale),
                    Text(host.ratingLabel, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 4 * scale),
                decoration: BoxDecoration(
                  color: const Color(0xFF176BFF).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(host.levelLabel, style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 12 * scale, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          SizedBox(height: 14 * scale),
          Row(
            children: [
              Wrap(
                spacing: 8 * scale,
                children: host.badges
                    .map(
                      (badge) => Container(
                        padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 4 * scale),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Text(badge, style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 12 * scale, fontWeight: FontWeight.w600)),
                      ),
                    )
                    .toList(),
              ),
              const Spacer(),
              Row(
                children: [
                  Container(
                    width: 8 * scale,
                    height: 8 * scale,
                    decoration: BoxDecoration(
                      color: host.isOnline ? const Color(0xFF16A34A) : const Color(0xFF94A3B8),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                  ),
                  SizedBox(width: 6 * scale),
                  Text(host.isOnline ? 'En ligne' : 'Hors ligne', style: GoogleFonts.inter(color: host.isOnline ? const Color(0xFF16A34A) : const Color(0xFF94A3B8), fontSize: 12 * scale)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SessionMetrics extends GetView<PostDetailController> {
  const _SessionMetrics({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final detail = controller.detail;
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _SessionMetricCell(scale: scale, value: '${detail.likes}', label: 'Intéressés'),
          _SessionMetricCell(scale: scale, value: '${detail.commentsCount}', label: 'Commentaires'),
          _SessionMetricCell(scale: scale, value: '${detail.shares}', label: 'Partages'),
          _SessionMetricCell(scale: scale, value: '${detail.views}', label: 'Vues'),
        ],
      ),
    );
  }
}

class _SessionMetricCell extends StatelessWidget {
  const _SessionMetricCell({required this.scale, required this.value, required this.label});

  final double scale;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w700)),
        SizedBox(height: 4 * scale),
        Text(label, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
      ],
    );
  }
}

class _DescriptionSection extends GetView<PostDetailController> {
  const _DescriptionSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
        SizedBox(height: 12 * scale),
        for (final paragraph in controller.detail.description)
          Padding(
            padding: EdgeInsets.only(bottom: 12 * scale),
            child: Text(paragraph, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 15 * scale, height: 1.55)),
          ),
      ],
    );
  }
}

class _EventOverview extends GetView<PostDetailController> {
  const _EventOverview({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final info = controller.eventInfo;
    return Container(
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        color: const Color(0x0C176BFF),
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.event_available_rounded, size: 18 * scale, color: const Color(0xFF176BFF)),
              SizedBox(width: 8 * scale),
              Text("Détails de l'événement", style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
            ],
          ),
          SizedBox(height: 16 * scale),
          Wrap(
            spacing: 12 * scale,
            runSpacing: 12 * scale,
            children: [
              _EventItem(scale: scale, title: 'Date', value: info.date),
              _EventItem(scale: scale, title: 'Heure', value: info.timeRange),
              _EventItem(scale: scale, title: 'Participants', value: info.participants),
              _EventItem(scale: scale, title: 'Prix', value: info.price),
            ],
          ),
        ],
      ),
    );
  }
}

class _EventItem extends StatelessWidget {
  const _EventItem({required this.scale, required this.title, required this.value});

  final double scale;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 148 * scale,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
          SizedBox(height: 6 * scale),
          Text(value, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _VenueOverview extends GetView<PostDetailController> {
  const _VenueOverview({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final venue = controller.venueInfo;
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
          Row(
            children: [
              Icon(Icons.location_on_rounded, size: 20 * scale, color: const Color(0xFF176BFF)),
              SizedBox(width: 8 * scale),
              Expanded(
                child: Text(venue.name, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 4 * scale),
                decoration: BoxDecoration(
                  color: const Color(0xFF16A34A).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text('Disponible', style: GoogleFonts.inter(color: const Color(0xFF16A34A), fontSize: 12 * scale, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          SizedBox(height: 12 * scale),
          Text(venue.address, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale)),
          SizedBox(height: 12 * scale),
          Wrap(
            spacing: 12 * scale,
            runSpacing: 12 * scale,
            children: [
              _VenueChip(scale: scale, icon: Icons.star_rate_rounded, label: venue.distanceLabel),
              for (final amenity in venue.amenities) _VenueChip(scale: scale, icon: Icons.check_circle_outline_rounded, label: amenity),
            ],
          ),
        ],
      ),
    );
  }
}

class _VenueChip extends StatelessWidget {
  const _VenueChip({required this.scale, required this.icon, required this.label});

  final double scale;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14 * scale, color: const Color(0xFF176BFF)),
          SizedBox(width: 6 * scale),
          Text(label, style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 12 * scale, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _TagWrap extends GetView<PostDetailController> {
  const _TagWrap({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tags', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
        SizedBox(height: 12 * scale),
        Wrap(
          spacing: 12 * scale,
          runSpacing: 12 * scale,
          children: controller.tags
              .map(
                (tag) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 10 * scale),
                  decoration: BoxDecoration(color: tag.background, borderRadius: BorderRadius.circular(9999)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (tag.icon != null) ...[
                        Icon(tag.icon, size: 16 * scale, color: tag.foreground),
                        SizedBox(width: 6 * scale),
                      ],
                      Text(tag.label, style: GoogleFonts.inter(color: tag.foreground, fontSize: 14 * scale, fontWeight: FontWeight.w600)),
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

class _ParticipantsWrap extends GetView<PostDetailController> {
  const _ParticipantsWrap({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final detail = controller.detail;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Participants confirmés (${detail.participants.length})', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
        SizedBox(height: 12 * scale),
        SizedBox(
          height: 44 * scale,
          child: Stack(
            children: [
              for (final entry in detail.participants.asMap().entries)
                Positioned(
                  left: entry.key * 24 * scale,
                  child: CircleAvatar(radius: 22 * scale, backgroundImage: NetworkImage(entry.value), backgroundColor: Colors.white),
                ),
              Positioned(
                left: detail.participants.length * 24 * scale,
                child: CircleAvatar(
                  radius: 22 * scale,
                  backgroundColor: const Color(0xFF176BFF),
                  child: Text('+4', style: GoogleFonts.inter(color: Colors.white, fontSize: 12 * scale, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12 * scale),
        Text(detail.participantsSummary, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale, height: 1.4)),
      ],
    );
  }
}

class _PersistentActions extends GetView<PostDetailController> {
  const _PersistentActions({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final paddingBottom = MediaQuery.of(context).padding.bottom;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      padding: EdgeInsets.fromLTRB(16 * scale, 16 * scale, 16 * scale, 16 * scale + paddingBottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => Get.snackbar('Message', 'Ouverture de la messagerie prochainement'),
              icon: Icon(Icons.chat_bubble_outline_rounded, size: 18 * scale, color: Colors.white),
              label: Text('Envoyer un message', style: GoogleFonts.inter(color: Colors.white, fontSize: 16 * scale, fontWeight: FontWeight.w600)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF176BFF),
                padding: EdgeInsets.symmetric(vertical: 16 * scale),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16 * scale)),
              ),
            ),
          ),
          SizedBox(height: 16 * scale),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: controller.quickActions
                .map(
                  (action) => _QuickActionIcon(scale: scale, data: action),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _QuickActionIcon extends StatelessWidget {
  const _QuickActionIcon({required this.scale, required this.data});

  final double scale;
  final QuickActionData data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.snackbar(data.label, 'Fonctionnalité en préparation'),
      child: Column(
        children: [
          Container(
            width: 52 * scale,
            height: 52 * scale,
            decoration: BoxDecoration(
              color: data.background.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16 * scale),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Icon(data.icon, color: data.background, size: 24 * scale),
          ),
          SizedBox(height: 8 * scale),
          Text(data.label, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
        ],
      ),
    );
  }
}

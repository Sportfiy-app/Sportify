import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_routes.dart';
import '../controllers/post_detail_controller.dart';

class PostDetailSearchView extends GetView<PostDetailController> {
  const PostDetailSearchView({super.key});

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
                  SliverToBoxAdapter(child: _HeroSection(scale: scale)),
                  SliverToBoxAdapter(child: _SummaryCard(scale: scale)),
                  SliverToBoxAdapter(child: _CommentsPreview(scale: scale)),
                  SliverToBoxAdapter(child: _SimilarPosts(scale: scale)),
                  SliverToBoxAdapter(child: _SafetySection(scale: scale)),
                  SliverPadding(padding: EdgeInsets.only(bottom: 160 * scale)),
                ],
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: _TopBar(scale: scale),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _BottomActions(scale: scale),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 12 * scale),
        child: Row(
          children: [
            _ChipButton(
              scale: scale,
              icon: Icons.arrow_back_ios_new_rounded,
              onTap: Get.back,
            ),
            const Spacer(),
            _ChipButton(
              scale: scale,
              icon: Icons.favorite_border_rounded,
              onTap: () => Get.snackbar('Favoris', 'À venir'),
            ),
            SizedBox(width: 12 * scale),
            _ChipButton(
              scale: scale,
              icon: Icons.more_horiz_rounded,
              onTap: () => Get.snackbar('Options', 'Fonctionnalités à venir'),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroSection extends GetView<PostDetailController> {
  const _HeroSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final detail = controller.detail;
    return SizedBox(
      height: 360 * scale,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(detail.images.first, fit: BoxFit.cover),
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
                  child: Text(
                    detail.author.timeAgo,
                    style: GoogleFonts.inter(color: Colors.white, fontSize: 12 * scale, fontWeight: FontWeight.w500),
                  ),
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

class _SummaryCard extends GetView<PostDetailController> {
  const _SummaryCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final detail = controller.detail;
    final host = controller.hostProfile;
    return Container(
      transform: Matrix4.translationValues(0, -36 * scale, 0),
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24 * scale),
          boxShadow: const [
            BoxShadow(color: Color(0x19176BFF), blurRadius: 32, offset: Offset(0, 12)),
          ],
        ),
        padding: EdgeInsets.fromLTRB(24 * scale, 24 * scale, 24 * scale, 32 * scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(detail.title, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 20 * scale, fontWeight: FontWeight.w700, height: 1.4)),
            SizedBox(height: 8 * scale),
            Text(host.location, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale, fontWeight: FontWeight.w500)),
            SizedBox(height: 16 * scale),
            _DistanceStatsRow(scale: scale),
            SizedBox(height: 20 * scale),
            _HostCard(scale: scale, host: host),
            SizedBox(height: 20 * scale),
            _StatsBar(scale: scale),
            SizedBox(height: 20 * scale),
            _DescriptionBlock(scale: scale),
            SizedBox(height: 24 * scale),
            _EventDetailsCard(scale: scale),
            SizedBox(height: 20 * scale),
            _VenueCard(scale: scale),
            SizedBox(height: 20 * scale),
            _TagsSection(scale: scale),
            SizedBox(height: 20 * scale),
            _ParticipantsSection(scale: scale),
          ],
        ),
      ),
    );
  }
}

class _DistanceStatsRow extends GetView<PostDetailController> {
  const _DistanceStatsRow({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final detail = controller.detail;
    return Wrap(
      spacing: 12 * scale,
      runSpacing: 12 * scale,
      children: [
        _InfoPill(scale: scale, icon: Icons.place_rounded, title: controller.hostProfile.distanceLabel, subtitle: detail.author.location.split('•').first.trim()),
        _InfoPill(scale: scale, icon: Icons.remove_red_eye_outlined, title: '${detail.views}', subtitle: 'vues'),
        _InfoPill(scale: scale, icon: Icons.favorite_border_rounded, title: '${detail.likes}', subtitle: 'likes'),
        _InfoPill(scale: scale, icon: Icons.share_rounded, title: '${detail.shares}', subtitle: 'partages'),
      ],
    );
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.scale, required this.icon, required this.title, required this.subtitle});

  final double scale;
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140 * scale,
      padding: EdgeInsets.symmetric(horizontal: 14 * scale, vertical: 12 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20 * scale, color: const Color(0xFF176BFF)),
          SizedBox(width: 8 * scale),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
              Text(subtitle, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
            ],
          ),
        ],
      ),
    );
  }
}

class _HostCard extends StatelessWidget {
  const _HostCard({required this.scale, required this.host});

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
                    Row(
                      children: [
                        Icon(Icons.star_rounded, size: 16 * scale, color: const Color(0xFFFFB800)),
                        SizedBox(width: 6 * scale),
                        Text(host.ratingLabel, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 4 * scale),
                    decoration: BoxDecoration(
                      color: const Color(0xFF176BFF).withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Text(host.levelLabel, style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 12 * scale, fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(height: 8 * scale),
                  if (host.verified)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.verified_rounded, size: 16 * scale, color: const Color(0xFF16A34A)),
                        SizedBox(width: 4 * scale),
                        Text('Utilisateur vérifié', style: GoogleFonts.inter(color: const Color(0xFF16A34A), fontSize: 12 * scale)),
                      ],
                    ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16 * scale),
          Row(
            children: [
              Wrap(
                spacing: 8 * scale,
                children: host.badges
                    .map(
                      (badge) => Container(
                        padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 4 * scale),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0F2FE),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Text(badge, style: GoogleFonts.inter(color: const Color(0xFF0EA5E9), fontSize: 12 * scale, fontWeight: FontWeight.w600)),
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

class _StatsBar extends GetView<PostDetailController> {
  const _StatsBar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final detail = controller.detail;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _StatTile(scale: scale, icon: Icons.favorite_border_rounded, value: '${detail.likes}', label: 'Likes'),
        _StatTile(scale: scale, icon: Icons.chat_bubble_outline_rounded, value: '${detail.commentsCount}', label: 'Commentaires'),
        _StatTile(scale: scale, icon: Icons.share_rounded, value: '${detail.shares}', label: 'Partages'),
        _StatTile(scale: scale, icon: Icons.remove_red_eye_outlined, value: '${detail.views}', label: 'Vues'),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.scale, required this.icon, required this.value, required this.label});

  final double scale;
  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 20 * scale, color: const Color(0xFF176BFF)),
        SizedBox(height: 6 * scale),
        Text(value, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
        Text(label, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 11 * scale)),
      ],
    );
  }
}

class _DescriptionBlock extends GetView<PostDetailController> {
  const _DescriptionBlock({required this.scale});

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

class _EventDetailsCard extends GetView<PostDetailController> {
  const _EventDetailsCard({required this.scale});

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
              _EventDetailTile(scale: scale, title: 'Date', value: info.date),
              _EventDetailTile(scale: scale, title: 'Heure', value: info.timeRange),
              _EventDetailTile(scale: scale, title: 'Participants', value: info.participants),
              _EventDetailTile(scale: scale, title: 'Prix', value: info.price),
            ],
          ),
        ],
      ),
    );
  }
}

class _EventDetailTile extends StatelessWidget {
  const _EventDetailTile({required this.scale, required this.title, required this.value});

  final double scale;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140 * scale,
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

class _VenueCard extends GetView<PostDetailController> {
  const _VenueCard({required this.scale});

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
                padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 4 * scale),
                decoration: BoxDecoration(
                  color: const Color(0xFF16A34A).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Row(
                  children: [
                    Icon(Icons.av_timer_rounded, size: 14 * scale, color: const Color(0xFF16A34A)),
                    SizedBox(width: 4 * scale),
                    Text(venue.availabilityLabel, style: GoogleFonts.inter(color: const Color(0xFF16A34A), fontSize: 12 * scale, fontWeight: FontWeight.w600)),
                  ],
                ),
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
              _VenueBadge(scale: scale, icon: Icons.star_rate_rounded, label: venue.distanceLabel),
              for (final amenity in venue.amenities)
                _VenueBadge(scale: scale, icon: Icons.check_circle_outline_rounded, label: amenity),
            ],
          ),
        ],
      ),
    );
  }
}

class _VenueBadge extends StatelessWidget {
  const _VenueBadge({required this.scale, required this.icon, required this.label});

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

class _TagsSection extends GetView<PostDetailController> {
  const _TagsSection({required this.scale});

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
                  decoration: BoxDecoration(
                    color: tag.background,
                    borderRadius: BorderRadius.circular(9999),
                  ),
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

class _ParticipantsSection extends GetView<PostDetailController> {
  const _ParticipantsSection({required this.scale});

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
          height: 40 * scale,
          child: Stack(
            children: [
              for (final entry in detail.participants.asMap().entries)
                Positioned(
                  left: entry.key * 24 * scale,
                  child: CircleAvatar(radius: 20 * scale, backgroundImage: NetworkImage(entry.value), backgroundColor: Colors.white),
                ),
              Positioned(
                left: detail.participants.length * 24 * scale,
                child: CircleAvatar(
                  radius: 20 * scale,
                  backgroundColor: const Color(0xFF176BFF),
                  child: Text('+4', style: GoogleFonts.inter(color: Colors.white, fontSize: 12 * scale, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12 * scale),
        Text(controller.detail.participantsSummary, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale, height: 1.4)),
      ],
    );
  }
}

class _CommentsPreview extends GetView<PostDetailController> {
  const _CommentsPreview({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16 * scale, 0, 16 * scale, 24 * scale),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        padding: EdgeInsets.fromLTRB(24 * scale, 24 * scale, 24 * scale, 24 * scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Commentaires (${controller.detail.commentsCount})', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
                TextButton(
                  onPressed: () => Get.toNamed(Routes.postComments, arguments: controller.detail),
                  style: TextButton.styleFrom(padding: EdgeInsets.zero, foregroundColor: const Color(0xFF176BFF)),
                  child: Text('Voir tous', style: GoogleFonts.inter(fontSize: 14 * scale, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            SizedBox(height: 20 * scale),
            Wrap(
              runSpacing: 16 * scale,
              children: controller.commentHighlights
                  .map(
                    (highlight) => _CommentHighlightCard(scale: scale, data: highlight),
                  )
                  .toList(),
            ),
            SizedBox(height: 20 * scale),
            _CommentComposerPreview(scale: scale),
          ],
        ),
      ),
    );
  }
}

class _CommentHighlightCard extends StatelessWidget {
  const _CommentHighlightCard({required this.scale, required this.data});

  final double scale;
  final CommentHighlight data;

  @override
  Widget build(BuildContext context) {
    final comment = data.comment;
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFF8FAFC), Color(0xFFF1F5F9)]),
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 2 * scale),
      ),
      padding: EdgeInsets.all(16 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 16 * scale, backgroundImage: NetworkImage(comment.avatarUrl)),
              SizedBox(width: 12 * scale),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(comment.author, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
                    Text(comment.timeAgo, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12 * scale),
          Text(comment.messageLines.join(' '), style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale, height: 1.45)),
          SizedBox(height: 12 * scale),
          Row(
            children: [
              Icon(Icons.favorite_border_rounded, size: 16 * scale, color: const Color(0xFF475569)),
              SizedBox(width: 4 * scale),
              Text('${data.likes}', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
              SizedBox(width: 16 * scale),
              Icon(Icons.forum_outlined, size: 16 * scale, color: const Color(0xFF475569)),
              SizedBox(width: 4 * scale),
              Text('${data.replies} réponses', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
            ],
          ),
        ],
      ),
    );
  }
}

class _CommentComposerPreview extends GetView<PostDetailController> {
  const _CommentComposerPreview({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 16 * scale, backgroundImage: const NetworkImage('https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=100&q=60')),
        SizedBox(width: 12 * scale),
        Expanded(
          child: Container(
            height: 40 * scale,
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(9999),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16 * scale),
            alignment: Alignment.centerLeft,
            child: Text('Ajouter un commentaire...', style: GoogleFonts.inter(color: const Color(0xFFADAEBC), fontSize: 14 * scale)),
          ),
        ),
        SizedBox(width: 12 * scale),
        Icon(Icons.send_rounded, color: const Color(0xFF176BFF), size: 20 * scale),
      ],
    );
  }
}

class _SimilarPosts extends GetView<PostDetailController> {
  const _SimilarPosts({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16 * scale, 0, 16 * scale, 24 * scale),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        padding: EdgeInsets.all(24 * scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Autres posts similaires', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
            SizedBox(height: 18 * scale),
            Column(
              children: controller.similarSessions
                  .map((session) => _SimilarPostTile(scale: scale, session: session))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SimilarPostTile extends GetView<PostDetailController> {
  const _SimilarPostTile({required this.scale, required this.session});

  final double scale;
  final SimilarSession session;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.openSimilarSession(session),
      child: Container(
        margin: EdgeInsets.only(bottom: 16 * scale),
        padding: EdgeInsets.all(12 * scale),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12 * scale),
              child: Image.network(session.imageUrl, width: 56 * scale, height: 56 * scale, fit: BoxFit.cover),
            ),
            SizedBox(width: 12 * scale),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(session.title, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
                  SizedBox(height: 4 * scale),
                  Text(session.venue, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
                  SizedBox(height: 4 * scale),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 4 * scale),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Text(session.label, style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 12 * scale)),
                      ),
                      SizedBox(width: 8 * scale),
                      Text(session.spots, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(session.time, style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 12 * scale, fontWeight: FontWeight.w600)),
                SizedBox(height: 8 * scale),
                Icon(Icons.chevron_right_rounded, size: 20 * scale, color: const Color(0xFF94A3B8)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SafetySection extends StatelessWidget {
  const _SafetySection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16 * scale, 0, 16 * scale, 160 * scale),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(24 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        padding: EdgeInsets.all(24 * scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.shield_outlined, size: 20 * scale, color: const Color(0xFF176BFF)),
                SizedBox(width: 8 * scale),
                Text('Sécurité et signalement', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
              ],
            ),
            SizedBox(height: 12 * scale),
            Text('Signalez tout contenu inapproprié ou comportement suspect afin de protéger la communauté.', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale)),
            SizedBox(height: 16 * scale),
            OutlinedButton.icon(
              onPressed: () => Get.snackbar('Signalement', 'Merci pour votre retour.'),
              icon: Icon(Icons.flag_outlined, size: 18 * scale),
              label: Text('Signaler cette annonce', style: GoogleFonts.inter(fontSize: 14 * scale, fontWeight: FontWeight.w600)),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF0B1220),
                side: const BorderSide(color: Color(0xFFE2E8F0)),
                padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 14 * scale),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scale)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomActions extends GetView<PostDetailController> {
  const _BottomActions({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      padding: EdgeInsets.fromLTRB(16 * scale, 16 * scale, 16 * scale, 16 * scale + MediaQuery.of(context).padding.bottom),
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
                  (action) => _QuickActionChip(scale: scale, action: action),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _QuickActionChip extends StatelessWidget {
  const _QuickActionChip({required this.scale, required this.action});

  final double scale;
  final QuickActionData action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.snackbar(action.label, 'Fonctionnalité en préparation'),
      child: Column(
        children: [
          Container(
            width: 52 * scale,
            height: 52 * scale,
            decoration: BoxDecoration(
              color: action.background.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16 * scale),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Icon(action.icon, color: action.background, size: 24 * scale),
          ),
          SizedBox(height: 8 * scale),
          Text(action.label, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
        ],
      ),
    );
  }
}

class _ChipButton extends StatelessWidget {
  const _ChipButton({required this.scale, required this.icon, required this.onTap});

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
          color: Colors.white.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(12 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        alignment: Alignment.center,
        child: Icon(icon, size: 18 * scale, color: const Color(0xFF0B1220)),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_routes.dart';
import '../controllers/post_detail_controller.dart';

class PostDetailView extends GetView<PostDetailController> {
  const PostDetailView({super.key});

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
          final scale = (width / designWidth).clamp(0.9, 1.15);

          return SafeArea(
            child: Column(
              children: [
                _HeaderBar(scale: scale),
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: CustomScrollView(
                          slivers: [
                            SliverToBoxAdapter(child: _MediaCarousel(scale: scale)),
                            SliverToBoxAdapter(
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x110B1220),
                                      blurRadius: 24,
                                      offset: Offset(0, -8),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(16 * scale, 24 * scale, 16 * scale, 120 * scale),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _AuthorSection(scale: scale),
                                      SizedBox(height: 16 * scale),
                                      _TitleSection(scale: scale),
                                      SizedBox(height: 12 * scale),
                                      _StatRow(scale: scale),
                                      SizedBox(height: 18 * scale),
                                      _DescriptionSection(scale: scale),
                                      SizedBox(height: 24 * scale),
                                      _SessionDetailCard(scale: scale),
                                      SizedBox(height: 24 * scale),
                                      _InterestedPlayersSection(scale: scale),
                                      SizedBox(height: 24 * scale),
                                      _CommentsSection(scale: scale),
                                      SizedBox(height: 24 * scale),
                                      _DecisionButtons(scale: scale),
                                      SizedBox(height: 24 * scale),
                                      _SimilarSessionsSection(scale: scale),
                                      SizedBox(height: 24 * scale),
                                      _ReportSection(scale: scale),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: _CommentComposer(scale: scale),
                      ),
                      Positioned(
                        top: 200 * scale,
                        right: 24 * scale,
                        child: const _FloatingActionButton(),
                      ),
                    ],
                  ),
                ),
                _BottomNavigation(scale: scale),
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 12 * scale),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: [
          _HeaderIconButton(
            scale: scale,
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: Get.back,
          ),
          const Spacer(),
          _HeaderIconButton(
            scale: scale,
            icon: Icons.share_outlined,
            onTap: () => Get.snackbar('Partager', 'Partage disponible bientôt.'),
          ),
          SizedBox(width: 12 * scale),
          _HeaderIconButton(
            scale: scale,
            icon: Icons.more_horiz_rounded,
            onTap: () => Get.snackbar('Options', 'Options supplémentaires à venir.'),
          ),
        ],
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({required this.scale, required this.icon, required this.onTap});

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
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(12 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        alignment: Alignment.center,
        child: Icon(icon, size: 18 * scale, color: const Color(0xFF0B1220)),
      ),
    );
  }
}

class _MediaCarousel extends GetView<PostDetailController> {
  const _MediaCarousel({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320 * scale,
      child: Stack(
        children: [
          Positioned.fill(
            child: PageView.builder(
              controller: controller.mediaController,
              itemCount: controller.detail.images.length,
              itemBuilder: (context, index) {
                final url = controller.detail.images[index];
                return ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24 * scale),
                    bottomRight: Radius.circular(24 * scale),
                  ),
                  child: Image.network(url, fit: BoxFit.cover),
                );
              },
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
                  '${controller.currentImageIndex.value + 1}/${controller.detail.images.length}',
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 12 * scale),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20 * scale,
            left: 0,
            right: 0,
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(controller.detail.images.length, (index) {
                  final selected = controller.currentImageIndex.value == index;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: EdgeInsets.symmetric(horizontal: 4 * scale),
                    width: selected ? 24 * scale : 8 * scale,
                    height: 8 * scale,
                    decoration: BoxDecoration(
                      color: selected ? Colors.white : Colors.white.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AuthorSection extends GetView<PostDetailController> {
  const _AuthorSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final author = controller.detail.author;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 26 * scale,
          backgroundImage: NetworkImage(author.avatarUrl),
        ),
        SizedBox(width: 12 * scale),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                author.name,
                style: GoogleFonts.poppins(
                  color: const Color(0xFF0B1220),
                  fontSize: 16 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4 * scale),
              Row(
                children: [
                  Icon(Icons.place_outlined, size: 14 * scale, color: const Color(0xFF475569)),
                  SizedBox(width: 4 * scale),
                  Expanded(
                    child: Text(
                      author.location,
                      style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(author.timeAgo, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
            if (author.isUrgent) ...[
              SizedBox(height: 6 * scale),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 4 * scale),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3D6),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text('Urgent', style: GoogleFonts.inter(color: const Color(0xFFFFB800), fontSize: 12 * scale, fontWeight: FontWeight.w600)),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _TitleSection extends GetView<PostDetailController> {
  const _TitleSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          controller.detail.title,
          style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 22 * scale, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 12 * scale),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14 * scale, vertical: 6 * scale),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3D6),
            borderRadius: BorderRadius.circular(9999),
            border: Border.all(color: const Color(0xFFFFE4A6)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.sports_soccer_rounded, size: 16 * scale, color: const Color(0xFFFFB800)),
              SizedBox(width: 6 * scale),
              Text(controller.detail.sportTag, style: GoogleFonts.inter(color: const Color(0xFFFFB800), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatRow extends GetView<PostDetailController> {
  const _StatRow({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final detail = controller.detail;
    return Row(
      children: [
        _StatChip(scale: scale, icon: Icons.favorite_border_rounded, value: detail.likes.toString()),
        SizedBox(width: 8 * scale),
        _StatChip(scale: scale, icon: Icons.mode_comment_outlined, value: detail.commentsCount.toString()),
        SizedBox(width: 8 * scale),
        _StatChip(scale: scale, icon: Icons.share_outlined, value: detail.shares.toString()),
        const Spacer(),
        Icon(Icons.remove_red_eye_outlined, size: 16 * scale, color: const Color(0xFF475569)),
        SizedBox(width: 6 * scale),
        Text('${detail.views} vues', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.scale, required this.icon, required this.value});

  final double scale;
  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16 * scale, color: const Color(0xFF475569)),
          SizedBox(width: 6 * scale),
          Text(value, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale, fontWeight: FontWeight.w600)),
        ],
      ),
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
        for (final paragraph in controller.detail.description)
          Padding(
            padding: EdgeInsets.only(bottom: 12 * scale),
            child: Text(
              paragraph,
              style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 15 * scale, height: 1.55),
            ),
          ),
      ],
    );
  }
}

class _SessionDetailCard extends GetView<PostDetailController> {
  const _SessionDetailCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final session = controller.detail.session;
    return Container(
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Détails de la session', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
          SizedBox(height: 18 * scale),
          _SessionRow(scale: scale, icon: Icons.calendar_today_rounded, title: session.dateLabel, subtitle: session.duration, color: const Color(0xFF0EA5E9)),
          SizedBox(height: 16 * scale),
          _SessionRow(scale: scale, icon: Icons.place_outlined, title: session.location, subtitle: session.address, color: const Color(0xFF16A34A)),
          SizedBox(height: 16 * scale),
          _SessionRow(scale: scale, icon: Icons.people_alt_outlined, title: session.attendeesLabel, subtitle: session.levelInfo, color: const Color(0xFFFFB800)),
        ],
      ),
    );
  }
}

class _SessionRow extends StatelessWidget {
  const _SessionRow({required this.scale, required this.icon, required this.title, required this.subtitle, required this.color});

  final double scale;
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36 * scale,
          height: 36 * scale,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12 * scale),
          ),
          child: Icon(icon, color: color, size: 18 * scale),
        ),
        SizedBox(width: 12 * scale),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w500)),
              SizedBox(height: 4 * scale),
              Text(subtitle, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
            ],
          ),
        ),
      ],
    );
  }
}

class _InterestedPlayersSection extends GetView<PostDetailController> {
  const _InterestedPlayersSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Joueurs intéressés (${controller.detail.participants.length})', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
        SizedBox(height: 12 * scale),
        Row(
          children: [
            SizedBox(
              height: 40 * scale,
              child: Stack(
                children: [
                  ...controller.detail.participants.asMap().entries.map(
                        (entry) => Positioned(
                          left: entry.key * 20 * scale,
                          child: _ParticipantAvatar(scale: scale, url: entry.value),
                        ),
                      ),
                  Positioned(
                    left: controller.detail.participants.length * 20 * scale,
                    child: Container(
                      width: 36 * scale,
                      height: 36 * scale,
                      decoration: BoxDecoration(
                        color: const Color(0xFF176BFF),
                        borderRadius: BorderRadius.circular(9999),
                        border: Border.all(color: Colors.white, width: 3 * scale),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '+${controller.detail.participants.length - 4}',
                        style: GoogleFonts.inter(color: Colors.white, fontSize: 12 * scale, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: (controller.detail.participants.length + 1) * 20 * scale + 8 * scale),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(controller.detail.participantsSummary, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w500)),
                  SizedBox(height: 4 * scale),
                  Text(controller.detail.participantsFootnote, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ParticipantAvatar extends StatelessWidget {
  const _ParticipantAvatar({required this.scale, required this.url});

  final double scale;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36 * scale,
      height: 36 * scale,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9999),
        border: Border.all(color: Colors.white, width: 3 * scale),
        gradient: const LinearGradient(colors: [Color(0xFF16A34A), Color(0xFF0EA5E9)]),
      ),
      child: Padding(
        padding: EdgeInsets.all(2 * scale),
        child: ClipOval(child: Image.network(url, fit: BoxFit.cover)),
      ),
    );
  }
}

class _CommentsSection extends GetView<PostDetailController> {
  const _CommentsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Commentaires (${controller.detail.commentsCount})', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
            TextButton(
              onPressed: () => Get.toNamed(Routes.postComments, arguments: controller.detail),
              style: TextButton.styleFrom(padding: EdgeInsets.zero, foregroundColor: const Color(0xFF176BFF)),
              child: Text('Voir tous', style: GoogleFonts.inter(fontSize: 14 * scale, fontWeight: FontWeight.w500)),
            ),
          ],
        ),
        Obx(
          () => Column(
            children: [
              for (final comment in controller.comments)
                Padding(
                  padding: EdgeInsets.only(top: 12 * scale),
                  child: _CommentTile(
                    scale: scale,
                    comment: comment,
                    onLike: () => controller.toggleLike(comment),
                    onReply: () => controller.reply(comment),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CommentTile extends StatelessWidget {
  const _CommentTile({required this.scale, required this.comment, required this.onLike, required this.onReply});

  final double scale;
  final Comment comment;
  final VoidCallback onLike;
  final VoidCallback onReply;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(radius: 16 * scale, backgroundImage: NetworkImage(comment.avatarUrl)),
        SizedBox(width: 12 * scale),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 12 * scale),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(16 * scale),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(comment.author, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
                    SizedBox(height: 6 * scale),
                    for (final line in comment.messageLines)
                      Text(line, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale)),
                  ],
                ),
              ),
              SizedBox(height: 6 * scale),
              Row(
                children: [
                  GestureDetector(onTap: onReply, child: Text('Répondre', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale))),
                  SizedBox(width: 16 * scale),
                  GestureDetector(onTap: onLike, child: Text("J'aime", style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale))),
                  SizedBox(width: 16 * scale),
                  Text(comment.timeAgo, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DecisionButtons extends GetView<PostDetailController> {
  const _DecisionButtons({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Obx(
            () => ElevatedButton(
              onPressed: controller.join,
              style: ElevatedButton.styleFrom(
                backgroundColor: controller.participationStatus.value == ParticipationStatus.going ? const Color(0xFF0B1220) : const Color(0xFF176BFF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scale)),
                padding: EdgeInsets.symmetric(vertical: 14 * scale),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_rounded, size: 18 * scale),
                  SizedBox(width: 8 * scale),
                  Text('Je participe', style: GoogleFonts.inter(fontSize: 15 * scale, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 12 * scale),
        Expanded(
          child: Obx(
            () => OutlinedButton(
              onPressed: controller.maybe,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF0B1220),
                side: BorderSide(color: controller.participationStatus.value == ParticipationStatus.maybe ? const Color(0xFF0B1220) : const Color(0xFFE2E8F0)),
                backgroundColor: controller.participationStatus.value == ParticipationStatus.maybe ? const Color(0xFFE2E8F0) : const Color(0xFFF3F4F6),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scale)),
                padding: EdgeInsets.symmetric(vertical: 14 * scale),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.help_outline_rounded, size: 18 * scale),
                  SizedBox(width: 8 * scale),
                  Text('Peut-être', style: GoogleFonts.inter(fontSize: 15 * scale, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SimilarSessionsSection extends GetView<PostDetailController> {
  const _SimilarSessionsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Autres sessions similaires', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
            TextButton(onPressed: () {}, style: TextButton.styleFrom(padding: EdgeInsets.zero, foregroundColor: const Color(0xFF176BFF)), child: Text('Voir plus', style: GoogleFonts.inter(fontSize: 14 * scale))),
          ],
        ),
        SizedBox(height: 12 * scale),
        Column(
          children: [
            for (final session in controller.similarSessions)
              Padding(
                padding: EdgeInsets.only(bottom: 12 * scale),
                child: GestureDetector(
                  onTap: () => controller.openSimilarSession(session),
                  child: Container(
                    padding: EdgeInsets.all(16 * scale),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16 * scale),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12 * scale),
                          child: Image.network(session.imageUrl, width: 48 * scale, height: 48 * scale, fit: BoxFit.cover),
                        ),
                        SizedBox(width: 12 * scale),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(session.title, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600)),
                              SizedBox(height: 4 * scale),
                              Text(session.venue, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
                              SizedBox(height: 6 * scale),
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
                            Text(session.time, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
                            SizedBox(height: 8 * scale),
                            Container(
                              width: 52 * scale,
                              height: 24 * scale,
                              decoration: BoxDecoration(
                                color: const Color(0xFF176BFF),
                                borderRadius: BorderRadius.circular(9999),
                              ),
                              alignment: Alignment.center,
                              child: Text('Voir', style: GoogleFonts.inter(color: Colors.white, fontSize: 12 * scale, fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _ReportSection extends GetView<PostDetailController> {
  const _ReportSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: controller.reportPost,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.flag_outlined, size: 16 * scale, color: const Color(0xFF475569)),
            SizedBox(width: 8 * scale),
            Text('Signaler cette publication', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
          ],
        ),
      ),
    );
  }
}

class _CommentComposer extends GetView<PostDetailController> {
  const _CommentComposer({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 12 * scale),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20 * scale,
            backgroundImage: const NetworkImage('https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=200&q=60'),
          ),
          SizedBox(width: 12 * scale),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16 * scale),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(9999),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: TextField(
                controller: controller.commentController,
                decoration: InputDecoration(
                  hintText: 'Écrire un commentaire...',
                  hintStyle: GoogleFonts.inter(color: const Color(0xFFADAEBC), fontSize: 14 * scale),
                  border: InputBorder.none,
                  isCollapsed: true,
                ),
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => controller.submitComment(),
              ),
            ),
          ),
          SizedBox(width: 12 * scale),
          GestureDetector(
            onTap: controller.submitComment,
            child: Container(
              width: 40 * scale,
              height: 40 * scale,
              decoration: BoxDecoration(
                color: const Color(0xFF176BFF),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: const Icon(Icons.send_rounded, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class _FloatingActionButton extends StatelessWidget {
  const _FloatingActionButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFF176BFF),
        borderRadius: BorderRadius.circular(9999),
        boxShadow: const [BoxShadow(color: Color(0x330B1220), blurRadius: 24, offset: Offset(0, 16))],
      ),
      child: const Icon(Icons.add_rounded, color: Colors.white, size: 32),
    );
  }
}

class _BottomNavigation extends StatelessWidget {
  const _BottomNavigation({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: const Color(0xFFE2E8F0), width: 1 * scale)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 12 * scale),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          _BottomNavItem(icon: Icons.home_filled, label: 'Accueil'),
          _BottomNavItem(icon: Icons.search_rounded, label: 'Recherche'),
          _BottomNavItem(icon: Icons.add_circle_outline_rounded, label: 'Publier'),
          _BottomNavItem(icon: Icons.chat_bubble_outline_rounded, label: 'Messages'),
          _BottomNavItem(icon: Icons.person_outline_rounded, label: 'Profil'),
        ],
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 22, color: const Color(0xFF475569)),
        const SizedBox(height: 6),
        Text(label, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12)),
      ],
    );
  }
}

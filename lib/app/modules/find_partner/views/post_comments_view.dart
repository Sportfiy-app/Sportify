import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_routes.dart';
import '../controllers/post_comments_controller.dart';

class PostCommentsView extends GetView<PostCommentsController> {
  const PostCommentsView({super.key});

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
                _Header(scale: scale),
                Expanded(
                  child: Stack(
                    children: [
                      CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(child: _MediaPreview(scale: scale)),
                          SliverToBoxAdapter(child: _PostSummary(scale: scale)),
                          SliverToBoxAdapter(child: _FilterBar(scale: scale)),
                          SliverToBoxAdapter(child: _SortRow(scale: scale)),
                          SliverPadding(
                            padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 12 * scale),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  final thread = controller.threads[index];
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 16 * scale),
                                    child: _CommentThreadCard(scale: scale, thread: thread),
                                  );
                                },
                                childCount: controller.threads.length,
                              ),
                            ),
                          ),
                          SliverPadding(
                            padding: EdgeInsets.symmetric(horizontal: 16 * scale).copyWith(bottom: 120 * scale),
                            sliver: SliverToBoxAdapter(child: _ThreadFooter(scale: scale)),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: _CommentComposer(scale: scale),
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

class _Header extends StatelessWidget {
  const _Header({required this.scale});

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
          SizedBox(width: 12 * scale),
          Text(
            'Commentaires',
            style: GoogleFonts.poppins(
              color: const Color(0xFF0B1220),
              fontSize: 18 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          _HeaderIconButton(
            scale: scale,
            icon: Icons.search_rounded,
            onTap: () => _showSearchDialog(context, scale),
          ),
          SizedBox(width: 12 * scale),
          _HeaderIconButton(
            scale: scale,
            icon: Icons.more_horiz_rounded,
            onTap: () => Get.snackbar('Options', 'Fonctionnalités à venir'),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog(BuildContext context, double scale) {
    final controller = Get.find<PostCommentsController>();
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Rechercher', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        content: TextField(
          controller: controller.searchController,
          decoration: const InputDecoration(hintText: 'Rechercher un commentaire...'),
          textInputAction: TextInputAction.search,
          onSubmitted: (_) {
            Get.back();
            controller.submitSearch();
          },
        ),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Fermer')),
          FilledButton(
            onPressed: () {
              Get.back();
              controller.submitSearch();
            },
            child: const Text('Rechercher'),
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

class _MediaPreview extends GetView<PostCommentsController> {
  const _MediaPreview({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220 * scale,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24 * scale),
                bottomRight: Radius.circular(24 * scale),
              ),
              child: Image.network(
                controller.detail.images.first,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            right: 16 * scale,
            top: 16 * scale,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.45),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Text(
                '1/${controller.detail.images.length}',
                style: GoogleFonts.inter(color: Colors.white, fontSize: 12 * scale),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PostSummary extends GetView<PostCommentsController> {
  const _PostSummary({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final detail = controller.detail;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24 * scale)),
      ),
      padding: EdgeInsets.fromLTRB(16 * scale, 20 * scale, 16 * scale, 12 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24 * scale,
                backgroundImage: NetworkImage(detail.author.avatarUrl),
              ),
              SizedBox(width: 12 * scale),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      detail.author.name,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF0B1220),
                        fontSize: 16 * scale,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4 * scale),
                    Text(
                      '${detail.author.location} • ${detail.author.timeAgo}',
                      style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale),
                    ),
                  ],
                ),
              ),
              if (detail.author.isUrgent)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 4 * scale),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3D6),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Text('Urgent', style: GoogleFonts.inter(color: const Color(0xFFFFB800), fontSize: 12 * scale, fontWeight: FontWeight.w600)),
                ),
            ],
          ),
          SizedBox(height: 16 * scale),
          Text(
            detail.title,
            style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 20 * scale, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 12 * scale),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 4 * scale),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3D6),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.sports_soccer_rounded, size: 16 * scale, color: const Color(0xFFFFB800)),
                    SizedBox(width: 6 * scale),
                    Text(detail.sportTag, style: GoogleFonts.inter(color: const Color(0xFFFFB800), fontSize: 13 * scale, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              SizedBox(width: 12 * scale),
              Text('${detail.commentsCount} commentaires', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
            ],
          ),
          SizedBox(height: 16 * scale),
          Text(
            detail.description.first,
            style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale, height: 1.5),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 12 * scale),
          TextButton(
            onPressed: () => Get.toNamed(Routes.postDetails, arguments: detail),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              foregroundColor: const Color(0xFF176BFF),
            ),
            child: Text('Voir les détails de la publication', style: GoogleFonts.inter(fontSize: 14 * scale, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

class _FilterBar extends GetView<PostCommentsController> {
  const _FilterBar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 12 * scale),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Obx(
          () => Row(
            children: [
              for (var i = 0; i < controller.filters.length; i++)
                Padding(
                  padding: EdgeInsets.only(right: 10 * scale),
                  child: GestureDetector(
                    onTap: () => controller.selectFilter(i),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 14 * scale, vertical: 8 * scale),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9999),
                        color: controller.selectedFilterIndex.value == i ? const Color(0xFF176BFF) : const Color(0xFFF3F4F6),
                        border: Border.all(color: controller.selectedFilterIndex.value == i ? const Color(0xFF176BFF) : const Color(0xFFE2E8F0)),
                      ),
                      child: Text(
                        controller.filters[i],
                        style: GoogleFonts.inter(
                          color: controller.selectedFilterIndex.value == i ? Colors.white : const Color(0xFF475569),
                          fontSize: 13 * scale,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SortRow extends GetView<PostCommentsController> {
  const _SortRow({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    const sortLabels = {
      CommentSort.recent: 'Plus récents',
      CommentSort.top: 'Les mieux notés',
      CommentSort.organizer: 'Messages organisateur',
    };
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16 * scale, 0, 16 * scale, 12 * scale),
      child: Row(
        children: [
          Text('Trier par', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
          SizedBox(width: 12 * scale),
          Obx(
            () => Wrap(
              spacing: 8 * scale,
              children: CommentSort.values
                  .map(
                    (sort) => ChoiceChip(
                      label: Text(sortLabels[sort]!, style: GoogleFonts.inter(fontSize: 12 * scale, fontWeight: FontWeight.w500)),
                      selected: controller.currentSort.value == sort,
                      onSelected: (_) => controller.setSort(sort),
                      selectedColor: const Color(0xFF176BFF),
                      labelStyle: TextStyle(
                        color: controller.currentSort.value == sort ? Colors.white : const Color(0xFF475569),
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999), side: const BorderSide(color: Color(0xFFE2E8F0))),
                      padding: EdgeInsets.symmetric(horizontal: 6 * scale, vertical: 0),
                    ),
                  )
                  .toList(),
            ),
          ),
          const Spacer(),
          Icon(Icons.filter_list_rounded, size: 18 * scale, color: const Color(0xFF475569)),
        ],
      ),
    );
  }
}

class _CommentThreadCard extends GetView<PostCommentsController> {
  const _CommentThreadCard({required this.scale, required this.thread});

  final double scale;
  final CommentThread thread;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [
          BoxShadow(color: Color(0x0F0B1220), blurRadius: 16, offset: Offset(0, 8)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CommentTile(scale: scale, comment: thread.parent, primary: true),
          if (thread.replies.isNotEmpty) ...[
            SizedBox(height: 16 * scale),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(16 * scale),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 12 * scale),
              child: Column(
                children: [
                  for (final reply in thread.replies)
                    Padding(
                      padding: EdgeInsets.only(bottom: 12 * scale),
                      child: _CommentTile(scale: scale, comment: reply, primary: false),
                    ),
                ],
              ),
            ),
          ],
          SizedBox(height: 12 * scale),
          Row(
            children: [
              GestureDetector(
                onTap: () => controller.reply(thread.parent),
                child: Row(
                  children: [
                    Icon(Icons.reply_rounded, size: 16 * scale, color: const Color(0xFF475569)),
                    SizedBox(width: 6 * scale),
                    Text('Répondre', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
                  ],
                ),
              ),
              SizedBox(width: 18 * scale),
              GestureDetector(
                onTap: () => controller.openThread(thread),
                child: Row(
                  children: [
                    Icon(Icons.chat_bubble_outline_rounded, size: 16 * scale, color: const Color(0xFF475569)),
                    SizedBox(width: 6 * scale),
                    Text('${thread.replies.length} réponses', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CommentTile extends GetView<PostCommentsController> {
  const _CommentTile({required this.scale, required this.comment, required this.primary});

  final double scale;
  final Comment comment;
  final bool primary;

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
              Row(
                children: [
                  Expanded(
                    child: Text(
                      comment.author,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF0B1220),
                        fontSize: 14 * scale,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (comment.isPinned)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8 * scale, vertical: 4 * scale),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.push_pin_rounded, size: 12 * scale, color: const Color(0xFF176BFF)),
                          SizedBox(width: 4 * scale),
                          Text('Organisateur', style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 11 * scale, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  if (comment.isHelpful)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8 * scale, vertical: 4 * scale),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE6F9E8),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.emoji_objects_outlined, size: 12 * scale, color: const Color(0xFF16A34A)),
                          SizedBox(width: 4 * scale),
                          Text('Utile', style: GoogleFonts.inter(color: const Color(0xFF16A34A), fontSize: 11 * scale, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                ],
              ),
              SizedBox(height: 6 * scale),
              Container(
                decoration: BoxDecoration(
                  color: primary ? const Color(0xFFF8FAFC) : Colors.transparent,
                  borderRadius: BorderRadius.circular(16 * scale),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 10 * scale),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < comment.messageLines.length; i++)
                      Padding(
                        padding: EdgeInsets.only(bottom: i == comment.messageLines.length - 1 ? 0 : 4 * scale),
                        child: Text(
                          comment.messageLines[i],
                          style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale, height: 1.4),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 8 * scale),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => controller.toggleLike(comment),
                    child: Row(
                      children: [
                        Icon(Icons.favorite_border_rounded, size: 16 * scale, color: const Color(0xFF475569)),
                        SizedBox(width: 4 * scale),
                        Text('${comment.likes}', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
                      ],
                    ),
                  ),
                  SizedBox(width: 16 * scale),
                  GestureDetector(
                    onTap: () => controller.toggleHelpful(comment),
                    child: Row(
                      children: [
                        Icon(Icons.thumb_up_off_alt_rounded, size: 16 * scale, color: const Color(0xFF475569)),
                        SizedBox(width: 4 * scale),
                        Text('Utile', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
                      ],
                    ),
                  ),
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

class _ThreadFooter extends StatelessWidget {
  const _ThreadFooter({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Tu as une question ?', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
        SizedBox(height: 8 * scale),
        Text(
          'Pose-la dans les commentaires pour aider la communauté.',
          style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _CommentComposer extends GetView<PostCommentsController> {
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

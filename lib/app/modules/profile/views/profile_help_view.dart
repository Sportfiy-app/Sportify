import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/profile_help_controller.dart';

class ProfileHelpView extends GetView<ProfileHelpController> {
  const ProfileHelpView({super.key});

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
                _Header(scale: scale),
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
                            _HeroSection(scale: scale),
                            SizedBox(height: 20 * scale),
                            _QuickActionsSection(scale: scale),
                            SizedBox(height: 24 * scale),
                            _SectionTitle(scale: scale, title: 'Catégories d\'aide'),
                            SizedBox(height: 12 * scale),
                            _CategoriesSection(scale: scale),
                            SizedBox(height: 24 * scale),
                            _SectionTitle(scale: scale, title: 'Questions fréquentes'),
                            SizedBox(height: 12 * scale),
                            _FaqSection(scale: scale),
                            SizedBox(height: 24 * scale),
                            _SectionTitle(scale: scale, title: 'Articles populaires', actionLabel: 'Voir tout'),
                            SizedBox(height: 12 * scale),
                            _PopularArticlesSection(scale: scale),
                            SizedBox(height: 24 * scale),
                            _SectionTitle(scale: scale, title: 'Tutoriels vidéo', actionLabel: 'Voir tout'),
                            SizedBox(height: 12 * scale),
                            _VideoTutorialsSection(scale: scale),
                            SizedBox(height: 24 * scale),
                            _SectionTitle(scale: scale, title: 'Forum communautaire', actionLabel: 'Rejoindre'),
                            SizedBox(height: 12 * scale),
                            _CommunitySection(scale: scale),
                            SizedBox(height: 24 * scale),
                            _SectionTitle(scale: scale, title: 'Autres moyens de nous contacter'),
                            SizedBox(height: 12 * scale),
                            _ContactSection(scale: scale),
                            SizedBox(height: 24 * scale),
                            _SectionTitle(scale: scale, title: 'État des services'),
                            SizedBox(height: 12 * scale),
                            _ServiceStatusSection(scale: scale),
                            SizedBox(height: 24 * scale),
                            _FeedbackBanner(scale: scale),
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

class _Header extends StatelessWidget {
  const _Header({required this.scale});

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Centre d’aide',
                  style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 20 * scale, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 3 * scale),
                Text(
                  'Support & assistance',
                  style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale),
                ),
              ],
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

class _HeroSection extends GetView<ProfileHelpController> {
  const _HeroSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28 * scale),
        boxShadow: [
          BoxShadow(
            color: const Color(0x33176BFF),
            blurRadius: 30 * scale,
            offset: Offset(0, 22 * scale),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Comment pouvons-nous vous aider ?',
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 22 * scale, fontWeight: FontWeight.w700, height: 1.3),
          ),
          SizedBox(height: 8 * scale),
          Text(
            'Trouvez rapidement des réponses à vos questions.',
            style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.9), fontSize: 14 * scale, height: 1.5),
          ),
          SizedBox(height: 18 * scale),
          _SearchField(scale: scale),
          SizedBox(height: 14 * scale),
          _SuggestedTags(scale: scale),
        ],
      ),
    );
  }
}

class _SearchField extends GetView<ProfileHelpController> {
  const _SearchField({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller.searchController,
      onChanged: controller.updateSearch,
      style: GoogleFonts.inter(fontSize: 14 * scale, color: const Color(0xFF0B1220)),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'Rechercher dans l’aide...',
        hintStyle: GoogleFonts.inter(color: const Color(0xFFADAEBC), fontSize: 14 * scale),
        prefixIcon: Icon(Icons.search_rounded, size: 20 * scale, color: const Color(0xFF94A3B8)),
        suffixIcon: Obx(
          () => controller.searchQuery.value.isEmpty
              ? SizedBox(
                  width: 40 * scale,
                  child: Center(
                    child: Container(
                      width: 36 * scale,
                      height: 36 * scale,
                      decoration: BoxDecoration(
                        color: const Color(0xFF176BFF),
                        borderRadius: BorderRadius.circular(10 * scale),
                      ),
                      child: Icon(Icons.tune_rounded, size: 18 * scale, color: Colors.white),
                    ),
                  ),
                )
              : IconButton(
                  onPressed: controller.clearSearch,
                  icon: Icon(Icons.close_rounded, color: const Color(0xFF94A3B8), size: 18 * scale),
                ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 18 * scale, vertical: 16 * scale),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16 * scale),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16 * scale),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16 * scale),
          borderSide: const BorderSide(color: Color(0xFF0F5AE0)),
        ),
      ),
    );
  }
}

class _SuggestedTags extends GetView<ProfileHelpController> {
  const _SuggestedTags({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8 * scale,
      runSpacing: 8 * scale,
      children: controller.suggestedTags
          .map(
            (tag) => Container(
              padding: EdgeInsets.symmetric(horizontal: 14 * scale, vertical: 8 * scale),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
              ),
              child: Text(
                tag,
                style: GoogleFonts.inter(color: Colors.white, fontSize: 13 * scale),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _QuickActionsSection extends GetView<ProfileHelpController> {
  const _QuickActionsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Actions rapides',
          style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 14 * scale),
        Row(
          children: controller.quickActions
              .asMap()
              .entries
              .map(
                (entry) => Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: entry.key == controller.quickActions.length - 1 ? 0 : 12 * scale),
                    child: _QuickActionCard(
                      scale: scale,
                      action: entry.value,
                      onTap: entry.key == 0 ? controller.startChat : controller.callSupport,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({
    required this.scale,
    required this.action,
    required this.onTap,
  });

  final double scale;
  final HelpQuickAction action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20 * scale),
      child: Container(
        padding: EdgeInsets.all(18 * scale),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 12 * scale, offset: Offset(0, 8 * scale)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48 * scale,
              height: 48 * scale,
              decoration: BoxDecoration(color: action.background, borderRadius: BorderRadius.circular(16 * scale)),
              alignment: Alignment.center,
              child: Icon(action.icon, color: action.iconColor, size: 24 * scale),
            ),
            SizedBox(height: 16 * scale),
            Text(action.title, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
            SizedBox(height: 6 * scale),
            Text(action.subtitle, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
            if (action.statusLabel != null && action.statusColor != null) ...[
              SizedBox(height: 10 * scale),
              Row(
                children: [
                  Container(
                    width: 8 * scale,
                    height: 8 * scale,
                    decoration: BoxDecoration(color: action.statusColor, shape: BoxShape.circle),
                  ),
                  SizedBox(width: 6 * scale),
                  Text(action.statusLabel!, style: GoogleFonts.inter(color: action.statusColor, fontSize: 12 * scale, fontWeight: FontWeight.w600)),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _CategoriesSection extends GetView<ProfileHelpController> {
  const _CategoriesSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: controller.categories
          .map(
            (category) => Padding(
              padding: EdgeInsets.only(bottom: 12 * scale),
              child: _HelpCard(
                scale: scale,
                icon: category.icon,
                iconColor: category.iconColor,
                title: category.title,
                subtitle: '${category.articlesCount} articles',
                onTap: () => Get.snackbar(category.title, 'Ouverture de la catégorie...'),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _HelpCard extends StatelessWidget {
  const _HelpCard({
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
      borderRadius: BorderRadius.circular(18 * scale),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18 * scale, vertical: 16 * scale),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            Container(
              width: 40 * scale,
              height: 40 * scale,
              decoration: BoxDecoration(color: iconColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(14 * scale)),
              alignment: Alignment.center,
              child: Icon(icon, color: iconColor, size: 20 * scale),
            ),
            SizedBox(width: 14 * scale),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600)),
                  SizedBox(height: 4 * scale),
                  Text(subtitle, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: const Color(0xFFCBD5F5), size: 22 * scale),
          ],
        ),
      ),
    );
  }
}

class _FaqSection extends GetView<ProfileHelpController> {
  const _FaqSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: controller.faqs
            .asMap()
            .entries
            .map(
              (entry) => Padding(
                padding: EdgeInsets.only(bottom: 12 * scale),
                child: _FaqTile(
                  scale: scale,
                  index: entry.key,
                  item: entry.value,
                  expanded: controller.expandedFaqIndexes.contains(entry.key),
                  onToggle: () => controller.toggleFaq(entry.key),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _FaqTile extends StatelessWidget {
  const _FaqTile({
    required this.scale,
    required this.index,
    required this.item,
    required this.expanded,
    required this.onToggle,
  });

  final double scale;
  final int index;
  final FaqItem item;
  final bool expanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18 * scale),
        onTap: onToggle,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18 * scale, vertical: 16 * scale),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      item.question,
                      style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Icon(expanded ? Icons.remove_circle_outline : Icons.add_circle_outline, color: const Color(0xFF176BFF), size: 22 * scale),
                ],
              ),
              if (expanded) ...[
                SizedBox(height: 12 * scale),
                Text(
                  item.answer,
                  style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale, height: 1.55),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _PopularArticlesSection extends GetView<ProfileHelpController> {
  const _PopularArticlesSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: controller.popularArticles
          .map(
            (article) => Padding(
              padding: EdgeInsets.only(bottom: 12 * scale),
              child: _ArticleCard(scale: scale, article: article, onTap: () => controller.openArticle(article)),
            ),
          )
          .toList(),
    );
  }
}

class _ArticleCard extends StatelessWidget {
  const _ArticleCard({required this.scale, required this.article, required this.onTap});

  final double scale;
  final HelpArticle article;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18 * scale),
      child: Container(
        padding: EdgeInsets.all(18 * scale),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10 * scale, offset: Offset(0, 8 * scale)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48 * scale,
                  height: 48 * scale,
                  decoration: BoxDecoration(color: article.iconColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(16 * scale)),
                  alignment: Alignment.center,
                  child: Icon(article.icon, color: article.iconColor, size: 22 * scale),
                ),
                SizedBox(width: 14 * scale),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(article.title,
                          style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600)),
                      SizedBox(height: 6 * scale),
                      Text(article.description, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale, height: 1.45)),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 14 * scale),
            Row(
              children: [
                Icon(Icons.remove_red_eye_outlined, size: 16 * scale, color: const Color(0xFF94A3B8)),
                SizedBox(width: 6 * scale),
                Text(article.viewsLabel, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
                SizedBox(width: 18 * scale),
                Icon(Icons.thumb_up_off_alt, size: 16 * scale, color: const Color(0xFF94A3B8)),
                SizedBox(width: 6 * scale),
                Text(article.helpfulLabel, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _VideoTutorialsSection extends GetView<ProfileHelpController> {
  const _VideoTutorialsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: controller.tutorialVideos
          .map(
            (video) => Padding(
              padding: EdgeInsets.only(bottom: 12 * scale),
              child: _VideoCard(scale: scale, video: video, onTap: () => controller.playVideo(video)),
            ),
          )
          .toList(),
    );
  }
}

class _VideoCard extends StatelessWidget {
  const _VideoCard({required this.scale, required this.video, required this.onTap});

  final double scale;
  final HelpVideo video;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22 * scale),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 12 * scale, offset: Offset(0, 10 * scale)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150 * scale,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: video.gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.vertical(top: Radius.circular(22 * scale)),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 70 * scale,
                      height: 70 * scale,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.25),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Icon(Icons.play_arrow_rounded, color: Colors.white, size: 34 * scale),
                    ),
                  ),
                  Positioned(
                    right: 14 * scale,
                    top: 12 * scale,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8 * scale, vertical: 4 * scale),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.55),
                        borderRadius: BorderRadius.circular(6 * scale),
                      ),
                      child: Text(video.duration, style: GoogleFonts.inter(color: Colors.white, fontSize: 11 * scale)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(18 * scale),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(video.title,
                      style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600)),
                  SizedBox(height: 8 * scale),
                  Text(video.description, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale, height: 1.45)),
                  SizedBox(height: 14 * scale),
                  Row(
                    children: [
                      Text(video.viewsLabel, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
                      const Spacer(),
                      Icon(Icons.star_rounded, size: 16 * scale, color: const Color(0xFFFFB800)),
                      SizedBox(width: 6 * scale),
                      Text(video.ratingLabel, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
                    ],
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

class _CommunitySection extends GetView<ProfileHelpController> {
  const _CommunitySection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CommunityBanner(scale: scale, onTap: controller.joinCommunity),
        SizedBox(height: 16 * scale),
        Column(
          children: controller.communityPosts
              .map(
                (post) => Padding(
                  padding: EdgeInsets.only(bottom: 12 * scale),
                  child: _CommunityPostCard(scale: scale, post: post),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _CommunityBanner extends StatelessWidget {
  const _CommunityBanner({required this.scale, required this.onTap});

  final double scale;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)]),
        borderRadius: BorderRadius.circular(20 * scale),
        boxShadow: [
          BoxShadow(color: const Color(0x33176BFF), blurRadius: 24 * scale, offset: Offset(0, 16 * scale)),
        ],
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
                child: Icon(Icons.groups_rounded, color: Colors.white, size: 24 * scale),
              ),
              SizedBox(width: 16 * scale),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Rejoignez notre communauté',
                        style: GoogleFonts.poppins(color: Colors.white, fontSize: 16 * scale, fontWeight: FontWeight.w600)),
                    SizedBox(height: 6 * scale),
                    Text('Plus de 50k membres actifs',
                        style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.9), fontSize: 13 * scale)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16 * scale),
          Text(
            'Posez vos questions, partagez vos expériences et connectez-vous avec d’autres sportifs passionnés.',
            style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.9), fontSize: 13 * scale, height: 1.5),
          ),
          SizedBox(height: 20 * scale),
          SizedBox(
            width: 180 * scale,
            child: OutlinedButton(
              onPressed: onTap,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF176BFF),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
              ),
              child: Text('Poser une question', style: GoogleFonts.inter(fontSize: 14 * scale, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}

class _CommunityPostCard extends StatelessWidget {
  const _CommunityPostCard({required this.scale, required this.post});

  final double scale;
  final CommunityPost post;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18 * scale),
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
              CircleAvatar(
                radius: 20 * scale,
                backgroundColor: const Color(0xFFF3F4F6),
                child: Icon(Icons.person_outline_rounded, color: const Color(0xFF64748B), size: 20 * scale),
              ),
              SizedBox(width: 12 * scale),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.author, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
                  SizedBox(height: 4 * scale),
                  Text(post.timeAgo, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
                ],
              ),
            ],
          ),
          SizedBox(height: 12 * scale),
          Text(post.title, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600)),
          SizedBox(height: 14 * scale),
          Row(
            children: [
              Icon(Icons.chat_bubble_outline_rounded, size: 14 * scale, color: const Color(0xFF94A3B8)),
              SizedBox(width: 6 * scale),
              Text('${post.replies} réponses', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
              SizedBox(width: 18 * scale),
              Icon(Icons.thumb_up_off_alt, size: 14 * scale, color: const Color(0xFF94A3B8)),
              SizedBox(width: 6 * scale),
              Text('${post.likes} likes', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 5 * scale),
                decoration: BoxDecoration(color: post.tagColor, borderRadius: BorderRadius.circular(999)),
                child: Text(post.tagLabel, style: GoogleFonts.inter(color: Colors.white, fontSize: 12 * scale, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ContactSection extends GetView<ProfileHelpController> {
  const _ContactSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: controller.contactMethods
          .map(
            (method) => Padding(
              padding: EdgeInsets.only(bottom: 12 * scale),
              child: _HelpCard(
                scale: scale,
                icon: method.icon,
                iconColor: method.iconColor,
                title: method.title,
                subtitle: method.detail,
                onTap: () => controller.openContact(method),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _ServiceStatusSection extends GetView<ProfileHelpController> {
  const _ServiceStatusSection({required this.scale});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text('Services Sportify',
                    style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                decoration: BoxDecoration(color: const Color(0x1916A34A), borderRadius: BorderRadius.circular(999)),
                child:
                    Text('Tous opérationnels', style: GoogleFonts.inter(color: const Color(0xFF16A34A), fontSize: 12 * scale, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          SizedBox(height: 16 * scale),
          Column(
            children: controller.serviceStatuses
                .map(
                  (status) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 6 * scale),
                    child: Row(
                      children: [
                        Expanded(
                          child:
                              Text(status.title, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w500)),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 4 * scale),
                          decoration: BoxDecoration(color: status.color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(999)),
                          child: Row(
                            children: [
                              Container(
                                width: 8 * scale,
                                height: 8 * scale,
                                decoration: BoxDecoration(color: status.color, shape: BoxShape.circle),
                              ),
                              SizedBox(width: 6 * scale),
                              Text(status.status, style: GoogleFonts.inter(color: status.color, fontSize: 12 * scale, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
          SizedBox(height: 16 * scale),
          Container(
            padding: EdgeInsets.all(16 * scale),
            decoration: BoxDecoration(
              color: const Color(0x19F59E0B),
              borderRadius: BorderRadius.circular(16 * scale),
              border: Border.all(color: const Color(0x33F59E0B)),
            ),
            child: Row(
              children: [
                Container(
                  width: 36 * scale,
                  height: 36 * scale,
                  decoration: BoxDecoration(color: const Color(0xFFFDE68A), borderRadius: BorderRadius.circular(12 * scale)),
                  alignment: Alignment.center,
                  child: Icon(Icons.warning_amber_rounded, color: const Color(0xFFB45309), size: 20 * scale),
                ),
                SizedBox(width: 12 * scale),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(controller.maintenance.title,
                          style: GoogleFonts.poppins(color: const Color(0xFFB45309), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
                      SizedBox(height: 6 * scale),
                      Text(controller.maintenance.description,
                          style: GoogleFonts.inter(color: const Color(0xFFB45309), fontSize: 12 * scale, height: 1.4)),
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

class _FeedbackBanner extends GetView<ProfileHelpController> {
  const _FeedbackBanner({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFFFB800), Color(0xFFF59E0B)]),
        borderRadius: BorderRadius.circular(22 * scale),
        boxShadow: [
          BoxShadow(color: const Color(0x4DF59E0B), blurRadius: 24 * scale, offset: Offset(0, 18 * scale)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48 * scale,
                height: 48 * scale,
                decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(16 * scale)),
                alignment: Alignment.center,
                child: Icon(Icons.thumb_up_alt_outlined, color: Colors.white, size: 22 * scale),
              ),
              SizedBox(width: 14 * scale),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Aidez-nous à nous améliorer',
                        style: GoogleFonts.poppins(color: Colors.white, fontSize: 18 * scale, fontWeight: FontWeight.w700)),
                    SizedBox(height: 6 * scale),
                    Text('Votre avis compte énormément', style: GoogleFonts.inter(color: Colors.white, fontSize: 13 * scale)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16 * scale),
          Text(
            'Partagez vos suggestions, rapportez des bugs ou proposez de nouvelles fonctionnalités.',
            style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.92), fontSize: 14 * scale, height: 1.5),
          ),
          SizedBox(height: 18 * scale),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: controller.rateApp,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFFFB800),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
                  ),
                  icon: Icon(Icons.star_rounded, size: 18 * scale),
                  label: Text('Noter l’app', style: GoogleFonts.inter(fontSize: 14 * scale, fontWeight: FontWeight.w600)),
                ),
              ),
              SizedBox(width: 12 * scale),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: controller.sendFeedback,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
                  ),
                  icon: Icon(Icons.feedback_outlined, size: 18 * scale),
                  label: Text('Feedback', style: GoogleFonts.inter(fontSize: 14 * scale, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.scale, required this.title, this.actionLabel});

  final double scale;
  final String title;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600)),
        if (actionLabel != null)
          Text(actionLabel!, style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 13 * scale, fontWeight: FontWeight.w600)),
      ],
    );
  }
}


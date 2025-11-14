import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/new_post_controller.dart';
import '../models/new_post_models.dart';

class NewPostView extends GetView<NewPostController> {
  const NewPostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const designWidth = 375.0;
          final width = constraints.hasBoundedWidth
              ? constraints.maxWidth
              : MediaQuery.of(context).size.width;
          final scale = (width / designWidth).clamp(0.9, 1.15);

          return SafeArea(
            child: Column(
              children: [
                _HeaderBar(scale: scale),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 16 * scale),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _UserComposerCard(scale: scale),
                        SizedBox(height: 16 * scale),
                        _TextArea(scale: scale),
                        SizedBox(height: 16 * scale),
                        _TextSuggestions(scale: scale),
                        SizedBox(height: 16 * scale),
                        _SportPicker(scale: scale),
                        SizedBox(height: 16 * scale),
                        _MediaSection(scale: scale),
                        SizedBox(height: 16 * scale),
                        _AdvancedOptionsTile(scale: scale),
                        SizedBox(height: 12 * scale),
                        Obx(
                          () => controller.showAdvancedOptions.value
                              ? _AdvancedOptionsPanel(scale: scale)
                              : const SizedBox.shrink(),
                        ),
                        SizedBox(height: 16 * scale),
                        _CommunityTipsCard(scale: scale),
                        SizedBox(height: 16 * scale),
                        _PreviousPostsSection(scale: scale),
                        SizedBox(height: 16 * scale),
                        _CommunityRulesCard(scale: scale),
                        SizedBox(height: 16 * scale),
                        _EngagementPreview(scale: scale),
                        SizedBox(height: 120 * scale),
                      ],
                    ),
                  ),
                ),
                _BottomActionBar(scale: scale),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _HeaderBar extends GetView<NewPostController> {
  const _HeaderBar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: const Color(0xFFE2E8F0), width: 1 * scale)),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0C000000),
            blurRadius: 4 * scale,
            offset: Offset(0, 1 * scale),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 12 * scale),
      child: Row(
        children: [
          _CircleButton(
            scale: scale,
            icon: Icons.close_rounded,
            onTap: Get.back,
          ),
          Expanded(
            child: Text(
              'Nouvelle publication',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: const Color(0xFF0B1220),
                fontSize: 18 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Obx(
            () => TextButton(
              onPressed: controller.characterCount.value > 0 ? controller.publishPost : null,
              style: TextButton.styleFrom(
                foregroundColor: controller.characterCount.value > 0
                    ? const Color(0xFF176BFF)
                    : const Color(0xFF94A3B8),
              ),
              child: Text(
                'Publier',
                style: GoogleFonts.inter(
                  fontSize: 15 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UserComposerCard extends GetView<NewPostController> {
  const _UserComposerCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12 * scale,
            offset: Offset(0, 6 * scale),
          ),
        ],
      ),
      padding: EdgeInsets.all(16 * scale),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 56 * scale,
                height: 56 * scale,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF176BFF), width: 3 * scale),
                  image: const DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=200&q=60'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 4 * scale,
                right: 0,
                child: Container(
                  width: 16 * scale,
                  height: 16 * scale,
                  decoration: BoxDecoration(
                    color: const Color(0xFF16A34A),
                    borderRadius: BorderRadius.circular(999 * scale),
                    border: Border.all(color: Colors.white, width: 2 * scale),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 16 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Alexandre Martin',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF0B1220),
                    fontSize: 16 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4 * scale),
                Text(
                  'Publier une annonce',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF475569),
                    fontSize: 14 * scale,
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => PopupMenuButton<String>(
              offset: Offset(0, 40 * scale),
              initialValue: controller.visibility.value,
              onSelected: controller.setVisibility,
              itemBuilder: (context) => const [
                PopupMenuItem(value: 'Public', child: Text('Public')),
                PopupMenuItem(value: 'Amis', child: Text('Amis')),
                PopupMenuItem(value: 'Privé', child: Text('Privé')),
              ],
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(999 * scale),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.lock_open_rounded, size: 16, color: Color(0xFF475569)),
                    SizedBox(width: 6 * scale),
                    Obx(
                      () => Text(
                        controller.visibility.value,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF475569),
                          fontSize: 13 * scale,
                        ),
                      ),
                    ),
                    const Icon(Icons.expand_more_rounded, size: 16, color: Color(0xFF94A3B8)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TextArea extends GetView<NewPostController> {
  const _TextArea({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: EdgeInsets.all(16 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: controller.contentController,
            maxLines: 6,
            maxLength: 500,
            decoration: InputDecoration(
              counterText: '',
              border: InputBorder.none,
              hintText: 'Écrivez quelque chose... Recherchez-vous des partenaires ? Organisez-vous un match ? Partagez votre passion !',
              hintStyle: GoogleFonts.inter(
                color: const Color(0xFFADAEBC),
                fontSize: 15 * scale,
                height: 1.5,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Obx(
              () => Text(
                '${controller.characterCount.value}/500',
                style: GoogleFonts.inter(
                  color: const Color(0xFF475569),
                  fontSize: 12 * scale,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TextSuggestions extends GetView<NewPostController> {
  const _TextSuggestions({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '💡 Suggestions :',
          style: GoogleFonts.inter(
            color: const Color(0xFF475569),
            fontSize: 14 * scale,
          ),
        ),
        SizedBox(height: 12 * scale),
        Wrap(
          spacing: 8 * scale,
          runSpacing: 8 * scale,
          children: controller.textSuggestions
              .map(
                (suggestion) => GestureDetector(
                  onTap: () => controller.applySuggestion(suggestion),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 8 * scale),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(999 * scale),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Text(
                      suggestion,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF475569),
                        fontSize: 13 * scale,
                      ),
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

class _SportPicker extends GetView<NewPostController> {
  const _SportPicker({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: EdgeInsets.all(16 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Quel sport pour l\'annonce ?',
                style: GoogleFonts.inter(
                  color: const Color(0xFF0B1220),
                  fontSize: 16 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 6 * scale),
              Text(
                '*',
                style: GoogleFonts.inter(color: const Color(0xFFEF4444), fontSize: 16 * scale),
              ),
            ],
          ),
          SizedBox(height: 12 * scale),
          Obx(
            () => Container(
              padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 14 * scale),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(16 * scale),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.sports_handball_rounded, color: Color(0xFF176BFF)),
                  SizedBox(width: 12 * scale),
                  Expanded(
                    child: Text(
                      controller.selectedSport.value.isEmpty
                          ? 'Choisir un sport'
                          : controller.selectedSport.value,
                      style: GoogleFonts.inter(
                        color: controller.selectedSport.value.isEmpty
                            ? const Color(0xFF475569)
                            : const Color(0xFF0B1220),
                        fontSize: 15 * scale,
                      ),
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.expand_more_rounded, color: Color(0xFF94A3B8)),
                    itemBuilder: (context) => controller.popularSports
                        .map((sport) => PopupMenuItem(
                              value: sport,
                              child: Text(sport),
                            ))
                        .toList(),
                    onSelected: controller.selectSport,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16 * scale),
          Text(
            '⚡ Sports populaires :',
            style: GoogleFonts.inter(
              color: const Color(0xFF475569),
              fontSize: 14 * scale,
            ),
          ),
          SizedBox(height: 12 * scale),
          Wrap(
            spacing: 8 * scale,
            runSpacing: 8 * scale,
            children: controller.popularSports
                .map(
                  (sport) => Obx(
                    () => ChoiceChip(
                      label: Text(sport),
                      labelStyle: GoogleFonts.inter(
                        color: controller.selectedSport.value == sport
                            ? Colors.white
                            : const Color(0xFF475569),
                        fontSize: 13 * scale,
                      ),
                      selected: controller.selectedSport.value == sport,
                      selectedColor: const Color(0xFF176BFF),
                      onSelected: (_) => controller.selectSport(sport),
                      backgroundColor: const Color(0xFFF3F4F6),
                      side: const BorderSide(color: Color(0xFFE2E8F0)),
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

class _MediaSection extends GetView<NewPostController> {
  const _MediaSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: EdgeInsets.all(16 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ajouter du contenu visuel (optionnel)',
            style: GoogleFonts.inter(
              color: const Color(0xFF0B1220),
              fontSize: 16 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16 * scale),
          Row(
            children: controller.mediaOptions
                .map(
                  (option) => Expanded(
                    child: _MediaOptionCard(scale: scale, option: option),
                  ),
                )
                .expand((widget) => [widget, SizedBox(width: 12 * scale)])
                .toList()
              ..removeLast(),
          ),
        ],
      ),
    );
  }
}

class _MediaOptionCard extends GetView<NewPostController> {
  const _MediaOptionCard({required this.scale, required this.option});

  final double scale;
  final MediaOption option;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.openMediaPicker(option),
      child: Obx(
        () {
          final isSelected = option.title == 'Photo'
              ? controller.includePhoto.value
              : controller.includeVideo.value;
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 20 * scale),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(16 * scale),
              border: Border.all(
                color: isSelected ? option.accent : const Color(0xFFE2E8F0),
                width: 2 * scale,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 48 * scale,
                  height: 48 * scale,
                  decoration: BoxDecoration(
                    color: option.accent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(999 * scale),
                  ),
                  child: Icon(option.icon, color: option.accent, size: 24 * scale),
                ),
                SizedBox(height: 12 * scale),
                Text(
                  option.title,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF0B1220),
                    fontSize: 14 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4 * scale),
                Text(
                  option.subtitle,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF475569),
                    fontSize: 12 * scale,
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

class _AdvancedOptionsTile extends GetView<NewPostController> {
  const _AdvancedOptionsTile({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.toggleAdvancedOptions,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 18 * scale),
        child: Row(
          children: [
            const Icon(Icons.tune_rounded, color: Color(0xFF0B1220)),
            SizedBox(width: 12 * scale),
            Expanded(
              child: Text(
                'Options avancées',
                style: GoogleFonts.inter(
                  color: const Color(0xFF0B1220),
                  fontSize: 16 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Obx(
              () => Icon(
                controller.showAdvancedOptions.value
                    ? Icons.expand_less_rounded
                    : Icons.expand_more_rounded,
                color: const Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AdvancedOptionsPanel extends GetView<NewPostController> {
  const _AdvancedOptionsPanel({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFD0E3FF)),
      ),
      padding: EdgeInsets.all(16 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _AdvancedToggleRow(
            scale: scale,
            label: 'Autoriser les commentaires',
            value: true,
            onChanged: (_) {},
          ),
          _AdvancedToggleRow(
            scale: scale,
            label: 'Publier l\'annonce dans les groupes',
            value: false,
            onChanged: (_) {},
          ),
          _AdvancedToggleRow(
            scale: scale,
            label: 'Recevoir des messages directs',
            value: true,
            onChanged: (_) {},
          ),
        ],
      ),
    );
  }
}

class _AdvancedToggleRow extends StatelessWidget {
  const _AdvancedToggleRow({
    required this.scale,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final double scale;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6 * scale),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.inter(
                color: const Color(0xFF0B1220),
                fontSize: 14 * scale,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF176BFF),
          ),
        ],
      ),
    );
  }
}

class _CommunityTipsCard extends GetView<NewPostController> {
  const _CommunityTipsCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFD0E3FF)),
      ),
      padding: EdgeInsets.all(16 * scale),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32 * scale,
            height: 32 * scale,
            decoration: BoxDecoration(
              color: const Color(0x19176BFF),
              borderRadius: BorderRadius.circular(999 * scale),
            ),
            child: const Icon(Icons.bolt_rounded, color: Color(0xFF176BFF)),
          ),
          SizedBox(width: 12 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Conseils pour une annonce réussie',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF0B1220),
                    fontSize: 16 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8 * scale),
                ...controller.communityTips.map(
                  (tip) => Padding(
                    padding: EdgeInsets.only(bottom: 6 * scale),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('• ', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale)),
                        Expanded(
                          child: Text(
                            tip.text,
                            style: GoogleFonts.inter(
                              color: const Color(0xFF475569),
                              fontSize: 14 * scale,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Get.snackbar('Règles', 'Découvrez les bonnes pratiques bientôt.'),
                  child: Text(
                    'En savoir plus',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF176BFF),
                      fontSize: 14 * scale,
                      fontWeight: FontWeight.w600,
                    ),
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

class _PreviousPostsSection extends GetView<NewPostController> {
  const _PreviousPostsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: EdgeInsets.all(16 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Vos dernières publications',
            style: GoogleFonts.poppins(
              color: const Color(0xFF0B1220),
              fontSize: 16 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12 * scale),
          ...controller.previousPosts.map(
            (post) => Padding(
              padding: EdgeInsets.only(bottom: 12 * scale),
              child: Container(
                padding: EdgeInsets.all(12 * scale),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(16 * scale),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40 * scale,
                      height: 40 * scale,
                      decoration: BoxDecoration(
                        color: const Color(0xFFDCFCE7),
                        borderRadius: BorderRadius.circular(999 * scale),
                      ),
                      child: const Icon(Icons.history_toggle_off_rounded, color: Color(0xFF16A34A)),
                    ),
                    SizedBox(width: 12 * scale),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.title,
                            style: GoogleFonts.inter(
                              color: const Color(0xFF0B1220),
                              fontSize: 14 * scale,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 4 * scale),
                          Text(
                            post.timeAgo,
                            style: GoogleFonts.inter(
                              color: const Color(0xFF475569),
                              fontSize: 12 * scale,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () => Get.snackbar('Réutiliser', 'Fonctionnalité à venir.'),
                      child: Text(
                        'Réutiliser',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF176BFF),
                          fontSize: 14 * scale,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CommunityRulesCard extends StatelessWidget {
  const _CommunityRulesCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFEFCE8),
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: EdgeInsets.all(16 * scale),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32 * scale,
            height: 32 * scale,
            decoration: BoxDecoration(
              color: const Color(0x19F59E0B),
              borderRadius: BorderRadius.circular(999 * scale),
            ),
            child: const Icon(Icons.shield_outlined, color: Color(0xFFF59E0B)),
          ),
          SizedBox(width: 12 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Règles de la communauté',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF0B1220),
                    fontSize: 16 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6 * scale),
                Text(
                  'Respectez les autres utilisateurs et publiez du contenu approprié. Les annonces commerciales sont interdites.',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF475569),
                    fontSize: 14 * scale,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 8 * scale),
                TextButton(
                  onPressed: () => Get.snackbar('Règles', 'Consultez les règles complètes prochainement.'),
                  child: Text(
                    'En savoir plus',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF176BFF),
                      fontSize: 14 * scale,
                      fontWeight: FontWeight.w600,
                    ),
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

class _EngagementPreview extends GetView<NewPostController> {
  const _EngagementPreview({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: EdgeInsets.all(16 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '📊 Aperçu de l\'engagement',
            style: GoogleFonts.poppins(
              color: const Color(0xFF0B1220),
              fontSize: 16 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12 * scale),
          Row(
            children: controller.engagementStats
                .map(
                  (stat) => Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: stat == controller.engagementStats.last ? 0 : 12 * scale),
                      padding: EdgeInsets.symmetric(vertical: 16 * scale),
                      decoration: BoxDecoration(
                        color: stat.accent.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(16 * scale),
                        border: Border.all(color: stat.accent.withValues(alpha: 0.12)),
                      ),
                      child: Column(
                        children: [
                          Text(
                            stat.value,
                            style: GoogleFonts.poppins(
                              color: stat.accent,
                              fontSize: 22 * scale,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 6 * scale),
                          Text(
                            stat.label,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              color: const Color(0xFF475569),
                              fontSize: 12 * scale,
                            ),
                          ),
                        ],
                      ),
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

class _BottomActionBar extends GetView<NewPostController> {
  const _BottomActionBar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 16 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: const Color(0xFFE2E8F0), width: 1 * scale)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10 * scale,
            offset: Offset(0, -4 * scale),
          ),
        ],
      ),
      child: Row(
        children: [
          _SecondaryActionButton(
            scale: scale,
            icon: Icons.archive_rounded,
            label: 'Brouillon',
            onTap: controller.saveDraft,
          ),
          SizedBox(width: 12 * scale),
          _SecondaryActionButton(
            scale: scale,
            icon: Icons.visibility_outlined,
            label: 'Aperçu',
            onTap: controller.previewPost,
          ),
          SizedBox(width: 12 * scale),
          Obx(
            () => Expanded(
              child: ElevatedButton.icon(
                onPressed: controller.characterCount.value > 0 ? controller.publishPost : null,
                icon: const Icon(Icons.send_rounded, size: 18, color: Colors.white),
                label: Text(
                  'Publier l\'annonce',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16 * scale),
                  backgroundColor: const Color(0xFF176BFF),
                  disabledBackgroundColor: const Color(0xFFD1D5DB),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16 * scale)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SecondaryActionButton extends StatelessWidget {
  const _SecondaryActionButton({
    required this.scale,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final double scale;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 18 * scale, color: const Color(0xFF475569)),
        label: Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF475569),
            fontSize: 14 * scale,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 14 * scale),
          side: const BorderSide(color: Color(0xFFE2E8F0)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16 * scale)),
        ),
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
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(999 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Icon(icon, color: const Color(0xFF475569)),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/profile_language_controller.dart';

class ProfileLanguageView extends GetView<ProfileLanguageController> {
  const ProfileLanguageView({super.key});

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
                    padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 20 * scale),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: designWidth * scale),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _CurrentLanguageCard(scale: scale),
                            SizedBox(height: 20 * scale),
                            _SearchField(scale: scale),
                            SizedBox(height: 18 * scale),
                            _QuickLanguageRow(scale: scale),
                            SizedBox(height: 24 * scale),
                            _SectionHeader(scale: scale, title: 'Langues recommandées'),
                            SizedBox(height: 12 * scale),
                            _RecommendedCarousel(scale: scale),
                            SizedBox(height: 24 * scale),
                            _SectionHeader(scale: scale, title: 'Récemment sélectionnées'),
                            SizedBox(height: 12 * scale),
                            _RecentLanguagesList(scale: scale),
                            SizedBox(height: 24 * scale),
                            _SectionHeader(scale: scale, title: 'Toutes les langues'),
                            SizedBox(height: 12 * scale),
                            _AllLanguagesList(scale: scale),
                            SizedBox(height: 24 * scale),
                            _InfoCard(scale: scale),
                            SizedBox(height: 32 * scale),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                _BottomActionBar(scale: scale),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Langue préférée',
                  style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 20 * scale, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 2 * scale),
                Text(
                  'Choisissez la langue de l’interface',
                  style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: Get.find<ProfileLanguageController>().openHelpCenter,
            icon: const Icon(Icons.help_outline_rounded, size: 20),
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

class _CurrentLanguageCard extends GetView<ProfileLanguageController> {
  const _CurrentLanguageCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final current = controller.allLanguages.firstWhere(
          (lang) => lang.code == controller.currentLanguageCode.value,
          orElse: () => const LanguageOption(code: 'fr', name: 'Français', region: 'Europe', speakersLabel: '274 M', flag: '🇫🇷'),
        );

        return Container(
          padding: EdgeInsets.all(20 * scale),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24 * scale),
            boxShadow: [
              BoxShadow(
                color: const Color(0x33176BFF),
                blurRadius: 28 * scale,
                offset: Offset(0, 18 * scale),
              ),
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
                    child: Text(current.flag, style: TextStyle(fontSize: 24 * scale)),
                  ),
                  SizedBox(width: 16 * scale),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          current.name,
                          style: GoogleFonts.poppins(color: Colors.white, fontSize: 18 * scale, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 4 * scale),
                        Text(
                          'Langue actuelle • ${current.region}',
                          style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.85), fontSize: 13 * scale),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      'Interface',
                      style: GoogleFonts.inter(color: Colors.white, fontSize: 12 * scale, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16 * scale),
              Row(
                children: [
                  Icon(Icons.public_rounded, color: Colors.white.withValues(alpha: 0.9), size: 18 * scale),
                  SizedBox(width: 10 * scale),
                  Text(
                    'Locuteurs : ${current.speakersLabel}',
                    style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.9), fontSize: 13 * scale),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SearchField extends GetView<ProfileLanguageController> {
  const _SearchField({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller.searchController,
      onChanged: controller.updateSearch,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'Rechercher une langue ou un pays',
        hintStyle: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 14 * scale),
        prefixIcon: Icon(Icons.search_rounded, color: const Color(0xFF94A3B8), size: 20 * scale),
        suffixIcon: Obx(
          () => controller.searchQuery.value.isEmpty
              ? const SizedBox.shrink()
              : IconButton(
                  onPressed: controller.clearSearch,
                  icon: Icon(Icons.close_rounded, color: const Color(0xFF94A3B8), size: 18 * scale),
                ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 14 * scale),
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
          borderSide: const BorderSide(color: Color(0xFF176BFF)),
        ),
      ),
    );
  }
}

class _QuickLanguageRow extends GetView<ProfileLanguageController> {
  const _QuickLanguageRow({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final quickOptions = [
      const LanguageOption(code: 'fr', name: 'Français', region: '', speakersLabel: '', flag: '🇫🇷'),
      const LanguageOption(code: 'en', name: 'Anglais', region: '', speakersLabel: '', flag: '🇬🇧'),
      const LanguageOption(code: 'ar', name: 'Arabe', region: '', speakersLabel: '', flag: '🇸🇦'),
      const LanguageOption(code: 'es', name: 'Espagnol', region: '', speakersLabel: '', flag: '🇪🇸'),
    ];

    return Obx(
      () => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: quickOptions.map((lang) {
            final selected = controller.isSelected(lang);
            return Padding(
              padding: EdgeInsets.only(right: 10 * scale),
              child: ChoiceChip(
                label: Text(
                  '${lang.flag} ${lang.name}',
                  style: GoogleFonts.inter(
                    color: selected ? Colors.white : const Color(0xFF0B1220),
                    fontSize: 13 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                selected: selected,
                onSelected: (_) => controller.selectLanguage(lang),
                selectedColor: const Color(0xFF176BFF),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                  side: BorderSide(color: selected ? const Color(0xFF176BFF) : const Color(0xFFE2E8F0)),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 8 * scale),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.scale, required this.title});

  final double scale;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600),
    );
  }
}

class _RecommendedCarousel extends GetView<ProfileLanguageController> {
  const _RecommendedCarousel({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 136 * scale,
      child: Obx(
        () => ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: controller.recommendedLanguages.length,
          separatorBuilder: (_, __) => SizedBox(width: 12 * scale),
          itemBuilder: (context, index) {
            final lang = controller.recommendedLanguages[index];
            final selected = controller.isSelected(lang);
            return GestureDetector(
              onTap: () => controller.selectLanguage(lang),
              child: Container(
                width: 200 * scale,
                padding: EdgeInsets.all(16 * scale),
                decoration: BoxDecoration(
                  gradient: selected
                      ? const LinearGradient(
                          colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : const LinearGradient(
                          colors: [Color(0xFFFFFFFF), Color(0xFFF8FAFF)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                  borderRadius: BorderRadius.circular(20 * scale),
                  border: Border.all(color: selected ? Colors.transparent : const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 12 * scale,
                      offset: Offset(0, 10 * scale),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(lang.flag, style: TextStyle(fontSize: 26 * scale)),
                    SizedBox(height: 12 * scale),
                    Text(
                      lang.name,
                      style: GoogleFonts.poppins(
                        color: selected ? Colors.white : const Color(0xFF0B1220),
                        fontSize: 16 * scale,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4 * scale),
                    Text(
                      lang.region,
                      style: GoogleFonts.inter(
                        color: selected ? Colors.white.withValues(alpha: 0.8) : const Color(0xFF475569),
                        fontSize: 13 * scale,
                      ),
                    ),
                    SizedBox(height: 8 * scale),
                    Row(
                      children: [
                        Icon(Icons.people_alt_outlined,
                            size: 16 * scale, color: selected ? Colors.white.withValues(alpha: 0.9) : const Color(0xFF176BFF)),
                        SizedBox(width: 6 * scale),
                        Text(
                          'Locuteurs : ${lang.speakersLabel}',
                          style: GoogleFonts.inter(
                            color: selected ? Colors.white.withValues(alpha: 0.9) : const Color(0xFF176BFF),
                            fontSize: 12 * scale,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
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

class _RecentLanguagesList extends GetView<ProfileLanguageController> {
  const _RecentLanguagesList({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Wrap(
        spacing: 12 * scale,
        runSpacing: 12 * scale,
        children: controller.recentLanguages.map((lang) {
          final selected = controller.isSelected(lang);
          return GestureDetector(
            onTap: () => controller.selectLanguage(lang),
            child: Container(
              width: 160 * scale,
              padding: EdgeInsets.all(16 * scale),
              decoration: BoxDecoration(
                color: selected ? const Color(0xFF176BFF) : Colors.white,
                borderRadius: BorderRadius.circular(16 * scale),
                border: Border.all(color: selected ? Colors.transparent : const Color(0xFFE2E8F0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 8 * scale,
                    offset: Offset(0, 6 * scale),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(lang.flag, style: TextStyle(fontSize: 22 * scale)),
                  SizedBox(height: 10 * scale),
                  Text(
                    lang.name,
                    style: GoogleFonts.poppins(
                      color: selected ? Colors.white : const Color(0xFF0B1220),
                      fontSize: 15 * scale,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4 * scale),
                  Text(
                    lang.region,
                    style: GoogleFonts.inter(
                      color: selected ? Colors.white.withValues(alpha: 0.85) : const Color(0xFF475569),
                      fontSize: 12 * scale,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _AllLanguagesList extends GetView<ProfileLanguageController> {
  const _AllLanguagesList({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final query = controller.searchQuery.value;
      if (query.isNotEmpty) {
        final filtered = controller.filteredLanguages;
        return _FilteredList(scale: scale, languages: filtered);
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: controller.groupedLanguages.entries.map((entry) {
          return Padding(
            padding: EdgeInsets.only(bottom: 18 * scale),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.key,
                  style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 13 * scale, fontWeight: FontWeight.w700, letterSpacing: 0.4),
                ),
                SizedBox(height: 8 * scale),
                ...entry.value.map((lang) => _LanguageTile(scale: scale, language: lang)),
              ],
            ),
          );
        }).toList(),
      );
    });
  }
}

class _FilteredList extends StatelessWidget {
  const _FilteredList({required this.scale, required this.languages});

  final double scale;
  final List<LanguageOption> languages;

  @override
  Widget build(BuildContext context) {
    if (languages.isEmpty) {
      return Container(
        padding: EdgeInsets.all(24 * scale),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Aucun résultat', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
            SizedBox(height: 8 * scale),
            Text(
              'Essayez un autre mot-clé ou vérifiez l’orthographe.',
              style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale),
            ),
          ],
        ),
      );
    }

    return Column(
      children: languages.map((lang) => _LanguageTile(scale: scale, language: lang)).toList(),
    );
  }
}

class _LanguageTile extends GetView<ProfileLanguageController> {
  const _LanguageTile({required this.scale, required this.language});

  final double scale;
  final LanguageOption language;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final selected = controller.isSelected(language);
        return InkWell(
          onTap: () => controller.selectLanguage(language),
          borderRadius: BorderRadius.circular(16 * scale),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 14 * scale),
            margin: EdgeInsets.only(bottom: 10 * scale),
            decoration: BoxDecoration(
              color: selected ? const Color(0xFFEFF4FF) : Colors.white,
              borderRadius: BorderRadius.circular(16 * scale),
              border: Border.all(color: selected ? const Color(0xFF176BFF) : const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                Container(
                  width: 42 * scale,
                  height: 42 * scale,
                  decoration: BoxDecoration(
                    color: selected ? const Color(0xFF176BFF) : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(14 * scale),
                  ),
                  alignment: Alignment.center,
                  child: Text(language.flag, style: TextStyle(fontSize: 20 * scale)),
                ),
                SizedBox(width: 14 * scale),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        language.name,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF0B1220),
                          fontSize: 15 * scale,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 2 * scale),
                      Text(
                        '${language.region} • ${language.speakersLabel} locuteurs',
                        style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 12 * scale),
                      ),
                    ],
                  ),
                ),
                Icon(
                  selected ? Icons.check_circle_rounded : Icons.chevron_right_rounded,
                  color: selected ? const Color(0xFF176BFF) : const Color(0xFFCBD5F5),
                  size: 22 * scale,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(color: const Color(0xFFF59E0B)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40 * scale,
            height: 40 * scale,
            decoration: BoxDecoration(color: const Color(0xFFFDE68A), borderRadius: BorderRadius.circular(14 * scale)),
            alignment: Alignment.center,
            child: Icon(Icons.info_outline_rounded, color: const Color(0xFFB45309), size: 20 * scale),
          ),
          SizedBox(width: 14 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Traductions communautaires',
                  style: GoogleFonts.poppins(color: const Color(0xFFB45309), fontSize: 15 * scale, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 6 * scale),
                Text(
                  'Certaines traductions peuvent évoluer grâce aux retours de la communauté Sportify.',
                  style: GoogleFonts.inter(color: const Color(0xFFB45309), fontSize: 13 * scale, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomActionBar extends GetView<ProfileLanguageController> {
  const _BottomActionBar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 16 * scale),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: controller.goBack,
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14 * scale),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                  foregroundColor: const Color(0xFF0B1220),
                ),
                child: Text('Annuler', style: GoogleFonts.inter(fontSize: 15 * scale, fontWeight: FontWeight.w600)),
              ),
            ),
            SizedBox(width: 12 * scale),
            Expanded(
              child: ElevatedButton(
                onPressed: controller.goBack,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14 * scale),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
                  backgroundColor: const Color(0xFF176BFF),
                ),
                child: Text('Appliquer', style: GoogleFonts.inter(color: Colors.white, fontSize: 15 * scale, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


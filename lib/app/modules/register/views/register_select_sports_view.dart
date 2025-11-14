import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/register_controller.dart';

class RegisterSelectSportsView extends GetView<RegisterController> {
  const RegisterSelectSportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const designWidth = 375.0;
          final maxWidth = constraints.hasBoundedWidth
              ? constraints.maxWidth
              : MediaQuery.of(context).size.width;
          final scale = (maxWidth / designWidth).clamp(0.85, 1.1);

          return SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 16 * scale),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: designWidth * scale),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _HeaderBar(scale: scale),
                      SizedBox(height: 20 * scale),
                      _StepProgress(scale: scale),
                      SizedBox(height: 24 * scale),
                      _HeroSection(scale: scale),
                      SizedBox(height: 24 * scale),
                      _AddSportCard(scale: scale),
                      SizedBox(height: 24 * scale),
                      _PopularSportsSection(scale: scale),
                      SizedBox(height: 24 * scale),
                      _SelectedSportsSection(scale: scale),
                      SizedBox(height: 24 * scale),
                      _TipCard(scale: scale),
                      SizedBox(height: 24 * scale),
                      _ReferenceLevelsCard(scale: scale),
                      SizedBox(height: 24 * scale),
                      _ProfilePreviewCard(scale: scale),
                      SizedBox(height: 24 * scale),
                      _CommunityStatsCard(scale: scale),
                      SizedBox(height: 24 * scale),
                      _MatchingInfoCard(scale: scale),
                      SizedBox(height: 32 * scale),
                      _FooterActions(scale: scale),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _HeaderBar extends GetView<RegisterController> {
  const _HeaderBar({required this.scale});

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
        const Spacer(),
        Container(
          width: 32 * scale,
          height: 32 * scale,
          decoration: BoxDecoration(
            color: const Color(0xFF176BFF),
            borderRadius: BorderRadius.circular(9999),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          alignment: Alignment.center,
          child: Text(
            'S',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18 * scale,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(width: 8 * scale),
        Text(
          'Sportify',
          style: GoogleFonts.poppins(
            color: const Color(0xFF0B1220),
            fontSize: 18 * scale,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: controller.skipSelectSports,
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF475569),
            textStyle: GoogleFonts.inter(
              fontSize: 14 * scale,
              fontWeight: FontWeight.w500,
            ),
          ),
          child: const Text('Plus tard'),
        ),
      ],
    );
  }
}

class _StepProgress extends StatelessWidget {
  const _StepProgress({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Étape 5 sur 6',
              style: GoogleFonts.inter(
                color: const Color(0xFF475569),
                fontSize: 14 * scale,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Text(
              '83%',
              style: GoogleFonts.inter(
                color: const Color(0xFF176BFF),
                fontSize: 14 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 12 * scale),
        ClipRRect(
          borderRadius: BorderRadius.circular(9999),
          child: LinearProgressIndicator(
            value: 0.83,
            minHeight: 8 * scale,
            backgroundColor: const Color(0xFFE2E8F0),
            valueColor: const AlwaysStoppedAnimation(Color(0xFF176BFF)),
          ),
        ),
      ],
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24 * scale, vertical: 28 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 24 * scale,
            offset: Offset(0, 12 * scale),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 64 * scale,
            height: 64 * scale,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment(-0.35, 0.35),
                end: Alignment(0.35, 1.06),
                colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
              ),
              borderRadius: BorderRadius.circular(9999),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.sports_soccer_outlined, size: 30 * scale, color: Colors.white),
          ),
          SizedBox(height: 20 * scale),
          Text(
            'Quels sports pratiquez-vous ?',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: const Color(0xFF0B1220),
              fontSize: 24 * scale,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 12 * scale),
          Text(
            'Ajoutez vos sports favoris pour améliorer votre matching avec d’autres sportifs.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF475569),
              fontSize: 16 * scale,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}

class _AddSportCard extends GetView<RegisterController> {
  const _AddSportCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(16 * scale);

    return Container(
      padding: EdgeInsets.all(24 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 18 * scale,
            offset: Offset(0, 8 * scale),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ajouter un sport',
            style: GoogleFonts.poppins(
              color: const Color(0xFF0B1220),
              fontSize: 18 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 24 * scale),
          Obx(
            () => DropdownButtonFormField<String>(
              value: controller.selectedSportName.value.isEmpty
                  ? null
                  : controller.selectedSportName.value,
              items: controller.availableSports
                  .map(
                    (sport) => DropdownMenuItem<String>(
                      value: sport,
                      child: Text(
                        sport,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF0B1220),
                          fontSize: 16 * scale,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              decoration: _inputDecoration('Sport', scale),
              style: GoogleFonts.inter(
                color: const Color(0xFF0B1220),
                fontSize: 16 * scale,
              ),
              onChanged: controller.selectSport,
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
            ),
          ),
          SizedBox(height: 16 * scale),
          Obx(
            () => DropdownButtonFormField<String>(
              value: controller.selectedLevel.value.isEmpty
                  ? null
                  : controller.selectedLevel.value,
              items: controller.levels
                  .map(
                    (level) => DropdownMenuItem<String>(
                      value: level,
                      child: Text(
                        level,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF0B1220),
                          fontSize: 16 * scale,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              decoration: _inputDecoration('Niveau (facultatif)', scale),
              style: GoogleFonts.inter(
                color: const Color(0xFF0B1220),
                fontSize: 16 * scale,
              ),
              onChanged: controller.selectLevel,
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
            ),
          ),
          SizedBox(height: 16 * scale),
          TextField(
            controller: controller.rankingInputController,
            decoration: _inputDecoration('Classement / Détails (facultatif)', scale),
            style: GoogleFonts.inter(
              color: const Color(0xFF0B1220),
              fontSize: 16 * scale,
            ),
          ),
          SizedBox(height: 24 * scale),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: controller.addSelectedSport,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16 * scale),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scale)),
                backgroundColor: const Color(0xFF176BFF),
              ),
              child: Text(
                'Ajouter le sport à la liste',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String label, double scale) {
    return InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.inter(
        color: const Color(0xFF475569),
        fontSize: 14 * scale,
        fontWeight: FontWeight.w500,
      ),
      filled: true,
      fillColor: const Color(0xFFF9FAFB),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12 * scale),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12 * scale),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12 * scale),
        borderSide: const BorderSide(color: Color(0xFF176BFF), width: 1.8),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 14 * scale),
    );
  }
}

class _PopularSportsSection extends GetView<RegisterController> {
  const _PopularSportsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final popularSportTags = [
      _SportTagData('Football', Icons.sports_soccer, '#1'),
      _SportTagData('Tennis', Icons.sports_tennis, '#2'),
      _SportTagData('Basketball', Icons.sports_basketball, '#3'),
      _SportTagData('Padel', Icons.sports_tennis_outlined, 'Tendance'),
      _SportTagData('Running', Icons.directions_run, 'Cardio'),
      _SportTagData('Natation', Icons.pool_outlined, 'Endurance'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sports populaires',
          style: GoogleFonts.poppins(
            color: const Color(0xFF0B1220),
            fontSize: 18 * scale,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12 * scale),
        Wrap(
          spacing: 12 * scale,
          runSpacing: 12 * scale,
          children: popularSportTags
              .map(
                (sport) => GestureDetector(
                  onTap: () {
                    controller.quickSelectSport(sport.name);
                    controller.addSelectedSport();
                  },
                  child: Container(
                    width: 160 * scale,
                    padding: EdgeInsets.all(16 * scale),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12 * scale),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 12 * scale,
                          offset: Offset(0, 6 * scale),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40 * scale,
                          height: 40 * scale,
                          decoration: BoxDecoration(
                            gradient: sport.gradient,
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          alignment: Alignment.center,
                          child: Icon(sport.icon, color: Colors.white, size: 20 * scale),
                        ),
                        SizedBox(width: 12 * scale),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                sport.name,
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF0B1220),
                                  fontSize: 14 * scale,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 4 * scale),
                              Text(
                                sport.subtitle,
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF475569),
                                  fontSize: 12 * scale,
                                ),
                              ),
                            ],
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
    );
  }
}

class _SelectedSportsSection extends GetView<RegisterController> {
  const _SelectedSportsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Mes sports',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF0B1220),
                    fontSize: 18 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Obx(
                () => Container(
                  padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                  decoration: BoxDecoration(
                    color: const Color(0xFF176BFF),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Text(
                    '${controller.selectedSports.length}/5',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14 * scale,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16 * scale),
          Obx(
            () {
              if (controller.selectedSports.isEmpty) {
                return Column(
                  children: [
                    Container(
                      width: 64 * scale,
                      height: 64 * scale,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(9999),
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                      ),
                      alignment: Alignment.center,
                      child: Icon(Icons.sports_martial_arts_outlined, size: 28 * scale, color: const Color(0xFF9CA3AF)),
                    ),
                    SizedBox(height: 16 * scale),
                    Text(
                      'Aucun sport ajouté pour le moment',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF475569),
                        fontSize: 16 * scale,
                      ),
                    ),
                    SizedBox(height: 4 * scale),
                    Text(
                      'Ajoutez votre premier sport ci-dessus.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF64748B),
                        fontSize: 14 * scale,
                      ),
                    ),
                  ],
                );
              }

              return Wrap(
                spacing: 12 * scale,
                runSpacing: 12 * scale,
                children: controller.selectedSports
                    .map(
                      (sport) => Container(
                        width: 150 * scale,
                        padding: EdgeInsets.all(12 * scale),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(12 * scale),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    sport.name,
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFF0B1220),
                                      fontSize: 14 * scale,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => controller.removeSport(sport),
                                  child: Icon(Icons.close_rounded, size: 18 * scale, color: const Color(0xFF94A3B8)),
                                ),
                              ],
                            ),
                            if (sport.level != null && sport.level!.isNotEmpty) ...[
                              SizedBox(height: 6 * scale),
                              Text(
                                sport.level!,
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF475569),
                                  fontSize: 12 * scale,
                                ),
                              ),
                            ],
                            if (sport.ranking != null && sport.ranking!.isNotEmpty) ...[
                              SizedBox(height: 6 * scale),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 4 * scale),
                                decoration: BoxDecoration(
                                  color: const Color(0x19176BFF),
                                  borderRadius: BorderRadius.circular(9999),
                                ),
                                child: Text(
                                  sport.ranking!,
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF176BFF),
                                    fontSize: 12 * scale,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TipCard extends StatelessWidget {
  const _TipCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFBFDBFE)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32 * scale,
            height: 32 * scale,
            decoration: BoxDecoration(
              color: const Color(0xFF0EA5E9),
              borderRadius: BorderRadius.circular(9999),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.info_outline, color: Colors.white, size: 18 * scale),
          ),
          SizedBox(width: 16 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Conseil',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF1E3A8A),
                    fontSize: 16 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8 * scale),
                Text(
                  'Ajoutez 2 à 3 sports pour optimiser votre matching. Un profil complet vous aide à trouver des partenaires compatibles plus rapidement.',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF1E40AF),
                    fontSize: 14 * scale,
                    height: 1.55,
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

class _ReferenceLevelsCard extends StatelessWidget {
  const _ReferenceLevelsCard({required this.scale});

  final double scale;

  final _levels = const [
    _ReferenceLevel('Débutant', "Moins d'un an de pratique", Color(0xFF22C55E)),
    _ReferenceLevel('Intermédiaire', '1-5 ans, club local', Color(0xFFEAB308)),
    _ReferenceLevel('Confirmé', '5+ ans, compétitions régionales', Color(0xFFF97316)),
    _ReferenceLevel('Expert', 'Niveau national/professionnel', Color(0xFFEF4444)),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Niveaux de référence',
          style: GoogleFonts.poppins(
            color: const Color(0xFF0B1220),
            fontSize: 18 * scale,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12 * scale),
        Container(
          padding: EdgeInsets.all(24 * scale),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16 * scale),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            children: _levels
                .map(
                  (level) => Padding(
                    padding: EdgeInsets.only(bottom: 16 * scale),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 12 * scale,
                          height: 12 * scale,
                          margin: EdgeInsets.only(top: 6 * scale),
                          decoration: BoxDecoration(
                            color: level.color,
                            borderRadius: BorderRadius.circular(9999),
                          ),
                        ),
                        SizedBox(width: 12 * scale),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                level.title,
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF0B1220),
                                  fontSize: 16 * scale,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 4 * scale),
                              Text(
                                level.description,
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF475569),
                                  fontSize: 14 * scale,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _ProfilePreviewCard extends StatelessWidget {
  const _ProfilePreviewCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Aperçu de votre profil',
          style: GoogleFonts.poppins(
            color: const Color(0xFF0B1220),
            fontSize: 18 * scale,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12 * scale),
        Container(
          padding: EdgeInsets.all(24 * scale),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment(-0.35, 0.35),
              end: Alignment(0.35, 1.06),
              colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
            ),
            borderRadius: BorderRadius.circular(16 * scale),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Profil sportif',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 18 * scale,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4 * scale),
                        Text(
                          'Complétude: 83%',
                          style: GoogleFonts.inter(
                            color: Colors.white.withValues(alpha: 0.75),
                            fontSize: 14 * scale,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 48 * scale,
                    height: 48 * scale,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.sports_handball_outlined, color: Colors.white, size: 22 * scale),
                  ),
                ],
              ),
              SizedBox(height: 20 * scale),
              Row(
                children: [
                  _ProfileMetric(scale: scale, label: 'Sports', value: '0'),
                  SizedBox(width: 12 * scale),
                  _ProfileMetric(scale: scale, label: 'Matches', value: '0'),
                  SizedBox(width: 12 * scale),
                  _ProfileMetric(scale: scale, label: 'Amis', value: '0'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CommunityStatsCard extends StatelessWidget {
  const _CommunityStatsCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Communauté Sportify',
          style: GoogleFonts.poppins(
            color: const Color(0xFF0B1220),
            fontSize: 18 * scale,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12 * scale),
        Container(
          padding: EdgeInsets.all(24 * scale),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16 * scale),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _StatBlock(
                      scale: scale,
                      value: '50K+',
                      label: 'Sportifs actifs',
                      color: const Color(0xFF176BFF),
                    ),
                  ),
                  SizedBox(width: 12 * scale),
                  Expanded(
                    child: _StatBlock(
                      scale: scale,
                      value: '25',
                      label: 'Sports disponibles',
                      color: const Color(0xFF16A34A),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24 * scale),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Sports les plus pratiqués',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF0B1220),
                    fontSize: 16 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 16 * scale),
              Column(
                children: () {
                  const popularityData = [
                    _PopularityData('Football', '35%', Color(0xFF16A34A)),
                    _PopularityData('Tennis', '28%', Color(0xFFF59E0B)),
                    _PopularityData('Basketball', '22%', Color(0xFFEF4444)),
                  ];
                  return [
                    for (var i = 0; i < popularityData.length; i++)
                      Padding(
                        padding: EdgeInsets.only(bottom: i == popularityData.length - 1 ? 0 : 12 * scale),
                        child: _PopularityRow(
                          scale: scale,
                          label: popularityData[i].label,
                          percentage: popularityData[i].percentage,
                          color: popularityData[i].color,
                        ),
                      ),
                  ];
                }(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MatchingInfoCard extends StatelessWidget {
  const _MatchingInfoCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final points = [
      'Niveau de jeu compatible',
      'Proximité géographique',
      'Créneaux disponibles',
      'Préférences communes',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Matching intelligent',
          style: GoogleFonts.poppins(
            color: const Color(0xFF0B1220),
            fontSize: 18 * scale,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12 * scale),
        Container(
          padding: EdgeInsets.all(24 * scale),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16 * scale),
            border: Border.all(color: const Color(0xFFE2E8F0)),
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
                      gradient: const LinearGradient(
                        begin: Alignment(-0.35, 0.35),
                        end: Alignment(0.35, 1.06),
                        colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
                      ),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.auto_awesome, color: Colors.white, size: 22 * scale),
                  ),
                  SizedBox(width: 16 * scale),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'IA de matching',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF0B1220),
                            fontSize: 16 * scale,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4 * scale),
                        Text(
                          'Trouvez les meilleurs partenaires',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF475569),
                            fontSize: 14 * scale,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20 * scale),
              ...points.map(
                (point) => Padding(
                  padding: EdgeInsets.only(bottom: 12 * scale),
                  child: Row(
                    children: [
                      Container(
                        width: 8 * scale,
                        height: 8 * scale,
                        decoration: const BoxDecoration(
                          color: Color(0xFF176BFF),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 12 * scale),
                      Expanded(
                        child: Text(
                          point,
                          style: GoogleFonts.inter(
                            color: const Color(0xFF0B1220),
                            fontSize: 14 * scale,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FooterActions extends GetView<RegisterController> {
  const _FooterActions({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ProgressDots(scale: scale, activeIndex: 4, count: 6),
        SizedBox(height: 16 * scale),
        SizedBox(
          width: double.infinity,
          child: Obx(
            () => ElevatedButton(
              onPressed: controller.canFinishRegistration
                  ? controller.continueFromSelectSports
                  : null,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 18 * scale),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scale)),
                backgroundColor: const Color(0xFF176BFF),
                disabledBackgroundColor: const Color(0xFFD1D5DB),
              ),
              child: Text(
                'Continuer',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 16 * scale),
        Text(
          'Ajoutez au moins un sport pour terminer votre profil. Vous pourrez en ajouter davantage plus tard.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: const Color(0xFF475569),
            fontSize: 12 * scale,
            height: 1.45,
          ),
        ),
      ],
    );
  }
}

class _ProgressDots extends StatelessWidget {
  const _ProgressDots({required this.scale, required this.activeIndex, required this.count});

  final double scale;
  final int activeIndex;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (index) => Container(
          width: 8 * scale,
          height: 8 * scale,
          margin: EdgeInsets.symmetric(horizontal: 4 * scale),
          decoration: BoxDecoration(
            color: index == activeIndex ? const Color(0xFF176BFF) : const Color(0xFFD1D5DB),
            borderRadius: BorderRadius.circular(9999),
          ),
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
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(9999),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: const Color(0xFF0B1220), size: 18 * scale),
      ),
    );
  }
}

class _ProfileMetric extends StatelessWidget {
  const _ProfileMetric({required this.scale, required this.label, required this.value});

  final double scale;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12 * scale),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12 * scale),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20 * scale,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 4 * scale),
            Text(
              label,
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 12 * scale,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatBlock extends StatelessWidget {
  const _StatBlock({required this.scale, required this.value, required this.label, required this.color});

  final double scale;
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12 * scale),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.poppins(
              color: color,
              fontSize: 24 * scale,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4 * scale),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF475569),
              fontSize: 12 * scale,
            ),
          ),
        ],
      ),
    );
  }
}

class _PopularityRow extends StatelessWidget {
  const _PopularityRow({required this.scale, required this.label, required this.percentage, required this.color});

  final double scale;
  final String label;
  final String percentage;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36 * scale,
          height: 36 * scale,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color, color.withValues(alpha: 0.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(9999),
          ),
          alignment: Alignment.center,
          child: Icon(Icons.sports, size: 18 * scale, color: Colors.white),
        ),
        SizedBox(width: 12 * scale),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.inter(
              color: const Color(0xFF0B1220),
              fontSize: 14 * scale,
            ),
          ),
        ),
        Text(
          percentage,
          style: GoogleFonts.inter(
            color: const Color(0xFF475569),
            fontSize: 14 * scale,
          ),
        ),
      ],
    );
  }
}

class _SportTagData {
  _SportTagData(this.name, this.icon, this.subtitle);

  final String name;
  final IconData icon;
  final String subtitle;

  LinearGradient get gradient {
    switch (name) {
      case 'Football':
        return const LinearGradient(colors: [Color(0xFF16A34A), Color(0xFF15803D)], begin: Alignment.topLeft, end: Alignment.bottomRight);
      case 'Tennis':
        return const LinearGradient(colors: [Color(0xFFFFB800), Color(0xFFF59E0B)], begin: Alignment.topLeft, end: Alignment.bottomRight);
      case 'Basketball':
        return const LinearGradient(colors: [Color(0xFFEF4444), Color(0xFFDC2626)], begin: Alignment.topLeft, end: Alignment.bottomRight);
      case 'Padel':
        return const LinearGradient(colors: [Color(0xFFEC4899), Color(0xFFDB2777)], begin: Alignment.topLeft, end: Alignment.bottomRight);
      default:
        return const LinearGradient(colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)], begin: Alignment.topLeft, end: Alignment.bottomRight);
    }
  }
}

class _ReferenceLevel {
  const _ReferenceLevel(this.title, this.description, this.color);

  final String title;
  final String description;
  final Color color;
}

class _PopularityData {
  const _PopularityData(this.label, this.percentage, this.color);

  final String label;
  final String percentage;
  final Color color;
}

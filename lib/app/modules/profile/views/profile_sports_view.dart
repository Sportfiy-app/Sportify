import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/profile_sports_controller.dart';

class ProfileSportsView extends GetView<ProfileSportsController> {
  const ProfileSportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const designWidth = 375.0;
          final width = constraints.maxWidth.isFinite ? constraints.maxWidth : MediaQuery.of(context).size.width;
          final scale = (width / designWidth).clamp(0.9, 1.12);

          return Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: Container(
                  height: 220 * scale,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
                      begin: Alignment(0.35, 0.35),
                      end: Alignment(1.06, -0.35),
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 12 * scale),
                      child: _Header(scale: scale),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 12 * scale)
                            .copyWith(bottom: MediaQuery.of(context).padding.bottom + 160 * scale),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _HeroCard(scale: scale),
                            SizedBox(height: 20 * scale),
                            _SportForm(scale: scale),
                            SizedBox(height: 24 * scale),
                            _AddedSportsList(scale: scale),
                            SizedBox(height: 24 * scale),
                            _PopularSports(scale: scale),
                            SizedBox(height: 24 * scale),
                            _InsightCard(scale: scale),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _BottomBar(scale: scale),
            ],
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
    return Row(
      children: [
        GestureDetector(
          onTap: Get.back,
          child: Container(
            width: 44 * scale,
            height: 44 * scale,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18 * scale),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'Mes sports',
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 20 * scale, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        Container(
          width: 44 * scale,
          height: 44 * scale,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
          ),
          alignment: Alignment.center,
          child: Icon(Icons.help_outline_rounded, color: Colors.white, size: 20 * scale),
        ),
      ],
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: const Color(0x33176BFF), blurRadius: 22 * scale, offset: Offset(0, 12 * scale)),
        ],
      ),
      padding: EdgeInsets.all(24 * scale),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52 * scale,
            height: 52 * scale,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16 * scale),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.sports_soccer_rounded, color: Colors.white, size: 28 * scale),
          ),
          SizedBox(width: 16 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ajoutez vos sports',
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 18 * scale, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10 * scale),
                Text(
                  'Sélectionnez vos disciplines, indiquez votre niveau et votre classement. Nous vous proposerons des partenaires adaptés.',
                  style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.85), fontSize: 14 * scale, height: 1.55),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SportForm extends GetView<ProfileSportsController> {
  const _SportForm({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 18 * scale, offset: Offset(0, 10 * scale)),
        ],
      ),
      padding: EdgeInsets.all(20 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Sélectionnez un sport', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
          SizedBox(height: 12 * scale),
          Obx(
            () => DropdownButtonFormField<String>(
              value: controller.selectedSport.value.isEmpty ? null : controller.selectedSport.value,
              items: controller.availableSports
                  .map(
                    (sport) => DropdownMenuItem(
                      value: sport.name,
                      child: Text(sport.name, style: GoogleFonts.inter(fontSize: 15 * scale, color: const Color(0xFF111827))),
                    ),
                  )
                  .toList(),
              onChanged: controller.selectSport,
              decoration: _inputDecoration(scale).copyWith(
                hintText: 'Choisir un sport',
                prefixIcon: Icon(Icons.sports, color: const Color(0xFF2563EB), size: 20 * scale),
              ),
            ),
          ),
          SizedBox(height: 18 * scale),
          _DualFieldRow(
            scale: scale,
            leftLabel: 'Niveau pratiqué (optionnel)',
            leftController: controller.levelController,
            leftHint: 'Ex : National 2, Intermédiaire...',
            rightLabel: 'Classement (optionnel)',
            rightController: controller.rankingController,
            rightHint: 'Ex : 15/1, 200ème France...',
          ),
          SizedBox(height: 18 * scale),
          ElevatedButton.icon(
            onPressed: controller.addSport,
            icon: Icon(Icons.add_rounded, color: Colors.white, size: 20 * scale),
            label: Text('Ajouter le sport à la liste', style: GoogleFonts.inter(color: Colors.white, fontSize: 15 * scale, fontWeight: FontWeight.w700)),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 14 * scale),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
              backgroundColor: const Color(0xFF176BFF),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }
}

class _DualFieldRow extends StatelessWidget {
  const _DualFieldRow({
    required this.scale,
    required this.leftLabel,
    required this.leftController,
    required this.leftHint,
    required this.rightLabel,
    required this.rightController,
    required this.rightHint,
  });

  final double scale;
  final String leftLabel;
  final TextEditingController leftController;
  final String leftHint;
  final String rightLabel;
  final TextEditingController rightController;
  final String rightHint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(leftLabel, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
        SizedBox(height: 8 * scale),
        TextField(
          controller: leftController,
          decoration: _inputDecoration(scale).copyWith(hintText: leftHint),
          textInputAction: TextInputAction.next,
        ),
        SizedBox(height: 16 * scale),
        Text(rightLabel, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
        SizedBox(height: 8 * scale),
        TextField(
          controller: rightController,
          decoration: _inputDecoration(scale).copyWith(hintText: rightHint),
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}

class _AddedSportsList extends GetView<ProfileSportsController> {
  const _AddedSportsList({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final sports = controller.sports;
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20 * scale),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 18 * scale, offset: Offset(0, 10 * scale)),
            ],
          ),
          padding: EdgeInsets.all(20 * scale),
          child: sports.isEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 68 * scale,
                      height: 68 * scale,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      alignment: Alignment.center,
                      child: Icon(Icons.add_task_rounded, color: const Color(0xFF94A3B8), size: 32 * scale),
                    ),
                    SizedBox(height: 16 * scale),
                    Text('Aucun sport ajouté', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 17 * scale, fontWeight: FontWeight.w600)),
                    SizedBox(height: 8 * scale),
                    Text(
                      'Sélectionnez un sport ci-dessus pour commencer votre liste.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale, height: 1.5),
                    ),
                  ],
                )
              : ReorderableListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: sports.length,
                  onReorder: controller.reorderSports,
                  itemBuilder: (context, index) {
                    final entry = sports[index];
                    return _SportTile(scale: scale, entry: entry, key: ValueKey(entry.name));
                  },
                ),
        );
      },
    );
  }
}

class _SportTile extends GetView<ProfileSportsController> {
  const _SportTile({required this.scale, required this.entry, super.key});

  final double scale;
  final ProfileSportEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      margin: EdgeInsets.only(bottom: 12 * scale),
      decoration: BoxDecoration(
        color: entry.color.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: entry.color.withValues(alpha: 0.3)),
      ),
      padding: EdgeInsets.all(16 * scale),
      child: Row(
        children: [
          Container(
            width: 42 * scale,
            height: 42 * scale,
            decoration: BoxDecoration(color: entry.color, borderRadius: BorderRadius.circular(12 * scale)),
            alignment: Alignment.center,
            child: Text(entry.name.characters.first.toUpperCase(), style: GoogleFonts.inter(color: Colors.white, fontSize: 18 * scale, fontWeight: FontWeight.w700)),
          ),
          SizedBox(width: 14 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.name, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
                SizedBox(height: 4 * scale),
                Wrap(
                  spacing: 8 * scale,
                  runSpacing: 6 * scale,
                  children: [
                    if (entry.level != null)
                      _InfoChip(
                        label: entry.level!,
                        icon: Icons.emoji_events_outlined,
                        color: entry.color,
                        scale: scale,
                      ),
                    if (entry.ranking != null)
                      _InfoChip(
                        label: entry.ranking!,
                        icon: Icons.bar_chart_rounded,
                        color: entry.color,
                        scale: scale,
                      ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => controller.removeSport(entry),
            icon: Icon(Icons.delete_outline_rounded, color: const Color(0xFFEF4444), size: 22 * scale),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label, required this.icon, required this.color, required this.scale});

  final String label;
  final IconData icon;
  final Color color;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 6 * scale),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(999)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 15 * scale),
          SizedBox(width: 6 * scale),
          Text(label, style: GoogleFonts.inter(color: color, fontSize: 12.5 * scale, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _PopularSports extends GetView<ProfileSportsController> {
  const _PopularSports({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Sports populaires', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
        SizedBox(height: 12 * scale),
        Wrap(
          spacing: 10 * scale,
          runSpacing: 10 * scale,
          children: controller.availableSports
              .take(6)
              .map(
                (sport) => ChoiceChip(
                  label: Text(sport.name, style: GoogleFonts.inter(color: const Color(0xFF0B1220))),
                  selected: false,
                  side: BorderSide(color: sport.color.withValues(alpha: 0.35)),
                  backgroundColor: Colors.white,
                  onSelected: (_) => controller.quickSelectSport(sport.name),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _InsightCard extends StatelessWidget {
  const _InsightCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFFFB800), Color(0xFFF59E0B)]),
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: const Color(0xFFFCD34D).withValues(alpha: 0.6)),
      ),
      padding: EdgeInsets.all(20 * scale),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44 * scale,
            height: 44 * scale,
            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.25), borderRadius: BorderRadius.circular(14 * scale)),
            alignment: Alignment.center,
            child: Icon(Icons.lightbulb_outline_rounded, color: Colors.white, size: 24 * scale),
          ),
          SizedBox(width: 14 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Conseil', style: GoogleFonts.poppins(color: Colors.white, fontSize: 16 * scale, fontWeight: FontWeight.w600)),
                SizedBox(height: 6 * scale),
                Text(
                  'Les profils avec 5 sports ou plus reçoivent 3× plus d’invitations. Ajoutez un maximum de disciplines pour optimiser vos rencontres.',
                  style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.9), fontSize: 14 * scale, height: 1.55),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomBar extends GetView<ProfileSportsController> {
  const _BottomBar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.fromLTRB(16 * scale, 12 * scale, 16 * scale, 12 * scale + MediaQuery.of(context).padding.bottom),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: const Color(0xFFE2E8F0), width: 1 * scale)),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 16 * scale, offset: Offset(0, -8 * scale)),
          ],
        ),
        child: Obx(
          () => Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: Get.back,
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14 * scale),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
                    side: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  child: Text('Annuler', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 15 * scale, fontWeight: FontWeight.w600)),
                ),
              ),
              SizedBox(width: 12 * scale),
              Expanded(
                child: ElevatedButton(
                  onPressed: controller.isSaving.value ? null : controller.saveSports,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF16A34A), Color(0xFF22C55E)]),
                      borderRadius: BorderRadius.circular(14 * scale),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 16 * scale),
                      child: controller.isSaving.value
                          ? SizedBox(
                              width: 18 * scale,
                              height: 18 * scale,
                              child: const CircularProgressIndicator(strokeWidth: 2.2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                            )
                          : Text('Enregistrer mes sports', style: GoogleFonts.inter(color: Colors.white, fontSize: 15 * scale, fontWeight: FontWeight.w700)),
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

InputDecoration _inputDecoration(double scale) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.symmetric(horizontal: 14 * scale, vertical: 14 * scale),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12 * scale),
      borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12 * scale),
      borderSide: const BorderSide(color: Color(0xFF2563EB)),
    ),
    hintStyle: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 15 * scale),
  );
}


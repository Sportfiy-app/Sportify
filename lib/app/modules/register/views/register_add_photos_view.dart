import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/register_controller.dart';

class RegisterAddPhotosView extends GetView<RegisterController> {
  const RegisterAddPhotosView({super.key});

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
                      _IntroCard(scale: scale),
                      SizedBox(height: 24 * scale),
                      _PhotoGrid(scale: scale),
                      SizedBox(height: 24 * scale),
                      _TipsCard(scale: scale),
                      SizedBox(height: 24 * scale),
                      _PopularSportsCard(scale: scale),
                      SizedBox(height: 24 * scale),
                      _StatsRow(scale: scale),
                      SizedBox(height: 24 * scale),
                      _RecentActivityCard(scale: scale),
                      SizedBox(height: 24 * scale),
                      _SecurityCard(scale: scale),
                      SizedBox(height: 24 * scale),
                      _CommunityRulesCard(scale: scale),
                      SizedBox(height: 24 * scale),
                      _TestimonialsCard(scale: scale),
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
          onPressed: controller.skipAddPhotos,
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF475569),
            textStyle: GoogleFonts.inter(
              fontSize: 14 * scale,
              fontWeight: FontWeight.w500,
            ),
          ),
          child: const Text('Passer'),
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
              'Étape 4 sur 5',
              style: GoogleFonts.inter(
                color: const Color(0xFF475569),
                fontSize: 14 * scale,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Text(
              '80%',
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
            value: 0.8,
            minHeight: 8 * scale,
            backgroundColor: const Color(0xFFE2E8F0),
            valueColor: const AlwaysStoppedAnimation(Color(0xFF176BFF)),
          ),
        ),
      ],
    );
  }
}

class _IntroCard extends StatelessWidget {
  const _IntroCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
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
              color: const Color(0x19176BFF),
              borderRadius: BorderRadius.circular(9999),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.photo_outlined, color: const Color(0xFF176BFF), size: 30 * scale),
          ),
          SizedBox(height: 20 * scale),
          Text(
            'Ajoutez des photos à votre profil',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: const Color(0xFF0B1220),
              fontSize: 24 * scale,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 12 * scale),
          Text(
            'Partagez qui vous êtes ! Ajoutez jusqu\'à 6 photos pour permettre aux autres sportifs de vous reconnaître.',
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

class _PhotoGrid extends GetView<RegisterController> {
  const _PhotoGrid({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final photos = controller.selectedPhotos;
        final primaryIndex = controller.primaryPhotoIndex.value;
        final maxPhotos = 6;
        final remainingSlots = maxPhotos - photos.length;
        
        final tiles = <Widget>[
          // Existing photos
          ...photos.asMap().entries.map((entry) {
            final index = entry.key;
            final photo = entry.value;
            return _PhotoTile(
              scale: scale,
              imagePath: photo.path,
              isPrimary: index == primaryIndex,
              onTap: () => controller.setPrimaryPhoto(index),
              onDelete: () => controller.removePhoto(index),
            );
          }),
          // Add photo slots
          ...List.generate(
            remainingSlots > 0 ? remainingSlots : 0,
            (index) => _AddPhotoTile(
              scale: scale,
              isHighlighted: photos.isEmpty && index == 0,
              onTap: () => _showImageSourceDialog(context),
            ),
          ),
        ];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 12 * scale,
              runSpacing: 12 * scale,
              children: tiles
                  .map(
                    (tile) => SizedBox(
                      width: (343 * scale - 24 * scale) / 3,
                      child: tile,
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 12 * scale),
            Text(
              '${photos.length} sur $maxPhotos photos ajoutées',
              style: GoogleFonts.inter(
                color: const Color(0xFF475569),
                fontSize: 14 * scale,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }

  void _showImageSourceDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24 * scale)),
        ),
        padding: EdgeInsets.all(24 * scale),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40 * scale,
              height: 4 * scale,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(2 * scale),
              ),
            ),
            SizedBox(height: 24 * scale),
            Text(
              'Choisir une photo',
              style: GoogleFonts.poppins(
                fontSize: 20 * scale,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0B1220),
              ),
            ),
            SizedBox(height: 24 * scale),
            ListTile(
              leading: Icon(Icons.photo_library_outlined, color: const Color(0xFF176BFF), size: 24 * scale),
              title: Text(
                'Galerie',
                style: GoogleFonts.inter(fontSize: 16 * scale, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.pop(context);
                controller.pickImage(source: ImageSource.gallery);
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt_outlined, color: const Color(0xFF16A34A), size: 24 * scale),
              title: Text(
                'Caméra',
                style: GoogleFonts.inter(fontSize: 16 * scale, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.pop(context);
                controller.pickImage(source: ImageSource.camera);
              },
            ),
            SizedBox(height: 16 * scale),
          ],
        ),
      ),
    );
  }
}


class _PhotoTile extends StatelessWidget {
  const _PhotoTile({
    required this.scale,
    required this.imagePath,
    required this.isPrimary,
    required this.onTap,
    required this.onDelete,
  });

  final double scale;
  final String imagePath;
  final bool isPrimary;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16 * scale),
        child: Stack(
          children: [
            Container(
              height: 108 * scale,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(File(imagePath)),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16 * scale),
                  border: Border.all(
                    color: isPrimary ? const Color(0xFF176BFF) : Colors.white.withValues(alpha: 0.3),
                    width: isPrimary ? 3 : 2,
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: isPrimary ? 0.2 : 0.3),
                      Colors.black.withValues(alpha: isPrimary ? 0.4 : 0.6),
                    ],
                  ),
                ),
              ),
            ),
            if (isPrimary)
              Positioned(
                left: 8 * scale,
                top: 8 * scale,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 4 * scale),
                  decoration: BoxDecoration(
                    color: const Color(0xFF176BFF),
                    borderRadius: BorderRadius.circular(9999),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.12),
                        blurRadius: 12 * scale,
                        offset: Offset(0, 6 * scale),
                      ),
                    ],
                  ),
                  child: Text(
                    'Principal',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 12 * scale,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            Positioned(
              right: 8 * scale,
              top: 8 * scale,
              child: GestureDetector(
                onTap: onDelete,
                child: Container(
                  width: 28 * scale,
                  height: 28 * scale,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444).withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.delete_outline_rounded, size: 16 * scale, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddPhotoTile extends StatelessWidget {
  const _AddPhotoTile({
    required this.scale,
    this.isHighlighted = false,
    required this.onTap,
  });

  final double scale;
  final bool isHighlighted;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = isHighlighted ? const Color(0xFF4E8DFB) : const Color(0xFFD1D5DB);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 108 * scale,
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: borderColor, width: isHighlighted ? 2.5 : 2),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32 * scale,
              height: 32 * scale,
              decoration: BoxDecoration(
                color: isHighlighted ? const Color(0xFF4E8DFB) : const Color(0xFFD1D5DB),
                borderRadius: BorderRadius.circular(9999),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.add_a_photo_outlined,
                size: 18 * scale,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 12 * scale),
            Text(
              'Ajouter',
              style: GoogleFonts.inter(
                color: isHighlighted ? const Color(0xFF4E8DFB) : const Color(0xFF6B7280),
                fontSize: 12 * scale,
                fontWeight: isHighlighted ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TipsCard extends StatelessWidget {
  const _TipsCard({required this.scale});

  final double scale;

  final List<String> tips = const [
    'Utilisez des photos récentes et claires',
    'Montrez votre visage distinctement',
    'Incluez des photos de vous en action sportive',
    'Évitez les photos de groupe ou floues',
  ];

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
              _CircleIcon(scale: scale, icon: Icons.lightbulb_outline, color: const Color(0xFF0EA5E9)),
              SizedBox(width: 12 * scale),
              Text(
                'Conseils pour de bonnes photos',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF0B1220),
                  fontSize: 16 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 16 * scale),
          ...tips.map((tip) => _BulletText(scale: scale, text: tip)),
        ],
      ),
    );
  }
}

class _PopularSportsCard extends StatelessWidget {
  const _PopularSportsCard({required this.scale});

  final double scale;

  final List<_SportTag> sports = const [
    _SportTag(label: 'Football', icon: Icons.sports_soccer),
    _SportTag(label: 'Basketball', icon: Icons.sports_basketball),
    _SportTag(label: 'Tennis', icon: Icons.sports_tennis),
    _SportTag(label: 'Running', icon: Icons.directions_run),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24 * scale),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
        ),
        borderRadius: BorderRadius.circular(16 * scale),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sports populaires sur Sportify',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 20 * scale),
          Wrap(
            spacing: 16 * scale,
            runSpacing: 16 * scale,
            children: sports
                .map((sport) => _SportTagChip(scale: scale, data: sport))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _SportTag {
  const _SportTag({required this.label, required this.icon});

  final String label;
  final IconData icon;
}

class _SportTagChip extends StatelessWidget {
  const _SportTagChip({required this.scale, required this.data});

  final double scale;
  final _SportTag data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 48 * scale,
          height: 48 * scale,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(9999),
          ),
          alignment: Alignment.center,
          child: Icon(data.icon, color: Colors.white, size: 22 * scale),
        ),
        SizedBox(height: 8 * scale),
        Text(
          data.label,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 12 * scale,
          ),
        ),
      ],
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.scale});

  final double scale;

  final List<_StatItem> stats = const [
    _StatItem(value: '15K+', label: 'Sportifs actifs', color: Color(0xFF176BFF)),
    _StatItem(value: '2.5K+', label: 'Matchs organisés', color: Color(0xFF16A34A)),
    _StatItem(value: '500+', label: 'Terrains partenaires', color: Color(0xFFFFB800)),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: stats
          .map(
            (stat) => Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4 * scale),
                padding: EdgeInsets.symmetric(vertical: 16 * scale),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12 * scale),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  children: [
                    Text(
                      stat.value,
                      style: GoogleFonts.poppins(
                        color: stat.color,
                        fontSize: 18 * scale,
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
    );
  }
}

class _StatItem {
  const _StatItem({required this.value, required this.label, required this.color});

  final String value;
  final String label;
  final Color color;
}

class _RecentActivityCard extends StatelessWidget {
  const _RecentActivityCard({required this.scale});

  final double scale;

  final List<_ActivityItem> activities = const [
    _ActivityItem(
      name: 'Marc a organisé un match de foot',
      subtitle: 'Terrain Municipal • Il y a 2h',
      badge: '2 places libres',
      badgeColor: Color(0xFF16A34A),
      badgeBackground: Color(0x1916A34A),
      avatarUrl: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=200&q=60',
    ),
    _ActivityItem(
      name: 'Sarah cherche un partenaire tennis',
      subtitle: 'Club Tennis Plus • Il y a 4h',
      badge: 'Niveau intermédiaire',
      badgeColor: Color(0xFFF59E0B),
      badgeBackground: Color(0x19F59E0B),
      avatarUrl: 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=200&q=60',
    ),
  ];

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _CircleIcon(scale: scale, icon: Icons.flash_on_outlined, color: const Color(0xFF176BFF)),
              SizedBox(width: 12 * scale),
              Expanded(
                child: Text(
                  'Activité récente dans votre région',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF0B1220),
                    fontSize: 16 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20 * scale),
          ...activities.map((activity) => _ActivityTile(scale: scale, data: activity)),
        ],
      ),
    );
  }
}

class _ActivityItem {
  const _ActivityItem({
    required this.name,
    required this.subtitle,
    required this.badge,
    required this.badgeColor,
    required this.badgeBackground,
    required this.avatarUrl,
  });

  final String name;
  final String subtitle;
  final String badge;
  final Color badgeColor;
  final Color badgeBackground;
  final String avatarUrl;
}

class _ActivityTile extends StatelessWidget {
  const _ActivityTile({required this.scale, required this.data});

  final double scale;
  final _ActivityItem data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16 * scale),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32 * scale,
            height: 32 * scale,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9999),
              border: Border.all(color: Colors.white, width: 1.5),
              image: DecorationImage(
                image: NetworkImage(data.avatarUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 12 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF0B1220),
                    fontSize: 14 * scale,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4 * scale),
                Text(
                  data.subtitle,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF475569),
                    fontSize: 12 * scale,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12 * scale),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 4 * scale),
            decoration: BoxDecoration(
              color: data.badgeBackground,
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Text(
              data.badge,
              style: GoogleFonts.inter(
                color: data.badgeColor,
                fontSize: 12 * scale,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SecurityCard extends StatelessWidget {
  const _SecurityCard({required this.scale});

  final double scale;

  final List<String> points = const [
    'Vos photos ne sont visibles que par les membres vérifiés',
    'Contrôlez qui peut voir votre profil dans les paramètres',
    'Système de vérification d\'identité intégré',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _CircleIcon(scale: scale, icon: Icons.verified_user_outlined, color: const Color(0xFF16A34A)),
              SizedBox(width: 12 * scale),
              Text(
                'Sécurité & Confidentialité',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF0B1220),
                  fontSize: 16 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 16 * scale),
          ...points.map((point) => _BulletText(scale: scale, text: point)),
        ],
      ),
    );
  }
}

class _CommunityRulesCard extends StatelessWidget {
  const _CommunityRulesCard({required this.scale});

  final double scale;

  final List<String> accepted = const [
    'Visage visible, photos récentes',
    'Tenue appropriée',
    'Contexte sportif',
  ];
  final List<String> refused = const [
    'Contenu inapproprié',
    'Logos ou texte promotionnel',
    'Photos d\'autres personnes',
  ];

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
          Text(
            'Règles de la communauté',
            style: GoogleFonts.poppins(
              color: const Color(0xFF0B1220),
              fontSize: 16 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 20 * scale),
          Row(
            children: [
              Expanded(
                child: _RulesColumn(
                  scale: scale,
                  title: 'Photos acceptées',
                  color: const Color(0xFF16A34A),
                  background: const Color(0x0C16A34A),
                  items: accepted,
                ),
              ),
              SizedBox(width: 16 * scale),
              Expanded(
                child: _RulesColumn(
                  scale: scale,
                  title: 'Photos refusées',
                  color: const Color(0xFFEF4444),
                  background: const Color(0x0CEF4444),
                  items: refused,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RulesColumn extends StatelessWidget {
  const _RulesColumn({
    required this.scale,
    required this.title,
    required this.color,
    required this.background,
    required this.items,
  });

  final double scale;
  final String title;
  final Color color;
  final Color background;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12 * scale),
      ),
      child: Column(
        children: [
          _CircleIcon(scale: scale, icon: Icons.check_circle_outline, color: color),
          SizedBox(height: 12 * scale),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: color,
              fontSize: 12 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12 * scale),
          ...items.map((item) => Padding(
                padding: EdgeInsets.only(bottom: 4 * scale),
                child: Text(
                  item,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF475569),
                    fontSize: 12 * scale,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

class _TestimonialsCard extends StatelessWidget {
  const _TestimonialsCard({required this.scale});

  final double scale;

  final List<_Testimonial> testimonials = const [
    _Testimonial(
      name: 'Thomas',
      quote: '"J\'ai trouvé mes partenaires de tennis réguliers grâce à Sportify. L\'app est parfaite !"',
      avatarUrl: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=200&q=60',
    ),
    _Testimonial(
      name: 'Emma',
      quote: '"Super communauté ! J\'ai participé à plus de 20 matchs depuis que je me suis inscrite."',
      avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=60',
    ),
  ];

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
              _CircleIcon(scale: scale, icon: Icons.chat_bubble_outline, color: const Color(0xFF176BFF)),
              SizedBox(width: 12 * scale),
              Text(
                'Témoignages',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF0B1220),
                  fontSize: 16 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 20 * scale),
          ...testimonials.map((testimonial) => _TestimonialTile(scale: scale, testimonial: testimonial)),
        ],
      ),
    );
  }
}

class _Testimonial {
  const _Testimonial({required this.name, required this.quote, required this.avatarUrl});

  final String name;
  final String quote;
  final String avatarUrl;
}

class _TestimonialTile extends StatelessWidget {
  const _TestimonialTile({required this.scale, required this.testimonial});

  final double scale;
  final _Testimonial testimonial;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16 * scale),
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12 * scale),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 24 * scale,
                height: 24 * scale,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9999),
                  border: Border.all(color: Colors.white, width: 1.2),
                  image: DecorationImage(
                    image: NetworkImage(testimonial.avatarUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 12 * scale),
              Text(
                testimonial.name,
                style: GoogleFonts.inter(
                  color: const Color(0xFF0B1220),
                  fontSize: 14 * scale,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 8 * scale),
          Text(
            testimonial.quote,
            style: GoogleFonts.inter(
              color: const Color(0xFF475569),
              fontSize: 12 * scale,
              height: 1.5,
            ),
          ),
        ],
      ),
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
        _ProgressDots(scale: scale, activeIndex: 3, count: 6),
        SizedBox(height: 16 * scale),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: controller.submitAddPhotos,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 18 * scale),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12 * scale),
              ),
              backgroundColor: const Color(0xFF176BFF),
            ),
            child: Text(
              'Suivant',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(height: 16 * scale),
        Text(
          'Vous pourrez modifier vos photos à tout moment dans votre profil',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: const Color(0xFF475569),
            fontSize: 12 * scale,
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

class _BulletText extends StatelessWidget {
  const _BulletText({required this.scale, required this.text});

  final double scale;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12 * scale),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6 * scale,
            height: 6 * scale,
            margin: EdgeInsets.only(top: 6 * scale),
            decoration: const BoxDecoration(
              color: Color(0xFF176BFF),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 12 * scale),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                color: const Color(0xFF475569),
                fontSize: 12 * scale,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleIcon extends StatelessWidget {
  const _CircleIcon({
    required this.scale,
    required this.icon,
    required this.color,
  });

  final double scale;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32 * scale,
      height: 32 * scale,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(9999),
      ),
      alignment: Alignment.center,
      child: Icon(icon, color: color, size: 18 * scale),
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

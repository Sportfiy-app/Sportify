import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/intro_controller.dart';

class IntroView extends GetView<IntroController> {
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          const baseWidth = 375.0;
          const baseHeight = 937.0;

          final maxWidth =
              constraints.maxWidth.isFinite
                  ? constraints.maxWidth
                  : MediaQuery.of(context).size.width;
          final maxHeight =
              constraints.maxHeight.isFinite
                  ? constraints.maxHeight
                  : MediaQuery.of(context).size.height;

          final scaleX = maxWidth / baseWidth;
          final scaleY = maxHeight / baseHeight;
          final scale = math.min(scaleX, scaleY).clamp(0.65, 1.6);

          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.35, 0.35),
                end: Alignment(1.06, -0.35),
                colors: [
                  Color(0xFFF8FAFC),
                  Color(0xFFE2E8F0),
                  Color(0xFFF1F5F9),
                ],
              ),
            ),
            child: Center(
              child: SizedBox(
                width: baseWidth * scale,
                height: baseHeight * scale,
                child: _IntroArtboard(scale: scale),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _IntroArtboard extends StatelessWidget {
  const _IntroArtboard({required this.scale});

  final double scale;

  double s(double value) => value * scale;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
          ),
        ),
        _DecorativeShapes(scale: scale),
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: s(24),
            ).copyWith(top: s(24), bottom: s(32)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _HeaderTags(scale: scale),
                SizedBox(height: s(16)),
                _LivePlayersBanner(scale: scale),
                SizedBox(height: s(32)),
                _HeroLogo(scale: scale),
                SizedBox(height: s(24)),
                _HeroCopy(scale: scale),
                SizedBox(height: s(32)),
                _FeatureHighlights(scale: scale),
                SizedBox(height: s(32)),
                _CommunityCard(scale: scale),
                SizedBox(height: s(32)),
                _CallToAction(scale: scale),
                SizedBox(height: s(16)),
                _ProgressDots(scale: scale),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HeaderTags extends StatelessWidget {
  const _HeaderTags({required this.scale});

  final double scale;

  double get chipHeight => 28 * scale;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _PillChip(
          height: chipHeight,
          padding: EdgeInsets.symmetric(
            horizontal: 12 * scale,
            vertical: 4 * scale,
          ),
          background: Colors.white.withValues(alpha: 0.9),
          borderColor: const Color(0xFFE5E7EB),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ChipIcon(size: 12 * scale, color: const Color(0xFF176BFF)),
              SizedBox(width: 6 * scale),
              Text(
                'Basketball',
                style: GoogleFonts.inter(
                  color: const Color(0xFF176BFF),
                  fontSize: 12 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8 * scale),
        _PillChip(
          height: chipHeight,
          padding: EdgeInsets.symmetric(
            horizontal: 12 * scale,
            vertical: 4 * scale,
          ),
          background: Colors.white.withValues(alpha: 0.9),
          borderColor: const Color(0xFFE5E7EB),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ChipIcon(size: 14 * scale, color: const Color(0xFF16A34A)),
              SizedBox(width: 6 * scale),
              Text(
                '5v5',
                style: GoogleFonts.inter(
                  color: const Color(0xFF16A34A),
                  fontSize: 12 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        _PillChip(
          height: chipHeight,
          padding: EdgeInsets.symmetric(
            horizontal: 12 * scale,
            vertical: 4 * scale,
          ),
          background: const Color(0xE5EF4444),
          borderColor: const Color(0xFFE5E7EB),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8 * scale,
                height: 8 * scale,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.8),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFE5E7EB),
                    width: 1 * scale,
                  ),
                ),
              ),
              SizedBox(width: 8 * scale),
              Text(
                'En direct',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 12 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HeroLogo extends StatelessWidget {
  const _HeroLogo({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64 * scale,
          height: 64 * scale,
          decoration: BoxDecoration(
            color: const Color(0xFF176BFF),
            borderRadius: BorderRadius.circular(16 * scale),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 25 * scale,
                offset: Offset(0, 20 * scale),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10 * scale,
                offset: Offset(0, 8 * scale),
              ),
            ],
          ),
          child: Center(
            child: Text(
              'S',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 28 * scale,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        SizedBox(height: 24 * scale),
        Text(
          'Sportify',
          style: GoogleFonts.poppins(
            color: const Color(0xFF0B1220),
            fontSize: 20 * scale,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5 * scale,
          ),
        ),
      ],
    );
  }
}

class _LivePlayersBanner extends StatelessWidget {
  const _LivePlayersBanner({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 225.2 * scale,
      height: 40 * scale,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(12 * scale),
        border: Border.all(
          color: const Color(0xFFE5E7EB).withValues(alpha: 0.2),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16 * scale,
        vertical: 8 * scale,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 72 * scale,
            height: 24 * scale,
            child: _OverlappingAvatars(scale: scale),
          ),
          SizedBox(width: 12 * scale),
          Expanded(
            child: Text(
              '10 joueurs actifs',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14 * scale,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OverlappingAvatars extends StatelessWidget {
  const _OverlappingAvatars({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final children = List.generate(4, (index) {
      final left = index * 16 * scale;
      return Positioned(
        left: left,
        child: CircleAvatar(
          radius: 12 * scale,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 10 * scale,
            backgroundColor: Color.lerp(
              const Color(0xFF176BFF),
              const Color(0xFFFFB800),
              index / 3,
            ),
          ),
        ),
      );
    });

    children.add(
      Positioned(
        left: 48 * scale,
        child: CircleAvatar(
          radius: 12 * scale,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 10 * scale,
            backgroundColor: const Color(0xFF176BFF),
            child: Text(
              '+7',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 12 * scale,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );

    return Stack(clipBehavior: Clip.none, children: children);
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 327 * scale,
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Trouvez des sportifs',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF0B1220),
                    fontSize: 30 * scale,
                    fontWeight: FontWeight.w700,
                    height: 1.27,
                  ),
                ),
                TextSpan(
                  text: ' motivés',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF176BFF),
                    fontSize: 30 * scale,
                    fontWeight: FontWeight.w700,
                    height: 1.27,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 16 * scale),
        SizedBox(
          width: 327 * scale,
          child: Text(
            'En un rien de temps, trouvez des coéquipiers motivés pour vos activités sportives.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF475569),
              fontSize: 16 * scale,
              fontWeight: FontWeight.w500,
              height: 1.62,
            ),
          ),
        ),
      ],
    );
  }
}

class _FeatureHighlights extends StatelessWidget {
  const _FeatureHighlights({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    const items = [
      ('Recherche rapide', Color(0x19176BFF), Icons.search),
      ('Matching intelligent', Color(0x1916A34A), Icons.auto_awesome),
      ('Communauté active', Color(0x19FFB800), Icons.groups),
    ];

    return SizedBox(
      width: 327 * scale,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
            items
                .map(
                  (item) => _FeatureCard(
                    title: item.$1,
                    background: item.$2,
                    icon: item.$3,
                    scale: scale,
                  ),
                )
                .toList(),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.title,
    required this.background,
    required this.icon,
    required this.scale,
  });

  final String title;
  final Color background;
  final IconData icon;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 98.33 * scale,
      child: Column(
        children: [
          Container(
            width: 48 * scale,
            height: 48 * scale,
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(12 * scale),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Icon(icon, size: 24 * scale, color: const Color(0xFF0B1220)),
          ),
          SizedBox(height: 12 * scale),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF475569),
              fontSize: 12 * scale,
              fontWeight: FontWeight.w500,
              height: 1.33,
            ),
          ),
        ],
      ),
    );
  }
}

class _CommunityCard extends StatelessWidget {
  const _CommunityCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327 * scale,
      padding: EdgeInsets.symmetric(
        horizontal: 24 * scale,
        vertical: 24 * scale,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 60 * scale,
            offset: Offset(20 * scale, 20 * scale),
          ),
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.8),
            blurRadius: 60 * scale,
            offset: Offset(-20 * scale, -20 * scale),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              _AvatarStack(scale: scale),
              const Spacer(),
              _StarRating(scale: scale),
            ],
          ),
          SizedBox(height: 16 * scale),
          Text(
            '+10,000 sportifs actifs',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF0B1220),
              fontSize: 14 * scale,
              fontWeight: FontWeight.w600,
              height: 1.43,
            ),
          ),
          SizedBox(height: 12 * scale),
          Text(
            '"L\'app parfaite pour trouver des partenaires de sport !"',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF475569),
              fontSize: 12 * scale,
              fontWeight: FontWeight.w400,
              height: 1.33,
            ),
          ),
          SizedBox(height: 24 * scale),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _StatCounter(
                label: 'Matchs/mois',
                value: '2.5k',
                color: const Color(0xFF176BFF),
                scale: scale,
              ),
              _StatCounter(
                label: 'Sports',
                value: '15+',
                color: const Color(0xFF16A34A),
                scale: scale,
              ),
              _StatCounter(
                label: 'Note app',
                value: '4.8',
                color: const Color(0xFFFFB800),
                scale: scale,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AvatarStack extends StatelessWidget {
  const _AvatarStack({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final avatars = List.generate(
      4,
      (index) => Positioned(
        left: index * 20 * scale,
        child: CircleAvatar(
          radius: 16 * scale,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 14 * scale,
            backgroundColor: Color.lerp(
              const Color(0xFF176BFF),
              const Color(0xFF16A34A),
              index / 3,
            ),
          ),
        ),
      ),
    );

    return SizedBox(
      width: 140 * scale,
      height: 32 * scale,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ...avatars,
          Positioned(
            left: 80 * scale,
            child: CircleAvatar(
              radius: 16 * scale,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 14 * scale,
                backgroundColor: const Color(0xFF176BFF),
                child: Text(
                  '+7',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 12 * scale,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StarRating extends StatelessWidget {
  const _StarRating({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) => Padding(
          padding: EdgeInsets.only(left: index == 0 ? 0 : 4 * scale),
          child: Icon(
            Icons.star_rounded,
            size: 18 * scale,
            color: const Color(0xFFFFB800),
          ),
        ),
      ),
    );
  }
}

class _StatCounter extends StatelessWidget {
  const _StatCounter({
    required this.label,
    required this.value,
    required this.color,
    required this.scale,
  });

  final String label;
  final String value;
  final Color color;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 82.33 * scale,
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.poppins(
              color: color,
              fontSize: 18 * scale,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4 * scale),
          Text(
            label,
            style: GoogleFonts.inter(
              color: const Color(0xFF475569),
              fontSize: 12 * scale,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class _CallToAction extends StatelessWidget {
  const _CallToAction({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<IntroController>();

    return Container(
      width: 327 * scale,
      padding: EdgeInsets.symmetric(vertical: 16 * scale),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Column(
        children: [
          GestureDetector(
            onTap: controller.onGetStarted,
            child: Container(
              height: 60 * scale,
              decoration: BoxDecoration(
                color: const Color(0xFF176BFF),
                borderRadius: BorderRadius.circular(16 * scale),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 15 * scale,
                    offset: Offset(0, 10 * scale),
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 6 * scale,
                    offset: Offset(0, 4 * scale),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "C'est parti",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18 * scale,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 12 * scale),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                    size: 20 * scale,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16 * scale),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: controller.onLearnMore,
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: const Color(0xFF475569),
                      size: 16 * scale,
                    ),
                    SizedBox(width: 8 * scale),
                    Text(
                      'En savoir plus',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF475569),
                        fontSize: 14 * scale,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1 * scale,
                height: 16 * scale,
                margin: EdgeInsets.symmetric(horizontal: 24 * scale),
                color: const Color(0xFFE2E8F0),
              ),
              GestureDetector(
                onTap: controller.onAlreadyMember,
                child: Row(
                  children: [
                    Icon(
                      Icons.lock_outline,
                      color: const Color(0xFF475569),
                      size: 16 * scale,
                    ),
                    SizedBox(width: 8 * scale),
                    Text(
                      'Déjà membre ?',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF475569),
                        fontSize: 14 * scale,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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

class _ProgressDots extends StatelessWidget {
  const _ProgressDots({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80 * scale,
      height: 4 * scale,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(999 * scale),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF176BFF),
                borderRadius: BorderRadius.circular(999 * scale),
              ),
            ),
          ),
          SizedBox(width: 8 * scale),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(999 * scale),
              ),
            ),
          ),
          SizedBox(width: 8 * scale),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(999 * scale),
              ),
            ),
          ),
          SizedBox(width: 8 * scale),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(999 * scale),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DecorativeShapes extends StatelessWidget {
  const _DecorativeShapes({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    Positioned circle(double left, double top, double size, Color color) {
      return Positioned(
        left: left * scale,
        top: top * scale,
        child: Container(
          width: size * scale,
          height: size * scale,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
        ),
      );
    }

    return Stack(
      children: [
        circle(24, 64, 48, const Color(0x19176BFF)),
        circle(303, 122, 41, const Color(0x26FFB800)),
        circle(47, 248, 33, const Color(0x3316A34A)),
        circle(287, 174, 24, const Color(0x33176BFF)),
        circle(31, 634, 41, const Color(0x26F59E0B)),
        circle(270, 719, 56, const Color(0x190EA5E9)),
        circle(64, 705, 16, const Color(0x3FFFB800)),
        circle(80, 313, 12, const Color(0x4C16A34A)),
      ],
    );
  }
}

class _PillChip extends StatelessWidget {
  const _PillChip({
    required this.background,
    required this.borderColor,
    required this.child,
    required this.height,
    required this.padding,
  });

  final Color background;
  final Color borderColor;
  final Widget child;
  final double height;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: borderColor),
      ),
      child: Center(child: child),
    );
  }
}

class _ChipIcon extends StatelessWidget {
  const _ChipIcon({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
    );
  }
}

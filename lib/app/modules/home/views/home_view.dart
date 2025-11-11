import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          const baseWidth = 375.0;
          const baseHeight = 812.0;

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
          final scale = math.min(scaleX, scaleY).clamp(0.7, 1.8);

          final width = baseWidth * scale;
          final height = baseHeight * scale;

          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.35, 0.35),
                end: Alignment(1.06, -0.35),
                colors: [
                  Color(0xFFF6F8FB),
                  Color(0xFFFDFDFD),
                  Color(0xFFFDFDFD),
                ],
              ),
            ),
            child: Center(
              child: SizedBox(
                width: width,
                height: height,
                child: _HomeArtboard(scale: scale),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _HomeArtboard extends StatelessWidget {
  const _HomeArtboard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _LogoCluster(scale: scale),
        _TitleSection(scale: scale),
        _QuickActions(scale: scale),
        _CallToAction(scale: scale),
        _VersionBadge(scale: scale),
      ],
    );
  }
}

class _LogoCluster extends StatelessWidget {
  const _LogoCluster({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset(0.5, 0.34),
      child: SizedBox(
        width: 106.25 * scale,
        height: 106.25 * scale,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0x33D3CFF7),
                border: Border.all(
                  color: const Color(0xFFB0C1E2),
                  width: 2 * scale,
                ),
              ),
            ),
            Positioned(
              left: 5.13 * scale,
              top: 5.13 * scale,
              child: Container(
                width: 96 * scale,
                height: 96 * scale,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.95),
                  border: Border.all(
                    color: const Color(0xFFE5E7EB),
                    width: 1.5 * scale,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      blurRadius: 50 * scale,
                      offset: Offset(0, 25 * scale),
                    ),
                  ],
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: 33.23 * scale,
                      top: 24 * scale,
                      child: SizedBox(
                        width: 30 * scale,
                        height: 48 * scale,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 2 * scale,
                              top: 2 * scale,
                              child: Text(
                                'S',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF0F5AE0),
                                  fontSize: 48 * scale,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Text(
                              'S',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF176BFF),
                                fontSize: 48 * scale,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: -8 * scale,
                      top: -8 * scale,
                      child: _AccentDot(
                        size: 24 * scale,
                        color: const Color(0xFFFFB800),
                        borderWidth: 1.5 * scale,
                      ),
                    ),
                    Positioned(
                      left: -8 * scale,
                      bottom: -8 * scale,
                      child: _AccentDot(
                        size: 24 * scale,
                        color: const Color(0xFF16A34A),
                        borderWidth: 1.5 * scale,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AccentDot extends StatelessWidget {
  const _AccentDot({
    required this.size,
    required this.color,
    required this.borderWidth,
  });

  final double size;
  final Color color;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.6),
          width: borderWidth,
        ),
      ),
    );
  }
}

class _TitleSection extends StatelessWidget {
  const _TitleSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset(0.5, 0.52),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Sportify',
            style: GoogleFonts.poppins(
              color: const Color(0xFF1362EE),
              fontSize: 36 * scale,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.9 * scale,
              height: 1.11,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12 * scale),
          Text(
            'Votre sport, votre communauté',
            style: GoogleFonts.inter(
              color: const Color(0xFF176BFF),
              fontSize: 18 * scale,
              fontWeight: FontWeight.w500,
              height: 1.56,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset(0.5, 0.84),
      child: Opacity(
        opacity: 0.9,
        child: SizedBox(
          width: 280 * scale,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _QuickAction(
                icon: Icons.calendar_today_outlined,
                label: 'Réserver',
                scale: scale,
                onTap:
                    () => Get.find<HomeController>().onQuickActionTap(
                      HomeQuickActionType.book,
                    ),
              ),
              _QuickAction(
                icon: Icons.groups_outlined,
                label: 'Rencontrer',
                scale: scale,
                onTap:
                    () => Get.find<HomeController>().onQuickActionTap(
                      HomeQuickActionType.meet,
                    ),
              ),
              _QuickAction(
                icon: Icons.sports_soccer_outlined,
                label: 'Jouer',
                scale: scale,
                onTap:
                    () => Get.find<HomeController>().onQuickActionTap(
                      HomeQuickActionType.play,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.scale,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final double scale;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final iconColor = const Color(0xFF176BFF);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 40 * scale,
            height: 40 * scale,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.6),
              border: Border.all(
                color: const Color(0xFFE5E7EB),
                width: 1 * scale,
              ),
            ),
            child: Icon(icon, size: 20 * scale, color: iconColor),
          ),
        ),
        SizedBox(height: 12 * scale),
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF176BFF),
            fontSize: 12 * scale,
            fontWeight: FontWeight.w500,
            height: 1.33,
          ),
        ),
      ],
    );
  }
}

class _CallToAction extends StatelessWidget {
  const _CallToAction({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Align(
      alignment: FractionalOffset(0.5, 0.72),
      child: SizedBox(
        width: 327 * scale,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: controller.onGetStarted,
              child: Container(
                height: 60 * scale,
                decoration: BoxDecoration(
                  color: const Color(0xFF176BFF),
                  borderRadius: BorderRadius.circular(16 * scale),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x19000000),
                      blurRadius: 15,
                      offset: Offset(0, 10),
                    ),
                    BoxShadow(
                      color: Color(0x19000000),
                      blurRadius: 6,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32 * scale),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        HomeController.ctaLabel,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 18 * scale,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 12 * scale),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 20 * scale,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16 * scale),
            Text(
              'Découvrez des partenaires proches de vous',
              style: GoogleFonts.inter(
                color: const Color(0xFF64748B),
                fontSize: 14 * scale,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _VersionBadge extends StatelessWidget {
  const _VersionBadge({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset(0.5, 0.94),
      child: Text(
        HomeController.versionLabel,
        style: GoogleFonts.inter(
          color: const Color(0xFF94A3B8),
          fontSize: 12 * scale,
          fontWeight: FontWeight.w400,
          height: 1.33,
        ),
      ),
    );
  }
}

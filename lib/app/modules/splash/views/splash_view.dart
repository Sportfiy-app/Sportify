import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

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

          return DecoratedBox(
            decoration: const BoxDecoration(color: Color(0xFF0B1F3A)),
            child: Center(
              child: SizedBox(
                width: width,
                height: height,
                child: _SplashArtboard(scale: scale),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SplashArtboard extends StatelessWidget {
  const _SplashArtboard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.35, 0.35),
          end: Alignment(1.06, -0.35),
          colors: [Color(0xFF176BFF), Color(0xFF0F5AE0), Color(0xFF176BFF)],
        ),
      ),
      child: Stack(
        children: [
          _BackgroundShapes(scale: scale),
          _LogoSection(scale: scale),
          _TitleSection(scale: scale),
          _LoadingSection(scale: scale),
          _QuickActions(scale: scale),
          _VersionBadge(scale: scale),
        ],
      ),
    );
  }
}

class _BackgroundShapes extends StatelessWidget {
  const _BackgroundShapes({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _circle(
          left: 31.56,
          top: 83.55,
          size: 64.89,
          color: Colors.white.withValues(alpha: 0.1),
        ),
        _circle(
          left: 278.43,
          top: 120.49,
          size: 49.15,
          color: const Color(0xFFFFB800).withValues(alpha: 0.2),
        ),
        _circle(
          left: 63.49,
          top: 246.17,
          size: 33.02,
          color: Colors.white.withValues(alpha: 0.15),
        ),
        _circle(
          left: 262.91,
          top: 571.30,
          size: 80.17,
          color: Colors.white.withValues(alpha: 0.05),
        ),
        _circle(
          left: 47.06,
          top: 489.23,
          size: 57.89,
          color: const Color(0xFFFFB800).withValues(alpha: 0.1),
        ),
        _circle(
          left: 270.82,
          top: 171.56,
          size: 24.35,
          color: Colors.white.withValues(alpha: 0.2),
          borderOpacity: 0.3,
        ),
        _circle(
          left: 79.77,
          top: 579.25,
          size: 16.47,
          color: const Color(0xFFFFB800).withValues(alpha: 0.25),
          borderOpacity: 0.5,
        ),
      ],
    );
  }

  Positioned _circle({
    required double left,
    required double top,
    required double size,
    required Color color,
    double borderOpacity = 0.2,
  }) {
    return Positioned(
      left: left * scale,
      top: top * scale,
      width: size * scale,
      height: size * scale,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(
            color: Colors.white.withValues(alpha: borderOpacity),
            width: 1.5 * scale,
          ),
        ),
      ),
    );
  }
}

class _LogoSection extends StatelessWidget {
  const _LogoSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset(0.5, 0.34),
      child: SizedBox(
        width: 96 * scale,
        height: 96 * scale,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.95),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 50 * scale,
                    offset: Offset(0, 25 * scale),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'S',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF176BFF),
                    fontSize: 48 * scale,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Positioned(
              right: -8 * scale,
              top: -8 * scale,
              child: _accentDot(
                size: 24 * scale,
                color: const Color(0xFFFFB800),
                borderWidth: 2 * scale,
              ),
            ),
            Positioned(
              left: -8 * scale,
              bottom: -8 * scale,
              child: _accentDot(
                size: 24 * scale,
                color: const Color(0xFF16A34A),
                borderWidth: 2 * scale,
              ),
            ),
            Positioned.fill(
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                      width: 5 * scale,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _accentDot({
    required double size,
    required Color color,
    required double borderWidth,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.5),
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
              color: Colors.white,
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
              color: Colors.white.withValues(alpha: 0.9),
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

class _LoadingSection extends StatelessWidget {
  const _LoadingSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset(0.5, 0.66),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 96 * scale,
            height: 84 * scale,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 48 * scale,
                  width: 48 * scale,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4 * scale,
                            color: Colors.white.withValues(alpha: 0.3),
                          ),
                        ),
                      ),
                      Container(
                        width: 67 * scale,
                        height: 67 * scale,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4 * scale,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16 * scale),
                Text(
                  'Chargement...',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 14 * scale,
                    fontWeight: FontWeight.w500,
                    height: 1.43,
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

class _QuickActions extends StatelessWidget {
  const _QuickActions({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset(0.5, 0.84),
      child: SizedBox(
        width: 280 * scale,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _QuickAction(
              icon: Icons.calendar_today_outlined,
              label: 'Réserver',
              scale: scale,
            ),
            _QuickAction(
              icon: Icons.groups_outlined,
              label: 'Rencontrer',
              scale: scale,
            ),
            _QuickAction(
              icon: Icons.sports_soccer_outlined,
              label: 'Jouer',
              scale: scale,
            ),
          ],
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
  });

  final IconData icon;
  final String label;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40 * scale,
          height: 40 * scale,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.2),
            border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
          ),
          child: Icon(
            icon,
            size: 20 * scale,
            color: Colors.white.withValues(alpha: 0.85),
          ),
        ),
        SizedBox(height: 12 * scale),
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 12 * scale,
            fontWeight: FontWeight.w400,
            height: 1.33,
          ),
        ),
      ],
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
        'Version 1.0.0',
        style: GoogleFonts.inter(
          color: Colors.white.withValues(alpha: 0.5),
          fontSize: 12 * scale,
          fontWeight: FontWeight.w400,
          height: 1.33,
        ),
      ),
    );
  }
}

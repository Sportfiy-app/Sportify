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
          CustomPaint(
            size: Size.square(86 * scale),
            painter: _LoadingRingPainter(scale: scale),
          ),
          SizedBox(height: 18 * scale),
          Text(
            'Chargement...',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 14 * scale,
              fontWeight: FontWeight.w600,
              height: 1.43,
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
            gradient: const LinearGradient(
              colors: [Color(0xFFE6F0FF), Color(0xFFFFFFFF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.35),
              width: 1.2 * scale,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 20 * scale,
                offset: Offset(0, 12 * scale),
              ),
            ],
          ),
          child: Icon(
            icon,
            size: 20 * scale,
            color: const Color(0xFF176BFF),
          ),
        ),
        SizedBox(height: 12 * scale),
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white.withValues(alpha: 0.85),
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
          color: Colors.white.withValues(alpha: 0.6),
          fontSize: 12 * scale,
          fontWeight: FontWeight.w400,
          height: 1.33,
        ),
      ),
    );
  }
}

class _LoadingRingPainter extends CustomPainter {
  const _LoadingRingPainter({required this.scale});

  final double scale;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final outerRadius = size.width / 2;
    final innerRadius = outerRadius * 0.58;

    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.white.withValues(alpha: 0.6),
          Colors.white.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: outerRadius))
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 24 * scale);
    canvas.drawCircle(center, outerRadius * 0.9, glowPaint);

    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6 * scale
      ..shader = SweepGradient(
        startAngle: -math.pi / 2,
        endAngle: 1.5 * math.pi,
        colors: [
          Colors.white.withValues(alpha: 0.15),
          Colors.white,
          Colors.white.withValues(alpha: 0.15),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: outerRadius));
    canvas.drawCircle(center, outerRadius - 6 * scale, ringPaint);

    final innerPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2 * scale
      ..color = Colors.white.withValues(alpha: 0.25);
    canvas.drawCircle(center, innerRadius, innerPaint);

    final indicatorPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final indicatorAngle =
        (DateTime.now().millisecondsSinceEpoch % 4000) / 4000 * 2 * math.pi;
    final indicatorOffset = Offset(
      center.dx + (outerRadius - 8 * scale) * math.cos(indicatorAngle),
      center.dy + (outerRadius - 8 * scale) * math.sin(indicatorAngle),
    );
    canvas.drawCircle(indicatorOffset, 4.5 * scale, indicatorPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

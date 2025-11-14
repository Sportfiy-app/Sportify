import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingLoadingView extends StatefulWidget {
  const BookingLoadingView({super.key});

  @override
  State<BookingLoadingView> createState() => _BookingLoadingViewState();
}

class _BookingLoadingViewState extends State<BookingLoadingView> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const designWidth = 375.0;
          final width = constraints.maxWidth.isFinite ? constraints.maxWidth : MediaQuery.of(context).size.width;
          final scale = (width / designWidth).clamp(0.9, 1.12);
          final mediaPadding = MediaQuery.of(context).padding;

          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24 * scale).copyWith(top: mediaPadding.top + 24 * scale),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _TopBar(scale: scale),
                  SizedBox(height: 48 * scale),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 16 * scale),
                        _Spinner(controller: _controller, scale: scale),
                        SizedBox(height: 28 * scale),
                        Text(
                          'Interface de réservation…',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF0B1220),
                            fontSize: 20 * scale,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8 * scale),
                        Text(
                          'Préparation de votre créneau',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF475569),
                            fontSize: 14 * scale,
                          ),
                        ),
                        SizedBox(height: 32 * scale),
                        _ProgressBar(scale: scale),
                        SizedBox(height: 48 * scale),
                        _SkeletonSlots(scale: scale),
                      ],
                    ),
                  ),
                  SizedBox(height: 56 * scale),
                  _BottomTips(scale: scale),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CircleButton(
          scale: scale,
          icon: Icons.arrow_back_ios_new_rounded,
          onTap: Navigator.of(context).maybePop,
        ),
        const Spacer(),
        Column(
          children: [
            Text(
              'Réservation',
              style: GoogleFonts.poppins(
                color: const Color(0xFF0B1220),
                fontSize: 18 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4 * scale),
            Text(
              'Terrain de football',
              style: GoogleFonts.inter(
                color: const Color(0xFF475569),
                fontSize: 12 * scale,
              ),
            ),
          ],
        ),
        const Spacer(),
        _CircleButton(
          scale: scale,
          icon: Icons.info_outline_rounded,
          onTap: () {},
        ),
      ],
    );
  }
}

class _Spinner extends StatelessWidget {
  const _Spinner({required this.controller, required this.scale});

  final AnimationController controller;
  final double scale;

  @override
  Widget build(BuildContext context) {
    final size = 96.0 * scale;
    return SizedBox(
      width: size,
      height: size,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: controller.value * 2 * math.pi,
            child: CustomPaint(
              painter: _SpinnerPainter(scale: scale),
            ),
          );
        },
      ),
    );
  }
}

class _SpinnerPainter extends CustomPainter {
  _SpinnerPainter({required this.scale});

  final double scale;

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 6.0 * scale;
    final rect = Offset.zero & size;
    final startAngle = -math.pi / 2;
    final sweepAngle = 1.5 * math.pi;

    final backgroundPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFFE2E8F0);

    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        startAngle: 0,
        endAngle: 2 * math.pi,
        colors: const [Color(0xFF176BFF), Color(0xFF0F5AE0)],
      ).createShader(rect);

    final center = size.center(Offset.zero);
    final radius = (size.shortestSide - strokeWidth) / 2;
    canvas.drawCircle(center, radius, backgroundPaint);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999 * scale),
      child: LinearProgressIndicator(
        minHeight: 6 * scale,
        backgroundColor: const Color(0xFFE2E8F0),
        valueColor: const AlwaysStoppedAnimation(Color(0xFF176BFF)),
      ),
    );
  }
}

class _SkeletonSlots extends StatefulWidget {
  const _SkeletonSlots({required this.scale});

  final double scale;

  @override
  State<_SkeletonSlots> createState() => _SkeletonSlotsState();
}

class _SkeletonSlotsState extends State<_SkeletonSlots> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scale = widget.scale;
    final cards = List.generate(3, (index) => index);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Préparation des créneaux',
          style: GoogleFonts.poppins(
            color: const Color(0xFF0B1220),
            fontSize: 16 * scale,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16 * scale),
        Column(
          children: cards
              .map(
                (index) => Padding(
                  padding: EdgeInsets.only(bottom: index == cards.length - 1 ? 0 : 12 * scale),
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return _SkeletonCard(scale: scale, shimmer: _controller.value);
                    },
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _SkeletonCard extends StatelessWidget {
  const _SkeletonCard({required this.scale, required this.shimmer});

  final double scale;
  final double shimmer;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60 * scale,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(16 * scale),
      ),
      padding: EdgeInsets.symmetric(horizontal: 18 * scale, vertical: 12 * scale),
      child: Row(
        children: [
          _ShimmerBlock(width: 52 * scale, height: 36 * scale, shimmer: shimmer),
          SizedBox(width: 16 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ShimmerBlock(width: 140 * scale, height: 12 * scale, shimmer: shimmer),
                SizedBox(height: 8 * scale),
                _ShimmerBlock(width: 92 * scale, height: 10 * scale, shimmer: shimmer),
              ],
            ),
          ),
          SizedBox(width: 12 * scale),
          _ShimmerBlock(width: 64 * scale, height: 20 * scale, shimmer: shimmer, borderRadius: 999 * scale),
        ],
      ),
    );
  }
}

class _ShimmerBlock extends StatelessWidget {
  const _ShimmerBlock({
    required this.width,
    required this.height,
    required this.shimmer,
    this.borderRadius,
  });

  final double width;
  final double height;
  final double shimmer;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final baseColor = const Color(0xFFE2E8F0);
    final highlight = const Color(0xFFF8FAFC);
    final lerpColor = Color.lerp(baseColor, highlight, 0.5 + (shimmer - 0.5).abs())!;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: lerpColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 12),
      ),
    );
  }
}

class _BottomTips extends StatelessWidget {
  const _BottomTips({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            _AssuranceChip(icon: Icons.verified_user_rounded, label: 'Certifié'),
            _AssuranceChip(icon: Icons.access_time_rounded, label: '24h/24'),
            _AssuranceChip(icon: Icons.support_agent_rounded, label: 'Support'),
          ],
        ),
        SizedBox(height: 12 * scale),
        Text(
          'Connexion sécurisée SSL • Données protégées',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: const Color(0xFF94A3B8),
            fontSize: 12 * scale,
          ),
        ),
      ],
    );
  }
}

class _AssuranceChip extends StatelessWidget {
  const _AssuranceChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF176BFF), size: 16),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
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
        width: 44 * scale,
        height: 44 * scale,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(999 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 12 * scale, offset: Offset(0, 6 * scale)),
          ],
        ),
        alignment: Alignment.center,
        child: Icon(icon, size: 18 * scale, color: const Color(0xFF0B1220)),
      ),
    );
  }
}

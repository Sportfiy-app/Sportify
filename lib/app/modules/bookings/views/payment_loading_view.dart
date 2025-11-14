import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentLoadingView extends StatefulWidget {
  const PaymentLoadingView({super.key});

  @override
  State<PaymentLoadingView> createState() => _PaymentLoadingViewState();
}

class _PaymentLoadingViewState extends State<PaymentLoadingView> with SingleTickerProviderStateMixin {
  late final AnimationController _rotationController;
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400))..repeat();
    _pulseController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2200))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          const designWidth = 375.0;
          final width = constraints.maxWidth.isFinite ? constraints.maxWidth : MediaQuery.of(context).size.width;
          final scale = (width / designWidth).clamp(0.9, 1.15);
          final padding = MediaQuery.of(context).padding;

          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24 * scale).copyWith(top: padding.top + 24 * scale, bottom: padding.bottom + 24 * scale),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _TopBar(scale: scale),
                  SizedBox(height: 60 * scale),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _AnimatedSpinner(rotationController: _rotationController, pulseController: _pulseController, scale: scale),
                        SizedBox(height: 32 * scale),
                        Text(
                          'Interface paiement…',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 22 * scale,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.2,
                          ),
                        ),
                        SizedBox(height: 12 * scale),
                        Text(
                          'Chargement de Stripe',
                          style: GoogleFonts.inter(
                            color: Colors.white70,
                            fontSize: 14 * scale,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 36 * scale),
                        _ProgressDots(scale: scale, controller: _pulseController),
                        SizedBox(height: 48 * scale),
                        _SecureBadge(scale: scale),
                      ],
                    ),
                  ),
                  _BottomInfo(scale: scale),
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
        _TopButton(
          scale: scale,
          icon: Icons.close_rounded,
          onTap: Navigator.of(context).maybePop,
        ),
        const Spacer(),
        Column(
          children: [
            Text(
              'Paiement sécurisé',
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 16 * scale, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 4 * scale),
            Text(
              'Ne fermez pas cette fenêtre',
              style: GoogleFonts.inter(color: Colors.white54, fontSize: 12 * scale),
            ),
          ],
        ),
        const Spacer(),
        _TopButton(
          scale: scale,
          icon: Icons.lock_outline_rounded,
          onTap: () {},
        ),
      ],
    );
  }
}

class _AnimatedSpinner extends StatelessWidget {
  const _AnimatedSpinner({
    required this.rotationController,
    required this.pulseController,
    required this.scale,
  });

  final AnimationController rotationController;
  final AnimationController pulseController;
  final double scale;

  @override
  Widget build(BuildContext context) {
    final size = 128.0 * scale;
    return AnimatedBuilder(
      animation: pulseController,
      builder: (context, child) {
        final pulse = 1 + (pulseController.value * 0.08);
        return Transform.scale(
          scale: pulse,
          child: SizedBox(
            width: size,
            height: size,
            child: Stack(
              alignment: Alignment.center,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: const RadialGradient(colors: [Color(0x33176BFF), Colors.transparent], radius: 0.85),
                    shape: BoxShape.circle,
                  ),
                  child: const SizedBox.expand(),
                ),
                AnimatedBuilder(
                  animation: rotationController,
                  builder: (context, _) {
                    return Transform.rotate(
                      angle: rotationController.value * 2 * math.pi,
                      child: CustomPaint(
                        painter: _SpinnerPainter(scale: scale),
                        size: Size(size, size),
                      ),
                    );
                  },
                ),
                Container(
                  width: 58 * scale,
                  height: 58 * scale,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(14 * scale),
                    border: Border.all(color: Colors.white24),
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.credit_card_rounded, color: Colors.white, size: 28 * scale),
                ),
              ],
            ),
          ),
        );
      },
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
    final backgroundPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = Colors.white12;

    final sweepPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        startAngle: 0,
        endAngle: 2 * math.pi,
        colors: const [Color(0xFF176BFF), Color(0xFF7C3AED), Color(0xFF176BFF)],
        stops: const [0.0, 0.6, 1.0],
      ).createShader(rect);

    final center = size.center(Offset.zero);
    final radius = (size.shortestSide - strokeWidth) / 2;
    canvas.drawCircle(center, radius, backgroundPaint);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -math.pi / 2, 1.8 * math.pi, false, sweepPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _ProgressDots extends StatelessWidget {
  const _ProgressDots({required this.scale, required this.controller});

  final double scale;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 12 * scale,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(5, (index) {
              final progress = (controller.value + index * 0.2) % 1.0;
              final active = progress > 0.3 && progress < 0.8;
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 4 * scale),
                width: active ? 18 * scale : 8 * scale,
                height: 8 * scale,
                decoration: BoxDecoration(
                  color: active ? Colors.white : Colors.white24,
                  borderRadius: BorderRadius.circular(999 * scale),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

class _SecureBadge extends StatelessWidget {
  const _SecureBadge({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14 * scale, vertical: 10 * scale),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12 * scale),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.shield_rounded, color: Colors.white, size: 16 * scale),
          SizedBox(width: 8 * scale),
          Text(
            'Authentification sécurisée',
            style: GoogleFonts.inter(color: Colors.white, fontSize: 12.5 * scale, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _BottomInfo extends StatelessWidget {
  const _BottomInfo({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(color: Colors.white10, height: 32 * scale),
        SizedBox(height: 8 * scale),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            _FooterChip(icon: Icons.verified_user_rounded, label: 'Paiement protégé'),
            _FooterChip(icon: Icons.support_agent_rounded, label: 'Support 24h/24'),
            _FooterChip(icon: Icons.receipt_long_rounded, label: 'Facture instantanée'),
          ],
        ),
        SizedBox(height: 16 * scale),
        Text(
          'Chargement Stripe… Merci de patienter',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(color: Colors.white38, fontSize: 12 * scale),
        ),
      ],
    );
  }
}

class _FooterChip extends StatelessWidget {
  const _FooterChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white54, size: 14),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.inter(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class _TopButton extends StatelessWidget {
  const _TopButton({required this.scale, required this.icon, required this.onTap});

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
          color: Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14 * scale),
          border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: Colors.white, size: 18 * scale),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/report_confirmation_controller.dart';

class ReportConfirmationView extends GetView<ReportConfirmationController> {
  const ReportConfirmationView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7FAFF),
        body: LayoutBuilder(
          builder: (context, constraints) {
            const designWidth = 375.0;
            final width = constraints.maxWidth.isFinite ? constraints.maxWidth : MediaQuery.of(context).size.width;
            final scale = (width / designWidth).clamp(0.88, 1.1);

            return SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 32 * scale),
                child: Column(
                  children: [
                    _AnimatedCheck(scale: scale),
                    SizedBox(height: 32 * scale),
                    Text(
                      controller.title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF0B1220),
                        fontSize: 28 * scale,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 12 * scale),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                      child: Text(
                        controller.message,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF475569),
                          fontSize: 16 * scale,
                          height: 1.6,
                        ),
                      ),
                    ),
                    if (controller.reference != null) ...[
                      SizedBox(height: 20 * scale),
                      _ReferenceCard(scale: scale, reference: controller.reference!),
                    ],
                    if (controller.emailNotice != null) ...[
                      SizedBox(height: 16 * scale),
                      _EmailNotice(scale: scale, notice: controller.emailNotice!),
                    ],
                    if (controller.steps.isNotEmpty) ...[
                      SizedBox(height: 24 * scale),
                      _StepsList(scale: scale, steps: controller.steps),
                    ],
                    if (controller.actions.isNotEmpty) ...[
                      SizedBox(height: 24 * scale),
                      _ActionList(scale: scale, actions: controller.actions),
                    ],
                    SizedBox(height: 28 * scale),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: controller.closeConfirmation,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16 * scale),
                          backgroundColor: const Color(0xFF176BFF),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16 * scale)),
                        ),
                        child: Text('Terminer', style: GoogleFonts.poppins(fontSize: 16 * scale, fontWeight: FontWeight.w600)),
                      ),
                    ),
                    if (controller.autoRedirect && controller.countdownSeconds > 0) ...[
                      SizedBox(height: 18 * scale),
                      Obx(
                        () => Text(
                          'Retour automatique dans ${controller.countdown.value}s',
                          style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 13 * scale),
                        ),
                      ),
                    ],
                    SizedBox(height: 16 * scale),
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

class _AnimatedCheck extends GetView<ReportConfirmationController> {
  const _AnimatedCheck({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final animating = controller.isAnimating.value;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutBack,
          width: animating ? 140 * scale : 120 * scale,
          height: animating ? 140 * scale : 120 * scale,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)], begin: Alignment.topLeft, end: Alignment.bottomRight),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: const Color(0xFF176BFF).withValues(alpha: 0.35), blurRadius: 30 * scale, offset: Offset(0, 18 * scale)),
            ],
          ),
          child: Center(
            child: AnimatedScale(
              duration: const Duration(milliseconds: 400),
              scale: animating ? 1.1 : 1.0,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: animating ? 0.8 : 1,
                child: const Icon(Icons.check_rounded, color: Colors.white, size: 48),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ReferenceCard extends StatelessWidget {
  const _ReferenceCard({required this.scale, required this.reference});

  final double scale;
  final String reference;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 16 * scale, offset: Offset(0, 10 * scale)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40 * scale,
            height: 40 * scale,
            decoration: BoxDecoration(
              color: const Color(0x19176BFF),
              borderRadius: BorderRadius.circular(12 * scale),
            ),
            child: Icon(Icons.confirmation_number_outlined, color: const Color(0xFF176BFF), size: 20 * scale),
          ),
          SizedBox(width: 12 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Numéro de référence',
                  style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12.5 * scale, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 4 * scale),
                Text(
                  reference,
                  style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.copy_rounded, size: 18 * scale, color: const Color(0xFF475569)),
            onPressed: () {
              Get.snackbar('Copié', 'Référence copiée dans le presse-papiers.');
            },
          ),
        ],
      ),
    );
  }
}

class _EmailNotice extends StatelessWidget {
  const _EmailNotice({required this.scale, required this.notice});

  final double scale;
  final String notice;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: const Color(0x0C0EA5E9),
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0x330EA5E9)),
      ),
      child: Row(
        children: [
          Container(
            width: 36 * scale,
            height: 36 * scale,
            decoration: const BoxDecoration(
              color: Color(0xFF0EA5E9),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.mail_outline_rounded, color: Colors.white, size: 18 * scale),
          ),
          SizedBox(width: 12 * scale),
          Expanded(
            child: Text(
              notice,
              style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepsList extends StatelessWidget {
  const _StepsList({required this.scale, required this.steps});

  final double scale;
  final List<ConfirmationStep> steps;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 12 * scale, offset: Offset(0, 6 * scale)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Prochaines étapes', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600)),
          SizedBox(height: 12 * scale),
          ...steps.map(
            (step) => Padding(
              padding: EdgeInsets.only(bottom: 12 * scale),
              child: Row(
                children: [
                  Container(
                    width: 36 * scale,
                    height: 36 * scale,
                    decoration: BoxDecoration(color: step.color.withValues(alpha: 0.18), shape: BoxShape.circle),
                    child: Icon(step.icon, color: step.color, size: 18 * scale),
                  ),
                  SizedBox(width: 12 * scale),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(step.title, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
                        if (step.subtitle != null) ...[
                          SizedBox(height: 2 * scale),
                          Text(step.subtitle!, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12.5 * scale)),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionList extends StatelessWidget {
  const _ActionList({required this.scale, required this.actions});

  final double scale;
  final List<ConfirmationAction> actions;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Actions connexes', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600)),
        SizedBox(height: 12 * scale),
        ...actions.map(
          (action) => GestureDetector(
            onTap: action.route == null ? null : () => Get.toNamed(action.route!),
            child: Container(
              margin: EdgeInsets.only(bottom: 12 * scale),
              padding: EdgeInsets.all(16 * scale),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16 * scale),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 12 * scale, offset: Offset(0, 6 * scale)),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 40 * scale,
                    height: 40 * scale,
                    decoration: BoxDecoration(color: const Color(0x19176BFF), borderRadius: BorderRadius.circular(12 * scale)),
                    child: Icon(action.icon, color: const Color(0xFF176BFF), size: 20 * scale),
                  ),
                  SizedBox(width: 12 * scale),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(action.title, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
                        SizedBox(height: 4 * scale),
                        Text(action.subtitle, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12.5 * scale)),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right_rounded, color: const Color(0xFF94A3B8), size: 18 * scale),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}


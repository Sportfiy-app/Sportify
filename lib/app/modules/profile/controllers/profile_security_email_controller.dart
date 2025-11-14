import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileSecurityEmailController extends GetxController {
  final RxString currentEmail = 'david.doe@gmail.com'.obs;
  final RxInt resendSeconds = 60.obs;
  final RxBool canResend = false.obs;

  Timer? _resendTimer;

  void startEmailUpdate() {
    _sendVerificationEmail();
    Get.dialog(
      EmailConfirmationDialog(controller: this),
      barrierDismissible: false,
      barrierColor: const Color(0x80000000),
    );
  }

  void _sendVerificationEmail() {
    resendSeconds.value = 60;
    canResend.value = false;
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendSeconds.value > 1) {
        resendSeconds.value = resendSeconds.value - 1;
      } else {
        resendSeconds.value = 0;
        canResend.value = true;
        timer.cancel();
      }
    });
    Get.snackbar('Vérification envoyée', 'Un email de confirmation vient d\'être envoyé à ${currentEmail.value}.');
  }

  void resendVerificationEmail() {
    if (!canResend.value) {
      return;
    }
    _sendVerificationEmail();
  }

  void openMailboxApp() {
    Get.snackbar('Boîte mail', 'Ouvrez votre application de messagerie pour confirmer le changement.');
  }

  void closeConfirmationModal() {
    _resendTimer?.cancel();
    Get.back();
  }

  @override
  void onClose() {
    _resendTimer?.cancel();
    super.onClose();
  }
}

class EmailConfirmationDialog extends StatelessWidget {
  const EmailConfirmationDialog({required this.controller, super.key});

  final ProfileSecurityEmailController controller;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      backgroundColor: Colors.transparent,
      child: Material(
        borderRadius: BorderRadius.circular(24),
        elevation: 6,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const SizedBox(width: 32),
                  Expanded(
                    child: Text(
                      'Confirmez votre adresse email',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF111111),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: controller.closeConfirmationModal,
                    icon: const Icon(Icons.close_rounded, size: 20, color: Color(0xFF111111)),
                    style: IconButton.styleFrom(
                      backgroundColor: const Color(0xFFF3F4F6),
                      padding: const EdgeInsets.all(8),
                      shape: const CircleBorder(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFF006CFF), Color(0xFF4FC3F7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.mark_email_read_rounded, color: Colors.white, size: 36),
              ),
              const SizedBox(height: 20),
              Text(
                'Vous venez de recevoir un email de vérification sur',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: const Color(0xFF9B9B9B),
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFD0E3FF)),
                ),
                child: Obx(
                  () => Text(
                    controller.currentEmail.value,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF176BFF),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEFCE8),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFFCD34D).withValues(alpha: 0.4)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.watch_later_outlined, size: 20, color: Color(0xFFF59E0B)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Le lien expire dans 30 minutes.\nCela peut prendre quelques secondes à arriver.',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF9B9B9B),
                          fontSize: 12,
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: controller.closeConfirmationModal,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF006CFF), Color(0xFF4FC3F7)]),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Text(
                        'Fermer',
                        style: GoogleFonts.inter(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: OutlinedButton(
                        onPressed: controller.openMailboxApp,
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          side: const BorderSide(color: Color(0xFFD0E3FF)),
                        ),
                        child: Text(
                          'Ouvrir ma boîte mail',
                          style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Obx(
                      () => SizedBox(
                        height: 48,
                        child: OutlinedButton(
                          onPressed: controller.canResend.value ? controller.resendVerificationEmail : null,
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            side: BorderSide(
                              color: controller.canResend.value ? const Color(0xFF176BFF) : const Color(0xFFE2E8F0),
                            ),
                          ),
                          child: Text(
                            controller.canResend.value
                                ? 'Renvoyer'
                                : 'Renvoyer (${controller.resendSeconds.value}s)',
                            style: GoogleFonts.inter(
                              color: controller.canResend.value ? const Color(0xFF176BFF) : const Color(0xFF94A3B8),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text.rich(
                TextSpan(
                  text: 'Vous ne recevez pas l\'email ? Vérifiez vos spams ou ',
                  style: GoogleFonts.inter(color: const Color(0xFF9B9B9B), fontSize: 12),
                  children: [
                    TextSpan(
                      text: 'contactez le support',
                      style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 12, decoration: TextDecoration.underline),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
class ProfileSecurityPasswordController extends GetxController {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  late final String accountEmail;
  final RxBool obscureCurrent = true.obs;
  final RxBool obscureNew = true.obs;
  final RxBool obscureConfirm = true.obs;

  final RxString currentError = ''.obs;
  final RxString newError = ''.obs;
  final RxString confirmError = ''.obs;

  final RxDouble strength = 0.0.obs;
  Timer? _autoCloseTimer;

  @override
  void onInit() {
    super.onInit();
    accountEmail = (Get.arguments?['email'] as String?) ?? 'support@sportify.app';
  }

  void toggleCurrentVisibility() => obscureCurrent.toggle();
  void toggleNewVisibility() => obscureNew.toggle();
  void toggleConfirmVisibility() => obscureConfirm.toggle();

  void onNewPasswordChanged(String value) {
    strength.value = _calculateStrength(value);
    if (newError.isNotEmpty) {
      _validateNewPassword();
    }
  }

  void submit() {
    _clearErrors();
    final hasCurrent = currentPasswordController.text.trim().isNotEmpty;
    if (!hasCurrent) {
      currentError.value = 'Entrez votre mot de passe actuel';
    }

    final newValid = _validateNewPassword();
    final confirmValid = _validateConfirmation();

    if (currentError.isNotEmpty || !newValid || !confirmValid) {
      return;
    }

    if (currentPasswordController.text.trim() == newPasswordController.text.trim()) {
      newError.value = 'Le nouveau mot de passe doit être différent de l’ancien';
      return;
    }

    Get.focusScope?.unfocus();
    _showSuccessDialog();
  }

  double _calculateStrength(String password) {
    if (password.isEmpty) return 0;
    double score = 0;
    if (password.length >= 8) score += 0.25;
    if (RegExp(r'[A-Z]').hasMatch(password)) score += 0.2;
    if (RegExp(r'[a-z]').hasMatch(password)) score += 0.2;
    if (RegExp(r'\d').hasMatch(password)) score += 0.2;
    if (RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password)) score += 0.15;
    return score.clamp(0.0, 1.0);
  }

  bool _validateNewPassword() {
    final value = newPasswordController.text.trim();
    if (value.isEmpty) {
      newError.value = 'Créez un mot de passe sécurisé';
      return false;
    }
    if (value.length < 8) {
      newError.value = 'Utilisez au moins 8 caractères';
      return false;
    }
    newError.value = '';
    return true;
  }

  bool _validateConfirmation() {
    final confirm = confirmPasswordController.text.trim();
    if (confirm.isEmpty) {
      confirmError.value = 'Confirmez votre nouveau mot de passe';
      return false;
    }
    if (confirm != newPasswordController.text.trim()) {
      confirmError.value = 'Les mots de passe ne correspondent pas';
      return false;
    }
    confirmError.value = '';
    return true;
  }

  void _clearErrors() {
    currentError.value = '';
    newError.value = '';
    confirmError.value = '';
  }

  void _showSuccessDialog() {
    Get.dialog<void>(
      _PasswordChangeSuccessDialog(
        onClose: closeSuccessDialog,
        email: accountEmail,
      ),
      barrierColor: const Color(0x66000000),
      barrierDismissible: false,
    );
    _autoCloseTimer?.cancel();
    _autoCloseTimer = Timer(const Duration(seconds: 4), closeSuccessDialog);
  }

  void closeSuccessDialog() {
    _autoCloseTimer?.cancel();
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    _autoCloseTimer?.cancel();
    super.onClose();
  }
}

class _PasswordChangeSuccessDialog extends StatelessWidget {
  const _PasswordChangeSuccessDialog({required this.onClose, required this.email});

  final VoidCallback onClose;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Color(0x330B1220),
              blurRadius: 32,
              offset: Offset(0, 18),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: onClose,
                icon: const Icon(Icons.close_rounded, color: Color(0xFF0B1220)),
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0xFFF1F5F9),
                  padding: const EdgeInsets.all(10),
                  shape: const CircleBorder(),
                ),
              ),
            ),
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFF0EA5E9), Color(0xFF2563EB)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x332563EB),
                    blurRadius: 24,
                    offset: Offset(0, 12),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.task_alt_rounded, color: Colors.white, size: 40),
            ),
            const SizedBox(height: 20),
            Text(
              'Mot de passe modifié !',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: const Color(0xFF0B1220),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Vérifiez votre boîte mail',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: const Color(0xFF0B1220),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Vos nouveaux identifiants vous ont été envoyés par email !',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: const Color(0xFF475569),
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.mark_email_read_outlined, color: Color(0xFF176BFF), size: 18),
                      const SizedBox(width: 8),
                      Text(
                        'Email envoyé à',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF0B1220),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    email,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF176BFF),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Expéditeur : support@sportify.app',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF64748B),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: onClose,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                ),
                child: Ink(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    gradient: LinearGradient(
                      colors: [Color(0xFF0055FF), Color(0xFF33AAFF)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
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
          ],
        ),
      ),
    );
  }
}


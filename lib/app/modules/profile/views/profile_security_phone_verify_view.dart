import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/profile_security_phone_verify_controller.dart';

class ProfileSecurityPhoneVerifyView extends GetView<ProfileSecurityPhoneVerifyController> {
  const ProfileSecurityPhoneVerifyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            const designWidth = 375.0;
            final width = constraints.hasBoundedWidth ? constraints.maxWidth : MediaQuery.of(context).size.width;
            final scale = (width / designWidth).clamp(0.9, 1.1);

            return Column(
              children: [
                _Header(scale: scale),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 24 * scale),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: designWidth * scale),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _Hero(scale: scale),
                          SizedBox(height: 24 * scale),
                          _Instructions(scale: scale),
                          SizedBox(height: 24 * scale),
                          _OtpInputs(scale: scale),
                          SizedBox(height: 18 * scale),
                          _TimerBanner(scale: scale),
                          SizedBox(height: 16 * scale),
                          _ResendRow(scale: scale),
                          SizedBox(height: 28 * scale),
                          _ValidateButton(scale: scale),
                          SizedBox(height: 24 * scale),
                          _SafetyCard(scale: scale),
                          SizedBox(height: 18 * scale),
                          _SupportOptions(scale: scale),
                          SizedBox(height: 24 * scale),
                          Text('Sportify v1.0.0', textAlign: TextAlign.center, style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 12 * scale)),
                          SizedBox(height: 6 * scale),
                          Text('© 2024 Sportify. Tous droits réservés.', textAlign: TextAlign.center, style: GoogleFonts.inter(color: const Color(0xFFCBD5F5), fontSize: 12 * scale)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 14 * scale),
      child: Row(
        children: [
          IconButton(
            onPressed: Get.back,
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
            style: IconButton.styleFrom(
              backgroundColor: const Color(0xFFF3F4F6),
              padding: EdgeInsets.all(10 * scale),
              shape: const CircleBorder(),
            ),
          ),
          Expanded(
            child: Text(
              'Confirmation',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 19 * scale, fontWeight: FontWeight.w600),
            ),
          ),
          IconButton(
            onPressed: () => Get.snackbar('Aide', 'Assistance prochainement disponible.'),
            icon: const Icon(Icons.help_outline_rounded, size: 20),
            style: IconButton.styleFrom(
              backgroundColor: const Color(0xFFF3F4F6),
              padding: EdgeInsets.all(10 * scale),
              shape: const CircleBorder(),
            ),
          ),
        ],
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20 * scale),
        gradient: const LinearGradient(colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        boxShadow: [BoxShadow(color: const Color(0x33176BFF), blurRadius: 24 * scale, offset: Offset(0, 16 * scale))],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 88 * scale,
            height: 88 * scale,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.15),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.sms_rounded, color: Colors.white, size: 40 * scale),
          ),
          SizedBox(height: 16 * scale),
          Text('Vérification par SMS', style: GoogleFonts.poppins(color: Colors.white, fontSize: 20 * scale, fontWeight: FontWeight.w700)),
          SizedBox(height: 6 * scale),
          Text(
            'Saisissez le code reçu pour confirmer votre nouveau numéro.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.85), fontSize: 14 * scale),
          ),
        ],
      ),
    );
  }
}

class _Instructions extends GetView<ProfileSecurityPhoneVerifyController> {
  const _Instructions({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Code envoyé à', textAlign: TextAlign.center, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale)),
        SizedBox(height: 6 * scale),
        Obx(
          () => Text(
            controller.maskedPhone,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 17 * scale, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}

class _OtpInputs extends GetView<ProfileSecurityPhoneVerifyController> {
  const _OtpInputs({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(controller.codeControllers.length, (index) {
              final hasError = controller.errorMessage.value.isNotEmpty;
              return SizedBox(
                width: 64 * scale,
                child: TextField(
                  controller: controller.codeControllers[index],
                  focusNode: controller.focusNodes[index],
                  keyboardType: TextInputType.number,
                  autofocus: index == 0,
                  maxLength: 1,
                  textAlign: TextAlign.center,
                  onChanged: (value) => controller.onDigitChanged(index, value),
                  style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 20 * scale, fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    counterText: '',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(vertical: 18 * scale),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14 * scale),
                      borderSide: BorderSide(color: hasError ? const Color(0xFFEF4444) : const Color(0xFFE2E8F0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14 * scale),
                      borderSide: BorderSide(color: hasError ? const Color(0xFFEF4444) : const Color(0xFF176BFF), width: 2),
                    ),
                  ),
                ),
              );
            }),
          ),
          if (controller.errorMessage.value.isNotEmpty) ...[
            SizedBox(height: 10 * scale),
            Text(
              controller.errorMessage.value,
              style: GoogleFonts.inter(color: const Color(0xFFEF4444), fontSize: 12.5 * scale),
            ),
          ],
        ],
      ),
    );
  }
}

class _TimerBanner extends GetView<ProfileSecurityPhoneVerifyController> {
  const _TimerBanner({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 16 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFFFF3C4)),
      ),
      child: Row(
        children: [
          Container(
            width: 32 * scale,
            height: 32 * scale,
            decoration: BoxDecoration(color: const Color(0xFFFDE68A), borderRadius: BorderRadius.circular(12 * scale)),
            alignment: Alignment.center,
            child: Icon(Icons.hourglass_bottom_rounded, color: const Color(0xFFF59E0B), size: 18 * scale),
          ),
          SizedBox(width: 12 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Le code expire dans', style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
                SizedBox(height: 4 * scale),
                Obx(
                  () => Text(controller.formattedTimer, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ResendRow extends GetView<ProfileSecurityPhoneVerifyController> {
  const _ResendRow({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Text('Vous n’avez pas reçu le code ?', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale)),
          SizedBox(height: 8 * scale),
          GestureDetector(
            onTap: controller.canResend.value ? controller.resendCode : null,
            child: Text(
              'Renvoyer',
              style: GoogleFonts.inter(
                color: controller.canResend.value ? const Color(0xFF176BFF) : const Color(0xFF9CA3AF),
                fontSize: 15 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ValidateButton extends GetView<ProfileSecurityPhoneVerifyController> {
  const _ValidateButton({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56 * scale,
      child: ElevatedButton(
        onPressed: controller.validateCode,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16 * scale)),
        ),
        child: Ink(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)]),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Center(
            child: Text('Valider et modifier', style: GoogleFonts.inter(color: Colors.white, fontSize: 16 * scale, fontWeight: FontWeight.w600)),
          ),
        ),
      ),
    );
  }
}

class _SafetyCard extends StatelessWidget {
  const _SafetyCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18 * scale),
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
              Container(
                width: 32 * scale,
                height: 32 * scale,
                decoration: BoxDecoration(color: const Color(0x33176BFF), borderRadius: BorderRadius.circular(12 * scale)),
                alignment: Alignment.center,
                child: Icon(Icons.verified_user_rounded, color: const Color(0xFF176BFF), size: 18 * scale),
              ),
              SizedBox(width: 10 * scale),
              Text('Sécurité', style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600)),
            ],
          ),
          SizedBox(height: 12 * scale),
          Text(
            'Ce code est valable 2 minutes et ne peut être utilisé qu’une seule fois. Ne le partagez avec personne.',
            style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale),
          ),
        ],
      ),
    );
  }
}

class _SupportOptions extends StatelessWidget {
  const _SupportOptions({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Besoin d’aide ?', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
        SizedBox(height: 14 * scale),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _SupportChip(scale: scale, icon: Icons.chat_bubble_outline_rounded, label: 'Chat'),
            _SupportChip(scale: scale, icon: Icons.phone_outlined, label: 'Appeler'),
            _SupportChip(scale: scale, icon: Icons.help_outline_rounded, label: 'FAQ'),
          ],
        ),
      ],
    );
  }
}

class _SupportChip extends StatelessWidget {
  const _SupportChip({required this.scale, required this.icon, required this.label});

  final double scale;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 48 * scale,
          height: 48 * scale,
          decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(16 * scale)),
          alignment: Alignment.center,
          child: Icon(icon, color: const Color(0xFF475569), size: 20 * scale),
        ),
        SizedBox(height: 6 * scale),
        Text(label, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
      ],
    );
  }
}


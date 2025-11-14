import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/register_controller.dart';

class RegisterSmsValidationView extends GetView<RegisterController> {
  const RegisterSmsValidationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const baseWidth = 375.0;
          final screenSize = MediaQuery.of(context).size;
          final maxWidth =
              constraints.hasBoundedWidth ? constraints.maxWidth : screenSize.width;
          final scale = (maxWidth / baseWidth).clamp(0.85, 1.15);

          return Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: maxWidth,
              child: _SmsValidationContent(scale: scale),
            ),
          );
        },
      ),
    );
  }
}

class _SmsValidationContent extends StatelessWidget {
  const _SmsValidationContent({required this.scale});

  final double scale;

  double s(double value) => value * scale;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF7FAFF), Colors.white],
          ),
          border: Border(
            left: BorderSide(color: Color(0xFFE5E7EB)),
            right: BorderSide(color: Color(0xFFE5E7EB)),
          ),
        ),
        child: Column(
          children: [
            _TopBar(scale: scale),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: s(24)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: s(24)),
                    _StepProgress(scale: scale),
                    SizedBox(height: s(24)),
                    _HeroSection(scale: scale),
                    SizedBox(height: s(24)),
                    _OtpSection(scale: scale),
                    SizedBox(height: s(24)),
                    _ResendRow(scale: scale),
                    SizedBox(height: s(24)),
                    _SecurityInfo(scale: scale),
                    SizedBox(height: s(24)),
                    _SupportCards(scale: scale),
                    SizedBox(height: s(24)),
                    _CommunityStats(scale: scale),
                    SizedBox(height: s(32)),
                    _ContinueButton(scale: scale),
                    SizedBox(height: s(32)),
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

class _TopBar extends StatelessWidget {
  const _TopBar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72 * scale,
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: Get.back,
            child: Container(
              width: 40 * scale,
              height: 40 * scale,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(12 * scale),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              alignment: Alignment.center,
              child:
                  Icon(Icons.arrow_back_ios_new_rounded, size: 18 * scale, color: const Color(0xFF0B1220)),
            ),
          ),
          const Spacer(),
          Container(
            width: 32 * scale,
            height: 32 * scale,
            decoration: BoxDecoration(
              color: const Color(0xFF176BFF),
              borderRadius: BorderRadius.circular(9999),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            alignment: Alignment.center,
            child: Text(
              'S',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18 * scale,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(width: 8 * scale),
          Text(
            'Sportify',
            style: GoogleFonts.poppins(
              color: const Color(0xFF0B1220),
              fontSize: 18 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: 16 * scale),
          Container(
            width: 40 * scale,
            height: 40 * scale,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12 * scale),
              border: Border.all(color: Colors.transparent),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepProgress extends StatelessWidget {
  const _StepProgress({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Étape 3 sur 5',
              style: GoogleFonts.inter(
                color: const Color(0xFF475569),
                fontSize: 14 * scale,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Text(
              '60%',
              style: GoogleFonts.inter(
                color: const Color(0xFF176BFF),
                fontSize: 15 * scale,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
        SizedBox(height: 14 * scale),
        ClipRRect(
          borderRadius: BorderRadius.circular(9999),
          child: LinearProgressIndicator(
            value: 0.6,
            minHeight: 10 * scale,
            backgroundColor: const Color(0xFFE2E8F0),
            valueColor: const AlwaysStoppedAnimation(Color(0xFF176BFF)),
          ),
        ),
      ],
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20 * scale,
            offset: Offset(0, 12 * scale),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 64 * scale,
            height: 64 * scale,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment(-0.3, -0.4),
                end: Alignment(0.6, 1.0),
                colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
              ),
              borderRadius: BorderRadius.circular(18 * scale),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x33176BFF),
                  blurRadius: 14 * scale,
                  offset: Offset(0, 8 * scale),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Icon(Icons.sms_outlined, color: Colors.white, size: 32 * scale),
          ),
          SizedBox(height: 20 * scale),
          Text(
            'Validation SMS',
            style: GoogleFonts.poppins(
              color: const Color(0xFF0B1220),
              fontSize: 24 * scale,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8 * scale),
          Text(
            'Nous avons envoyé un code de 6 chiffres au numéro indiqué. Entrez-le pour sécuriser votre compte.',
            style: GoogleFonts.inter(
              color: const Color(0xFF475569),
              fontSize: 16 * scale,
              height: 1.55,
            ),
          ),
          SizedBox(height: 16 * scale),
          Container(
            padding: EdgeInsets.all(16 * scale),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(14 * scale),
              border: Border.all(color: const Color(0xFFDBEAFE)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 28 * scale,
                  height: 28 * scale,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8 * scale),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.lock_outline, size: 16 * scale, color: const Color(0xFF176BFF)),
                ),
                SizedBox(width: 12 * scale),
                Expanded(
                  child: Text(
                    'Ce code expire dans 10 minutes. Ne le partagez jamais avec un tiers.',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF0B1220),
                      fontSize: 14 * scale,
                      height: 1.55,
                    ),
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

class _OtpSection extends StatelessWidget {
  const _OtpSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Code de vérification',
          style: GoogleFonts.inter(
            color: const Color(0xFF0B1220),
            fontSize: 16 * scale,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12 * scale),
        const _OtpInputRow(),
      ],
    );
  }
}

class _OtpInputRow extends StatefulWidget {
  const _OtpInputRow();

  @override
  State<_OtpInputRow> createState() => _OtpInputRowState();
}

class _OtpInputRowState extends State<_OtpInputRow> {
  late final List<FocusNode> _focusNodes;

  RegisterController get controller => Get.find<RegisterController>();

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(controller.smsCodeControllers.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scale = (MediaQuery.of(context).size.width / 375).clamp(0.85, 1.15);
    final fields = <Widget>[];
    for (var i = 0; i < controller.smsCodeControllers.length; i++) {
      fields.add(
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 6 * scale),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14 * scale),
              border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 12 * scale,
                  offset: Offset(0, 6 * scale),
                ),
              ],
            ),
            child: TextField(
              controller: controller.smsCodeControllers[i],
              focusNode: _focusNodes[i],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: const Color(0xFF0B1220),
                fontSize: 20 * scale,
                fontWeight: FontWeight.w600,
              ),
              maxLength: 1,
              decoration: const InputDecoration(
                counterText: '',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 18),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(1),
              ],
              onChanged: (value) {
                controller.onSmsDigitChanged();
                if (value.length == 1) {
                  if (i + 1 < _focusNodes.length) {
                    _focusNodes[i + 1].requestFocus();
                  } else {
                    _focusNodes[i].unfocus();
                  }
                } else if (value.isEmpty && i > 0) {
                  _focusNodes[i - 1].requestFocus();
                }
              },
              onTap: () => controller.smsCodeControllers[i].selection = TextSelection(
                baseOffset: 0,
                extentOffset: controller.smsCodeControllers[i].text.length,
              ),
            ),
          ),
        ),
      );
    }

    return Row(children: fields);
  }
}

class _ResendRow extends GetView<RegisterController> {
  const _ResendRow({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Obx(
        () => Row(
          children: [
            Icon(Icons.schedule_outlined, size: 18 * scale, color: const Color(0xFF176BFF)),
            SizedBox(width: 12 * scale),
            if (controller.resendSeconds.value > 0)
              Expanded(
                child: Text(
                  'Renvoyer le code dans ${controller.resendSeconds.value.toString().padLeft(2, '0')}s',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF475569),
                    fontSize: 14 * scale,
                  ),
                ),
              )
            else
              Expanded(
                child: TextButton(
                  onPressed: controller.resendSmsCode,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerLeft,
                  ),
                  child: Text(
                    'Renvoyer le code',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF176BFF),
                      fontSize: 14 * scale,
                      fontWeight: FontWeight.w600,
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

class _SecurityInfo extends StatelessWidget {
  const _SecurityInfo({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Vos informations restent protégées',
            style: GoogleFonts.poppins(
              color: const Color(0xFF0B1220),
              fontSize: 18 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16 * scale),
          _SecurityBullet(
            scale: scale,
            icon: Icons.lock_outline,
            title: 'Chiffrement SSL',
            description: 'Connexion sécurisée de bout en bout pour chaque étape.',
            iconBg: const Color(0x19176BFF),
          ),
          SizedBox(height: 12 * scale),
          _SecurityBullet(
            scale: scale,
            icon: Icons.shield_outlined,
            title: 'Serveurs en France',
            description: 'Données stockées sur des infrastructures conformes RGPD.',
            iconBg: const Color(0x1916A34A),
          ),
          SizedBox(height: 12 * scale),
          _SecurityBullet(
            scale: scale,
            icon: Icons.verified_outlined,
            title: 'Authentification renforcée',
            description: 'Validation par SMS pour protéger votre compte sport.',
            iconBg: const Color(0x19FFB800),
          ),
        ],
      ),
    );
  }
}

class _SecurityBullet extends StatelessWidget {
  const _SecurityBullet({
    required this.scale,
    required this.icon,
    required this.title,
    required this.description,
    required this.iconBg,
  });

  final double scale;
  final IconData icon;
  final String title;
  final String description;
  final Color iconBg;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36 * scale,
          height: 36 * scale,
          decoration: BoxDecoration(
            color: iconBg,
            borderRadius: BorderRadius.circular(12 * scale),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: 18 * scale, color: const Color(0xFF0B1220)),
        ),
        SizedBox(width: 12 * scale),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  color: const Color(0xFF0B1220),
                  fontSize: 14 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4 * scale),
              Text(
                description,
                style: GoogleFonts.inter(
                  color: const Color(0xFF475569),
                  fontSize: 13 * scale,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SupportCards extends StatelessWidget {
  const _SupportCards({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Besoin d\'aide ?',
            style: GoogleFonts.poppins(
              color: const Color(0xFF0B1220),
              fontSize: 18 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16 * scale),
          Row(
            children: [
              Expanded(
                child: _SupportCard(
                  scale: scale,
                  icon: Icons.question_mark_outlined,
                  title: 'FAQ sécurité',
                  description: 'Réponses à vos questions sur la validation SMS.',
                ),
              ),
              SizedBox(width: 16 * scale),
              Expanded(
                child: _SupportCard(
                  scale: scale,
                  icon: Icons.support_agent_outlined,
                  title: 'Contacter le support',
                  description: 'Notre équipe vous répond sous 24h.',
                ),
              ),
            ],
          ),
          SizedBox(height: 20 * scale),
          Column(
            children: [
              Text(
                'Écrivez-nous à',
                style: GoogleFonts.inter(
                  color: const Color(0xFF475569),
                  fontSize: 12 * scale,
                ),
              ),
              SizedBox(height: 6 * scale),
              Text(
                'support@sportify.com',
                style: GoogleFonts.inter(
                  color: const Color(0xFF176BFF),
                  fontSize: 16 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SupportCard extends StatelessWidget {
  const _SupportCard({
    required this.scale,
    required this.icon,
    required this.title,
    required this.description,
  });

  final double scale;
  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(14 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40 * scale,
            height: 40 * scale,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12 * scale),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            alignment: Alignment.center,
            child: Icon(icon, size: 20 * scale, color: const Color(0xFF0B1220)),
          ),
          SizedBox(height: 12 * scale),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF0B1220),
              fontSize: 14 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6 * scale),
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF475569),
              fontSize: 12 * scale,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _CommunityStats extends StatelessWidget {
  const _CommunityStats({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final stats = [
      _Stat(value: '15K+', label: 'Sportifs actifs', color: const Color(0xFF176BFF)),
      _Stat(value: '500+', label: 'Terrains partenaires', color: const Color(0xFF16A34A)),
      _Stat(value: '4.8', label: 'Note moyenne', color: const Color(0xFFFFB800)),
    ];
    return Container(
      padding: EdgeInsets.all(24 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Text(
            'La communauté Sportify vous attend',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: const Color(0xFF0B1220),
              fontSize: 18 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 20 * scale),
          Row(
            children: stats
                .map(
                  (stat) => Expanded(
                    child: Column(
                      children: [
                        Text(
                          stat.value,
                          style: GoogleFonts.poppins(
                            color: stat.color,
                            fontSize: 24 * scale,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 6 * scale),
                        Text(
                          stat.label,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            color: const Color(0xFF475569),
                            fontSize: 12 * scale,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _Stat {
  const _Stat({required this.value, required this.label, required this.color});
  final String value;
  final String label;
  final Color color;
}

class _ContinueButton extends GetView<RegisterController> {
  const _ContinueButton({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Obx(
            () => ElevatedButton(
              onPressed: controller.isSmsCodeComplete ? controller.submitSmsCode : null,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 18 * scale),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12 * scale),
                ),
                backgroundColor: const Color(0xFF176BFF),
                disabledBackgroundColor: const Color(0xFFE2E8F0),
              ),
              child: Text(
                'Continuer',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 12 * scale),
        Text(
          'En continuant, vous acceptez nos conditions d\'utilisation.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: const Color(0xFF475569),
            fontSize: 12 * scale,
          ),
        ),
      ],
    );
  }
}

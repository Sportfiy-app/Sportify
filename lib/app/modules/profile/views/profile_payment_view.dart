import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/profile_payment_controller.dart';

class ProfilePaymentView extends GetView<ProfilePaymentController> {
  const ProfilePaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF0B1220),
                      Color(0xFF0F172A),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 12,
              left: 16,
              child: IconButton(
                onPressed: controller.closeSheet,
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white.withValues(alpha: 0.1),
                  padding: const EdgeInsets.all(12),
                  shape: const CircleBorder(),
                ),
                icon: const Icon(Icons.close_rounded, color: Colors.white),
              ),
            ),
            Positioned.fill(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 68, 16, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _HeaderCard(amount: controller.formattedAmount),
                    const SizedBox(height: 24),
                    _CardForm(),
                    const SizedBox(height: 20),
                    _BillingSection(),
                    const SizedBox(height: 20),
                    _SaveCardTile(),
                    const SizedBox(height: 28),
                    _SecurityBadges(),
                    const SizedBox(height: 28),
                    _SummaryCard(),
                    const SizedBox(height: 20),
                    _PayButton(),
                    const SizedBox(height: 18),
                    _AlternativePayments(),
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

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({required this.amount});

  final String amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF176BFF).withValues(alpha: 0.3),
            blurRadius: 32,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.credit_card_rounded, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 18),
          Text(
            'Ajouter une carte',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Paiement sécurisé par Stripe et Apple Pay',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              'Montant à régler : $amount',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CardForm extends GetView<ProfilePaymentController> {
  const _CardForm();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FormLabel(icon: Icons.credit_card, label: 'Numéro de carte'),
        const SizedBox(height: 8),
        _DarkTextField(
          controller: controller.cardNumberController,
          hintText: '1234 5678 9012 3456',
          keyboardType: TextInputType.number,
          autofillHints: const [AutofillHints.creditCardNumber],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _FormLabel(icon: Icons.date_range_rounded, label: 'Expiration'),
                  const SizedBox(height: 8),
                  _DarkTextField(
                    controller: controller.expiryController,
                    hintText: 'MM/AA',
                    keyboardType: TextInputType.datetime,
                    autofillHints: const [AutofillHints.creditCardExpirationDate],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _FormLabel(icon: Icons.lock_outline_rounded, label: 'CVC'),
                  const SizedBox(height: 8),
                  _DarkTextField(
                    controller: controller.cvcController,
                    hintText: '123',
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    autofillHints: const [AutofillHints.creditCardSecurityCode],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _BillingSection extends GetView<ProfilePaymentController> {
  const _BillingSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0x331F2937)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0x33176BFF),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.location_on_outlined, color: Color(0xFF60A5FA), size: 16),
              ),
              const SizedBox(width: 12),
              Text(
                'Adresse de facturation',
                style: GoogleFonts.inter(color: const Color(0xFFE5EAF1), fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => Get.snackbar('Adresse', 'Modification disponible bientôt.'),
                style: TextButton.styleFrom(foregroundColor: const Color(0xFF60A5FA)),
                child: Text('Modifier', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _FormLabel(icon: Icons.public_rounded, label: 'Pays ou région'),
          const SizedBox(height: 8),
          Obx(
            () => _DarkDropdown<String>(
              value: controller.selectedCountry.value,
              items: controller.availableCountries
                  .map(
                    (entry) => DropdownMenuItem<String>(
                      value: entry,
                      child: Text(entry, style: GoogleFonts.inter(color: Colors.white, fontSize: 15)),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) controller.selectedCountry.value = value;
              },
            ),
          ),
          const SizedBox(height: 16),
          _FormLabel(icon: Icons.local_post_office_outlined, label: 'Code postal'),
          const SizedBox(height: 8),
          _DarkTextField(
            controller: controller.postalCodeController,
            hintText: '75001',
            keyboardType: TextInputType.text,
          ),
        ],
      ),
    );
  }
}

class _SaveCardTile extends GetView<ProfilePaymentController> {
  const _SaveCardTile();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InkWell(
        onTap: () => controller.shouldSaveCard.toggle(),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0x331F2937)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: controller.shouldSaveCard.value,
                onChanged: (_) => controller.shouldSaveCard.toggle(),
                side: const BorderSide(color: Color(0xFF94A3B8), width: 1.6),
                checkColor: Colors.white,
                activeColor: const Color(0xFF176BFF),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enregistrer cette carte pour Sportify',
                      style: GoogleFonts.inter(color: const Color(0xFFE5EAF1), fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Payez plus rapidement lors de vos prochaines réservations.',
                      style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SecurityBadges extends StatelessWidget {
  const _SecurityBadges();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        _Badge(icon: Icons.verified_user_outlined, label: 'SSL sécurisé'),
        SizedBox(width: 12),
        _Badge(icon: Icons.account_balance_outlined, label: 'Stripe'),
        SizedBox(width: 12),
        _Badge(icon: Icons.shield_outlined, label: 'PCI compliant'),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0x331F2937)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFF94A3B8), size: 18),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 12.5),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0x331F2937)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Abonnement Premium',
                style: GoogleFonts.inter(color: const Color(0xFFE5EAF1), fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Text(
                '16,99 €',
                style: GoogleFonts.inter(color: const Color(0xFFE5EAF1), fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                'TVA incluse',
                style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 13),
              ),
              const Spacer(),
              Text('2,83 €', style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 13)),
            ],
          ),
          const SizedBox(height: 12),
          Divider(color: Colors.white.withValues(alpha: 0.08)),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                'Total à payer',
                style: GoogleFonts.inter(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              Text(
                '16,99 €',
                style: GoogleFonts.inter(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PayButton extends GetView<ProfilePaymentController> {
  const _PayButton();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ElevatedButton(
        onPressed: controller.isProcessing.value ? null : controller.submitPayment,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(58),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            alignment: Alignment.center,
            child: controller.isProcessing.value
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2.2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                  )
                : Text(
                    'Payer ${controller.formattedAmount}',
                    style: GoogleFonts.inter(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
                  ),
          ),
        ),
      ),
    );
  }
}

class _AlternativePayments extends StatelessWidget {
  const _AlternativePayments();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: Colors.white.withValues(alpha: 0.06))),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF0B1220),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
              ),
              child: Text('ou', style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 13)),
            ),
            Expanded(child: Divider(color: Colors.white.withValues(alpha: 0.06))),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: const [
            Expanded(child: _AlternativeButton(label: 'Apple Pay', icon: Icons.apple)),
            SizedBox(width: 12),
            Expanded(child: _AlternativeButton(label: 'Google Pay', icon: Icons.payments_outlined)),
          ],
        ),
      ],
    );
  }
}

class _AlternativeButton extends StatelessWidget {
  const _AlternativeButton({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => Get.snackbar(label, 'Intégration à venir.'),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(54),
        foregroundColor: Colors.white,
        side: const BorderSide(color: Color(0x331F2937)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        backgroundColor: Colors.white.withValues(alpha: 0.08),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(label, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _FormLabel extends StatelessWidget {
  const _FormLabel({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF94A3B8), size: 16),
        const SizedBox(width: 8),
        Text(label, style: GoogleFonts.inter(color: const Color(0xFFE5EAF1), fontSize: 14, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class _DarkTextField extends StatelessWidget {
  const _DarkTextField({
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.autofillHints = const [],
    this.obscureText = false,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final Iterable<String> autofillHints;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      autofillHints: autofillHints,
      style: GoogleFonts.inter(color: Colors.white, fontSize: 16),
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.08),
        hintText: hintText,
        hintStyle: GoogleFonts.inter(color: const Color(0xFFADAEBC), fontSize: 16),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF1F2937)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF1F2937)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF2563EB)),
        ),
      ),
    );
  }
}

class _DarkDropdown<T> extends StatelessWidget {
  const _DarkDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final T value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      dropdownColor: const Color(0xFF111827),
      style: GoogleFonts.inter(color: Colors.white, fontSize: 15),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.08),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF1F2937)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF1F2937)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF2563EB)),
        ),
        suffixIcon: const Icon(Icons.expand_more_rounded, color: Color(0xFF94A3B8)),
      ),
    );
  }
}


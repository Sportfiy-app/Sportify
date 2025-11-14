import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/subscription_plan_controller.dart';

class SubscriptionPlanView extends GetView<SubscriptionPlanController> {
  const SubscriptionPlanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const designWidth = 375.0;
          final width = constraints.maxWidth.isFinite ? constraints.maxWidth : MediaQuery.of(context).size.width;
          final scale = (width / designWidth).clamp(0.88, 1.08);

          return SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 16 * scale),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TopBar(scale: scale),
                  SizedBox(height: 18 * scale),
                  _HeroBanner(scale: scale),
                  SizedBox(height: 24 * scale),
                  _CurrentPlanCard(scale: scale),
                  SizedBox(height: 28 * scale),
                  _PlansSection(scale: scale),
                  SizedBox(height: 28 * scale),
                  _ComparisonSection(scale: scale),
                  SizedBox(height: 28 * scale),
                  _SpecialOffersSection(scale: scale),
                  SizedBox(height: 28 * scale),
                  _PaymentMethodsSection(scale: scale),
                  SizedBox(height: 28 * scale),
                  _FaqSection(scale: scale),
                  SizedBox(height: 28 * scale),
                  _TestimonialsSection(scale: scale),
                  SizedBox(height: 28 * scale),
                  _SupportSection(scale: scale),
                  SizedBox(height: 28 * scale),
                  _FinalCtaSection(scale: scale),
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
          onTap: Get.back,
        ),
        Expanded(
          child: Center(
            child: Text(
              'Abonnements',
              style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 19 * scale, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        _CircleButton(
          scale: scale,
          icon: Icons.close_rounded,
          onTap: Get.back,
        ),
      ],
    );
  }
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 24 * scale, horizontal: 16 * scale),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
          begin: Alignment(-0.35, 0.35),
          end: Alignment(0.35, 1.06),
        ),
        borderRadius: BorderRadius.circular(24 * scale),
        boxShadow: [
          BoxShadow(color: const Color(0x33176BFF), blurRadius: 24 * scale, offset: Offset(0, 18 * scale)),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 64 * scale,
            height: 64 * scale,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(Icons.emoji_events_rounded, size: 32 * scale, color: Colors.white),
          ),
          SizedBox(height: 16 * scale),
          Text(
            'Passez au niveau supérieur',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 22 * scale, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 10 * scale),
          Text(
            'Débloquez toutes les fonctionnalités premium et rejoignez la communauté Sportify Pro.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.9), fontSize: 14 * scale, height: 1.55),
          ),
        ],
      ),
    );
  }
}

class _CurrentPlanCard extends StatelessWidget {
  const _CurrentPlanCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48 * scale,
                height: 48 * scale,
                decoration: BoxDecoration(
                  color: const Color(0x1916A34A),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(Icons.verified_user_rounded, color: const Color(0xFF16A34A), size: 22 * scale),
              ),
              SizedBox(width: 14 * scale),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Plan Gratuit', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
                    SizedBox(height: 4 * scale),
                    Text('Actuellement actif', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('0€', style: GoogleFonts.poppins(color: const Color(0xFF16A34A), fontSize: 22 * scale, fontWeight: FontWeight.w700)),
                  Text('/mois', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
                ],
              ),
            ],
          ),
          SizedBox(height: 20 * scale),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Réservations ce mois', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
                  const Spacer(),
                  Text('3/5', style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 13 * scale, fontWeight: FontWeight.w600)),
                ],
              ),
              SizedBox(height: 10 * scale),
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: SizedBox(
                  height: 8 * scale,
                  child: LinearProgressIndicator(
                    value: 0.6,
                    backgroundColor: const Color(0xFFE2E8F0),
                    color: const Color(0xFF16A34A),
                  ),
                ),
              ),
              SizedBox(height: 8 * scale),
              Row(
                children: [
                  Text('Limite atteinte dans 2 réservations', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
                  const Spacer(),
                  Text('60%', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PlansSection extends GetView<SubscriptionPlanController> {
  const _PlansSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Plans disponibles', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 20 * scale, fontWeight: FontWeight.w700)),
            const Spacer(),
            _BillingToggle(scale: scale),
          ],
        ),
        SizedBox(height: 22 * scale),
        ...controller.plans.map(
          (plan) => Padding(
            padding: EdgeInsets.only(bottom: 18 * scale),
            child: _PlanCard(scale: scale, plan: plan),
          ),
        ),
      ],
    );
  }
}

class _BillingToggle extends GetView<SubscriptionPlanController> {
  const _BillingToggle({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: EdgeInsets.all(4 * scale),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: controller.billingCycles.map((cycle) {
            final selected = controller.selectedBillingCycleId.value == cycle.id;
            return Expanded(
              child: GestureDetector(
                onTap: () => controller.selectedBillingCycleId.value = cycle.id,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: EdgeInsets.symmetric(vertical: 10 * scale),
                  decoration: BoxDecoration(
                    color: selected ? const Color(0xFF176BFF) : Colors.transparent,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Column(
                    children: [
                      Text(
                        cycle.label,
                        style: GoogleFonts.inter(
                          color: selected ? Colors.white : const Color(0xFF475569),
                          fontSize: 13.5 * scale,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (cycle.badge != null) ...[
                        SizedBox(height: 4 * scale),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8 * scale, vertical: 4 * scale),
                          decoration: BoxDecoration(
                            color: selected ? Colors.white.withValues(alpha: 0.18) : const Color(0xFFE2F5E8),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            cycle.badge!,
                            style: GoogleFonts.inter(
                              color: selected ? Colors.white : const Color(0xFF16A34A),
                              fontSize: 11 * scale,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _PlanCard extends GetView<SubscriptionPlanController> {
  const _PlanCard({required this.scale, required this.plan});

  final double scale;
  final SubscriptionPlan plan;

  @override
  Widget build(BuildContext context) {
    final price = plan.pricePerCycle[controller.selectedBillingCycleId.value] ?? plan.pricePerCycle.values.first;
    final isDisabled = plan.disabled;

    return Container(
      padding: EdgeInsets.all(24 * scale),
      decoration: BoxDecoration(
        color: plan.highlighted ? const Color(0xFFFFFBF1) : Colors.white,
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: plan.highlighted ? const Color(0xFFFFE08A) : const Color(0xFFE2E8F0), width: plan.highlighted ? 1.8 : 1),
        boxShadow: plan.highlighted
            ? [
                BoxShadow(color: plan.accentColor.withValues(alpha: 0.18), blurRadius: 28 * scale, offset: Offset(0, 18 * scale)),
              ]
            : [
                BoxShadow(color: const Color(0x19176BFF), blurRadius: 22 * scale, offset: Offset(0, 12 * scale)),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (plan.badge != null)
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                decoration: BoxDecoration(
                  color: plan.accentColor,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  plan.badge!,
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 12 * scale, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56 * scale,
                height: 56 * scale,
                decoration: BoxDecoration(
                  color: plan.highlighted ? plan.accentColor : plan.accentColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14 * scale),
                ),
                alignment: Alignment.center,
                child: Icon(Icons.sports_martial_arts_rounded, color: plan.highlighted ? Colors.white : plan.accentColor, size: 26 * scale),
              ),
              SizedBox(width: 16 * scale),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(plan.title, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 20 * scale, fontWeight: FontWeight.w700)),
                    SizedBox(height: 6 * scale),
                    Text(plan.description, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20 * scale),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(price.primary, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 34 * scale, fontWeight: FontWeight.w700)),
              if (price.secondary != null) ...[
                SizedBox(width: 8 * scale),
                Padding(
                  padding: EdgeInsets.only(bottom: 4 * scale),
                  child: Text(price.secondary!, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale)),
                ),
              ],
              const Spacer(),
            ],
          ),
          if (price.note != null) ...[
            SizedBox(height: 6 * scale),
            Text(price.note!, style: GoogleFonts.inter(color: const Color(0xFF16A34A), fontSize: 12.5 * scale)),
          ],
          SizedBox(height: 20 * scale),
          Column(
            children: plan.features.map((feature) {
              return Padding(
                padding: EdgeInsets.only(bottom: 12 * scale),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      feature.enabled ? Icons.check_circle_rounded : Icons.cancel_rounded,
                      size: 18 * scale,
                      color: feature.enabled ? const Color(0xFF16A34A) : const Color(0xFFD1D5DB),
                    ),
                    SizedBox(width: 12 * scale),
                    Expanded(
                      child: Text(
                        feature.title,
                        style: GoogleFonts.inter(
                          color: feature.enabled ? const Color(0xFF0B1220) : const Color(0xFF9CA3AF),
                          fontSize: 13.5 * scale,
                          fontWeight: feature.enabled ? FontWeight.w500 : FontWeight.w400,
                          decoration: feature.enabled ? null : TextDecoration.lineThrough,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 16 * scale),
          SizedBox(
            width: double.infinity,
            child: plan.highlighted
                ? ElevatedButton(
                    onPressed: isDisabled ? null : () => Get.snackbar('Sportify Pro', 'Activation de votre essai gratuit'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF176BFF),
                      padding: EdgeInsets.symmetric(vertical: 16 * scale),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
                    ),
                    child: Text(plan.ctaLabel, style: GoogleFonts.poppins(color: Colors.white, fontSize: 15 * scale, fontWeight: FontWeight.w600)),
                  )
                : OutlinedButton(
                    onPressed: isDisabled ? null : () => Get.snackbar(plan.title, 'Sélection du plan ${plan.title}'),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16 * scale),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
                      side: BorderSide(color: isDisabled ? const Color(0xFFD1D5DB) : const Color(0xFFE2E8F0)),
                      backgroundColor: isDisabled ? const Color(0xFFF3F4F6) : Colors.white,
                    ),
                    child: Text(
                      plan.ctaLabel,
                      style: GoogleFonts.poppins(
                        color: isDisabled ? const Color(0xFF9CA3AF) : const Color(0xFF0B1220),
                        fontSize: 15 * scale,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _ComparisonSection extends GetView<SubscriptionPlanController> {
  const _ComparisonSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Comparaison détaillée', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 20 * scale, fontWeight: FontWeight.w700)),
          SizedBox(height: 20 * scale),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16 * scale),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 14 * scale),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: const Color(0xFFE2E8F0))),
                  ),
                  child: Row(
                    children: [
                      _TableHeaderCell(scale: scale, text: 'Fonctionnalités', flex: 2),
                      _TableHeaderCell(scale: scale, text: 'Free'),
                      _TableHeaderCell(scale: scale, text: 'Basic'),
                      _TableHeaderCell(scale: scale, text: 'Pro', highlight: true),
                    ],
                  ),
                ),
                ...controller.comparisonTable.map(
                  (row) => Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: const Color(0xFFE2E8F0))),
                      gradient: row.highlightPro
                          ? LinearGradient(
                              colors: [
                                Colors.white,
                                const Color(0x14176BFF),
                                Colors.white,
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            )
                          : null,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 18 * scale),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(row.label, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 13.5 * scale)),
                        ),
                        Expanded(child: Center(child: _ComparisonValue(value: row.freeLabel, scale: scale))),
                        Expanded(child: Center(child: _ComparisonValue(value: row.basicLabel, scale: scale))),
                        Expanded(
                          child: Center(
                            child: _ComparisonValue(
                              value: row.proLabel,
                              scale: scale,
                              highlight: row.highlightPro,
                            ),
                          ),
                        ),
                      ],
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

class _SpecialOffersSection extends GetView<SubscriptionPlanController> {
  const _SpecialOffersSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Offres spéciales', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 20 * scale, fontWeight: FontWeight.w700)),
        SizedBox(height: 16 * scale),
        Column(
          children: controller.specialOffers.map((offer) {
            return Padding(
              padding: EdgeInsets.only(bottom: 16 * scale),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20 * scale),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: offer.gradient),
                  borderRadius: BorderRadius.circular(20 * scale),
                  boxShadow: [
                    BoxShadow(color: offer.gradient.last.withValues(alpha: 0.3), blurRadius: 18 * scale, offset: Offset(0, 14 * scale)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 48 * scale,
                          height: 48 * scale,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.18),
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Icon(Icons.local_offer_rounded, color: offer.iconColor, size: 24 * scale),
                        ),
                        SizedBox(width: 16 * scale),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(offer.title, style: GoogleFonts.poppins(color: Colors.white, fontSize: 16 * scale, fontWeight: FontWeight.w600)),
                              SizedBox(height: 6 * scale),
                              Text(
                                offer.description,
                                style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.92), fontSize: 13.5 * scale, height: 1.45),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (offer.priceLabel != null) ...[
                      SizedBox(height: 16 * scale),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            offer.priceLabel!,
                            style: GoogleFonts.poppins(color: Colors.white, fontSize: 20 * scale, fontWeight: FontWeight.w700),
                          ),
                          if (offer.previousPriceLabel != null)
                            Text(
                              offer.previousPriceLabel!,
                              style: GoogleFonts.inter(
                                color: Colors.white.withValues(alpha: 0.7),
                                fontSize: 13 * scale,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                        ],
                      ),
                    ],
                    if (offer.buttonLabel != null) ...[
                      SizedBox(height: 18 * scale),
                      SizedBox(
                        width: offer.priceLabel == null ? 120 * scale : double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Get.snackbar(offer.title, 'En savoir plus sur ${offer.title}'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: offer.gradient.last,
                            padding: EdgeInsets.symmetric(vertical: 12 * scale),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                          ),
                          child: Text(offer.buttonLabel!, style: GoogleFonts.inter(fontSize: 14 * scale, fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _PaymentMethodsSection extends GetView<SubscriptionPlanController> {
  const _PaymentMethodsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Moyens de paiement', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 20 * scale, fontWeight: FontWeight.w700)),
          SizedBox(height: 18 * scale),
          Wrap(
            spacing: 16 * scale,
            runSpacing: 16 * scale,
            children: controller.paymentMethods.map((method) {
              return Container(
                width: (343 * scale - 16 * scale) / 2,
                padding: EdgeInsets.all(18 * scale),
                decoration: BoxDecoration(
                  color: method.background,
                  borderRadius: BorderRadius.circular(16 * scale),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 36 * scale,
                      height: 36 * scale,
                      decoration: BoxDecoration(
                        color: method.accentColor.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(10 * scale),
                      ),
                      alignment: Alignment.center,
                      child: Icon(Icons.payments_rounded, color: method.accentColor, size: 20 * scale),
                    ),
                    SizedBox(width: 12 * scale),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(method.title, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
                          SizedBox(height: 4 * scale),
                          Text(method.description, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 20 * scale),
          Container(
            padding: EdgeInsets.all(16 * scale),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(16 * scale),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                Icon(Icons.lock_outline_rounded, color: const Color(0xFF16A34A), size: 20 * scale),
                SizedBox(width: 12 * scale),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Paiements 100% sécurisés', style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 13.5 * scale, fontWeight: FontWeight.w600)),
                      SizedBox(height: 4 * scale),
                      Text('Chiffrement SSL 256-bit et conformité PCI DSS', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
                    ],
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

class _FaqSection extends GetView<SubscriptionPlanController> {
  const _FaqSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Questions fréquentes', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 20 * scale, fontWeight: FontWeight.w700)),
          SizedBox(height: 16 * scale),
          ...controller.faqs.map((faq) {
            return Container(
              margin: EdgeInsets.only(bottom: 12 * scale),
              padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 16 * scale),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(14 * scale),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      faq.question,
                      style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w600, height: 1.5),
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down_rounded, color: const Color(0xFF475569), size: 20 * scale),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _TestimonialsSection extends GetView<SubscriptionPlanController> {
  const _TestimonialsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Ce qu’en disent nos utilisateurs Pro',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 20 * scale, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 20 * scale),
          Column(
            children: controller.testimonials.map((testimonial) {
              return Container(
                margin: EdgeInsets.only(bottom: 16 * scale),
                padding: EdgeInsets.all(18 * scale),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(16 * scale),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 48 * scale,
                          height: 48 * scale,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9999),
                            image: const DecorationImage(
                              image: NetworkImage('https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=200&q=60'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 12 * scale),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(testimonial.name, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600)),
                              SizedBox(height: 4 * scale),
                              Text(testimonial.role, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
                            ],
                          ),
                        ),
                        Row(
                          children: List.generate(
                            testimonial.rating,
                            (index) => Padding(
                              padding: EdgeInsets.only(left: index == 0 ? 0 : 4 * scale),
                              child: Icon(Icons.star_rounded, color: const Color(0xFFFFB800), size: 18 * scale),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12 * scale),
                    Text(
                      '“${testimonial.message}”',
                      style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13.5 * scale, height: 1.55),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _SupportSection extends GetView<SubscriptionPlanController> {
  const _SupportSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final stats = controller.supportStats;

    return Container(
      padding: EdgeInsets.all(22 * scale),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)]),
        borderRadius: BorderRadius.circular(24 * scale),
        boxShadow: [
          BoxShadow(color: const Color(0x33176BFF), blurRadius: 28 * scale, offset: Offset(0, 18 * scale)),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 64 * scale,
            height: 64 * scale,
            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.18), shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Icon(Icons.headset_mic_rounded, color: Colors.white, size: 32 * scale),
          ),
          SizedBox(height: 16 * scale),
          Text('Besoin d’aide ?', style: GoogleFonts.poppins(color: Colors.white, fontSize: 20 * scale, fontWeight: FontWeight.w700)),
          SizedBox(height: 8 * scale),
          Text(
            'Notre équipe support est là pour t’accompagner dans le choix de ton abonnement.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.9), fontSize: 13.5 * scale, height: 1.55),
          ),
          SizedBox(height: 22 * scale),
          _SupportContactButton(
            scale: scale,
            label: 'Chat en direct',
            icon: Icons.chat_rounded,
            background: Colors.white,
            foreground: const Color(0xFF176BFF),
            onTap: () => Get.snackbar('Support', 'Ouverture du chat en direct'),
          ),
          SizedBox(height: 12 * scale),
          _SupportContactButton(
            scale: scale,
            label: 'Envoyer un email',
            icon: Icons.mail_outline_rounded,
            background: Colors.white.withValues(alpha: 0.18),
            foreground: Colors.white,
            onTap: () => Get.snackbar('Support', 'support@sportify.com'),
          ),
          SizedBox(height: 24 * scale),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _SupportMetric(scale: scale, label: 'Support Pro', value: stats.supportHours),
              _SupportMetric(scale: scale, label: 'Temps de réponse', value: stats.responseTime),
              _SupportMetric(scale: scale, label: 'Satisfaction', value: stats.satisfaction),
            ],
          ),
        ],
      ),
    );
  }
}

class _FinalCtaSection extends StatelessWidget {
  const _FinalCtaSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Prêt à passer Pro ?', textAlign: TextAlign.center, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 22 * scale, fontWeight: FontWeight.w700)),
        SizedBox(height: 10 * scale),
        Text(
          'Rejoins plus de 10 000 sportifs qui ont choisi Sportify Pro pour améliorer leur expérience sport.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale, height: 1.55),
        ),
        SizedBox(height: 22 * scale),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => Get.snackbar('Sportify Pro', 'Lancement de l’essai gratuit'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF176BFF),
              padding: EdgeInsets.symmetric(vertical: 16 * scale),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16 * scale)),
            ),
            icon: Icon(Icons.flash_on_rounded, color: Colors.white, size: 20 * scale),
            label: Text('Commencer l’essai gratuit Pro', style: GoogleFonts.poppins(color: Colors.white, fontSize: 15 * scale, fontWeight: FontWeight.w700)),
          ),
        ),
        SizedBox(height: 12 * scale),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => Get.snackbar('Plan gratuit', 'Vous restez sur le plan gratuit pour l’instant.'),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16 * scale),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16 * scale)),
              side: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            child: Text('Continuer avec le plan gratuit', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600)),
          ),
        ),
        SizedBox(height: 16 * scale),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline_rounded, color: const Color(0xFF16A34A), size: 14 * scale),
            SizedBox(width: 6 * scale),
            Text('Aucun engagement • Annulation facile • Support 24/7', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
          ],
        ),
      ],
    );
  }
}

class _TableHeaderCell extends StatelessWidget {
  const _TableHeaderCell({required this.scale, required this.text, this.flex = 1, this.highlight = false});

  final double scale;
  final String text;
  final int flex;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
          color: highlight ? const Color(0xFFFFB800) : const Color(0xFF475569),
          fontSize: 13 * scale,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _ComparisonValue extends StatelessWidget {
  const _ComparisonValue({required this.value, required this.scale, this.highlight = false});

  final String value;
  final double scale;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final color = highlight ? const Color(0xFFFFB800) : const Color(0xFF0B1220);
    return Text(
      value,
      style: GoogleFonts.inter(color: color, fontSize: 13 * scale, fontWeight: highlight ? FontWeight.w700 : FontWeight.w500),
    );
  }
}

class _SupportContactButton extends StatelessWidget {
  const _SupportContactButton({required this.scale, required this.label, required this.icon, required this.background, required this.foreground, required this.onTap});

  final double scale;
  final String label;
  final IconData icon;
  final Color background;
  final Color foreground;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          foregroundColor: foreground,
          padding: EdgeInsets.symmetric(vertical: 14 * scale),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
          elevation: 0,
        ),
        icon: Icon(icon, size: 18 * scale),
        label: Text(label, style: GoogleFonts.inter(fontSize: 14 * scale, fontWeight: FontWeight.w600)),
      ),
    );
  }
}

class _SupportMetric extends StatelessWidget {
  const _SupportMetric({required this.scale, required this.label, required this.value});

  final double scale;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: GoogleFonts.poppins(color: Colors.white, fontSize: 20 * scale, fontWeight: FontWeight.w700)),
        SizedBox(height: 4 * scale),
        Text(label, style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.8), fontSize: 12 * scale)),
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
        width: 40 * scale,
        height: 40 * scale,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8 * scale, offset: Offset(0, 4 * scale)),
          ],
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: const Color(0xFF0B1220), size: 18 * scale),
      ),
    );
  }
}


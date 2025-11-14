import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/register_controller.dart';

class RegisterSubscriptionChoiceView extends GetView<RegisterController> {
  const RegisterSubscriptionChoiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const designWidth = 375.0;
          final maxWidth = constraints.hasBoundedWidth
              ? constraints.maxWidth
              : MediaQuery.of(context).size.width;
          final scale = (maxWidth / designWidth).clamp(0.85, 1.1);

          return SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 16 * scale),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: designWidth * scale),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _HeaderBar(scale: scale),
                      SizedBox(height: 20 * scale),
                      _HeroBanner(scale: scale),
                      SizedBox(height: 24 * scale),
                      _HighlightRow(scale: scale),
                      SizedBox(height: 24 * scale),
                      _PlanCards(scale: scale),
                      SizedBox(height: 24 * scale),
                      _TrialBanner(scale: scale),
                      SizedBox(height: 24 * scale),
                      _FeatureComparison(scale: scale),
                      SizedBox(height: 24 * scale),
                      _Testimonials(scale: scale),
                      SizedBox(height: 24 * scale),
                      _Transparency(scale: scale),
                      SizedBox(height: 24 * scale),
                      _FaqSection(scale: scale),
                      SizedBox(height: 24 * scale),
                      _CommunityStats(scale: scale),
                      SizedBox(height: 32 * scale),
                      _FinalCta(scale: scale),
                      SizedBox(height: 16 * scale),
                      _LegalText(scale: scale),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _HeaderBar extends GetView<RegisterController> {
  const _HeaderBar({required this.scale});

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
          child: Text(
            'Choisissez votre abonnement',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: const Color(0xFF0B1220),
              fontSize: 18 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        TextButton(
          onPressed: controller.skipPremiumOffer,
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF475569),
            textStyle: GoogleFonts.inter(
              fontSize: 14 * scale,
              fontWeight: FontWeight.w500,
            ),
          ),
          child: const Text('Plus tard'),
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
      padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 24 * scale),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF176BFF), Color(0xFF0F5AE0), Color(0xFF176BFF)],
          begin: Alignment(-0.4, 0.8),
          end: Alignment(0.8, -0.6),
        ),
        borderRadius: BorderRadius.circular(24 * scale),
        boxShadow: [
          BoxShadow(
            color: const Color(0x33176BFF),
            blurRadius: 32 * scale,
            offset: Offset(0, 20 * scale),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 72 * scale,
            height: 72 * scale,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(36 * scale),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 18 * scale,
                  offset: Offset(0, 12 * scale),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Icon(Icons.workspace_premium_rounded, color: const Color(0xFF176BFF), size: 36 * scale),
          ),
          SizedBox(height: 20 * scale),
          Text(
            'Sportify Premium',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 26 * scale,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8 * scale),
          Text(
            'Débloquez toutes les fonctionnalités et rejoignez la communauté des sportifs engagés.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 16 * scale,
              height: 1.45,
            ),
          ),
          SizedBox(height: 18 * scale),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 8 * scale),
            decoration: BoxDecoration(
              color: const Color(0x33FFB800),
              borderRadius: BorderRadius.circular(9999),
              border: Border.all(color: const Color(0x4CFFB800)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.local_fire_department_rounded, color: Colors.white, size: 16 * scale),
                SizedBox(width: 8 * scale),
                Text(
                  'Offre de lancement',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14 * scale,
                    fontWeight: FontWeight.w600,
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

class _HighlightRow extends StatelessWidget {
  const _HighlightRow({required this.scale});

  final double scale;

  final _items = const [
    _Highlight(icon: Icons.calendar_today_rounded, title: 'Réservations', subtitle: 'illimitées', color: Color(0xFF16A34A)),
    _Highlight(icon: Icons.forum_outlined, title: 'Chat privé', subtitle: 'sans limite', color: Color(0xFF176BFF)),
    _Highlight(icon: Icons.query_stats_rounded, title: 'Stats avancées', subtitle: 'analyses pro', color: Color(0xFFFFB800)),
    _Highlight(icon: Icons.workspace_premium_rounded, title: 'Priorité', subtitle: 'sur les terrains', color: Color(0xFF0EA5E9)),
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12 * scale,
      runSpacing: 12 * scale,
      children: _items
          .map(
            (item) => SizedBox(
              width: (343 * scale - 12 * scale) / 2,
              child: _HighlightCard(scale: scale, highlight: item),
            ),
          )
          .toList(),
    );
  }
}

class _PlanCards extends GetView<RegisterController> {
  const _PlanCards({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final plans = [
      _Plan(
        id: 'monthly',
        title: 'Mensuel',
        description: 'Flexibilité maximale',
        price: '7,99 €',
        cadence: '/mois',
        badge: null,
        savings: null,
        details: ['Facturation mensuelle', 'Annulez à tout moment'],
      ),
      _Plan(
        id: 'annual',
        title: 'Annuel',
        description: 'Le plus avantageux',
        price: '82,99 €',
        cadence: '/an',
        badge: 'RECOMMANDÉ',
        savings: 'Soit 6,91 €/mois • -17%',
        details: ['Facturation annuelle', 'Économisez 17%'],
        popular: true,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choisissez votre formule',
          style: GoogleFonts.poppins(
            color: const Color(0xFF0B1220),
            fontSize: 20 * scale,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16 * scale),
        ...plans.map(
          (plan) => Padding(
            padding: EdgeInsets.only(bottom: plan == plans.last ? 0 : 16 * scale),
            child: Obx(
              () {
                final selected = controller.selectedPremiumPlan.value == plan.id;
                return GestureDetector(
                  onTap: () => controller.selectPremiumPlan(plan.id),
                  child: _PlanCard(scale: scale, plan: plan, selected: selected),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _TrialBanner extends StatelessWidget {
  const _TrialBanner({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 18 * scale),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF16A34A), Color(0xFF16A34A)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(color: const Color(0x4C16A34A)),
      ),
      child: Column(
        children: [
          Text(
            'Essai gratuit de 7 jours',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8 * scale),
          Text(
            'Profitez de toutes les fonctionnalités Premium gratuitement, annulez quand vous voulez.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 14 * scale,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureComparison extends StatelessWidget {
  const _FeatureComparison({required this.scale});

  final double scale;

  final _features = const [
    _ComparisonFeature(
      title: 'Réservations illimitées',
      description: 'Réservez autant de terrains que vous voulez',
      freeValue: '3 / mois',
      premiumValue: 'illimitées',
    ),
    _ComparisonFeature(
      title: 'Chat privé illimité',
      description: 'Communiquez avec tous les sportifs',
      freeValue: '10 / jour',
      premiumValue: 'illimité',
    ),
    _ComparisonFeature(
      title: 'Statistiques avancées',
      description: 'Analyses détaillées de vos performances',
      freeValue: 'Basic',
      premiumValue: 'Pro',
    ),
    _ComparisonFeature(
      title: 'Priorité réservation',
      description: 'Accès prioritaire aux créneaux populaires',
      freeValue: 'Normal',
      premiumValue: 'VIP',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pourquoi choisir Premium ?',
          style: GoogleFonts.poppins(
            color: const Color(0xFF0B1220),
            fontSize: 18 * scale,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16 * scale),
        ..._features.map(
          (feature) => Padding(
            padding: EdgeInsets.only(bottom: feature == _features.last ? 0 : 12 * scale),
            child: _FeatureCard(scale: scale, feature: feature),
          ),
        ),
      ],
    );
  }
}

class _Testimonials extends StatelessWidget {
  const _Testimonials({required this.scale});

  final double scale;

  final _testimonials = const [
    _Testimonial(
      name: 'Marc L.',
      role: 'Capitaine club tennis',
      quote:
          '« Premium a révolutionné ma façon de jouer. Les réservations prioritaires me permettent toujours de trouver un créneau ! »',
      avatarUrl: 'https://images.unsplash.com/photo-1521412644187-c49fa049e84d?auto=format&fit=crop&w=200&q=60',
    ),
    _Testimonial(
      name: 'Sarah K.',
      role: 'Coach fitness',
      quote:
          '« Les statistiques avancées m’aident énormément à progresser. Je recommande vivement l’abonnement annuel. »',
      avatarUrl: 'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?auto=format&fit=crop&w=200&q=60',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ce que disent nos utilisateurs',
          style: GoogleFonts.poppins(
            color: const Color(0xFF0B1220),
            fontSize: 18 * scale,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16 * scale),
        ..._testimonials.map(
          (testimonial) => Padding(
            padding: EdgeInsets.only(bottom: testimonial == _testimonials.last ? 0 : 12 * scale),
            child: _TestimonialCard(scale: scale, testimonial: testimonial),
          ),
        ),
      ],
    );
  }
}

class _Transparency extends StatelessWidget {
  const _Transparency({required this.scale});

  final double scale;

  final _items = const [
    'Sans engagement – annulez à tout moment',
    'Renouvellement automatique désactivable',
    'Remboursement sous 7 jours si non satisfait',
    'Pas de frais cachés ni surprise',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Transparence totale',
          style: GoogleFonts.poppins(
            color: const Color(0xFF0B1220),
            fontSize: 18 * scale,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16 * scale),
        ..._items.map(
          (item) => Padding(
            padding: EdgeInsets.only(bottom: item == _items.last ? 0 : 12 * scale),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.check_circle_outline, color: const Color(0xFF16A34A), size: 18 * scale),
                SizedBox(width: 12 * scale),
                Expanded(
                  child: Text(
                    item,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF475569),
                      fontSize: 14 * scale,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FaqSection extends StatelessWidget {
  const _FaqSection({required this.scale});

  final double scale;

  final _questions = const [
    'Puis-je changer de plan à tout moment ?',
    'L’essai gratuit est-il vraiment gratuit ?',
    'Comment annuler mon abonnement ?',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Questions fréquentes',
          style: GoogleFonts.poppins(
            color: const Color(0xFF0B1220),
            fontSize: 18 * scale,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16 * scale),
        ..._questions.map(
          (question) => Container(
            margin: EdgeInsets.only(bottom: question == _questions.last ? 0 : 12 * scale),
            padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 16 * scale),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12 * scale),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    question,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF0B1220),
                      fontSize: 14 * scale,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(Icons.keyboard_arrow_down_rounded, color: const Color(0xFF9CA3AF), size: 18 * scale),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CommunityStats extends StatelessWidget {
  const _CommunityStats({required this.scale});

  final double scale;

  final _stats = const [
    _Stat(label: 'Utilisateurs Premium', value: '50K+', color: Color(0xFF176BFF)),
    _Stat(label: 'Note App Store', value: '4.9★', color: Color(0xFF16A34A)),
    _Stat(label: 'Satisfaction', value: '98%', color: Color(0xFFFFB800)),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: _stats
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
                      SizedBox(height: 4 * scale),
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
        SizedBox(height: 16 * scale),
        Text(
          'Rejoignez la communauté des sportifs Premium',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: const Color(0xFF475569),
            fontSize: 14 * scale,
          ),
        ),
      ],
    );
  }
}

class _FinalCta extends GetView<RegisterController> {
  const _FinalCta({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: controller.selectedPremiumPlan.value.isEmpty || controller.isSubmitting.value
                  ? null
                  : controller.subscribePremium,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 18 * scale),
                backgroundColor: controller.selectedPremiumPlan.value.isEmpty
                    ? const Color(0xFF94A3B8)
                    : const Color(0xFF176BFF),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scale)),
                disabledBackgroundColor: const Color(0xFF94A3B8),
              ),
              child: controller.isSubmitting.value
                  ? SizedBox(
                      height: 20 * scale,
                      width: 20 * scale,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      controller.selectedPremiumPlan.value.isEmpty
                          ? 'Sélectionnez un plan'
                          : 'Commencer l\'essai gratuit',
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
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: controller.restorePremiumSubscription,
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16 * scale),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scale)),
              side: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            child: Text(
              'Restaurer un abonnement',
              style: GoogleFonts.inter(
                color: const Color(0xFF475569),
                fontSize: 14 * scale,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _LegalText extends StatelessWidget {
  const _LegalText({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'L’abonnement sera facturé via votre compte App Store / Google Play. Le renouvellement automatique peut être désactivé à tout moment dans les paramètres de votre compte. Les abonnements ne peuvent pas être annulés pendant la période active.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: const Color(0xFF475569),
            fontSize: 12 * scale,
            height: 1.6,
          ),
        ),
        SizedBox(height: 12 * scale),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 24 * scale,
          children: [
            _LinkButton(text: 'Politique de confidentialité', scale: scale),
            _LinkButton(text: 'Conditions générales', scale: scale),
          ],
        ),
        SizedBox(height: 12 * scale),
        Text(
          '© 2024 Sportify - Tous droits réservés',
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
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(9999),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: const Color(0xFF0B1220), size: 18 * scale),
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({required this.scale, required this.plan, required this.selected});

  final double scale;
  final _Plan plan;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final gradient = plan.popular == true && selected
        ? const LinearGradient(
            colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          )
        : null;

    return Container(
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        gradient: gradient,
        color: gradient == null ? Colors.white : null,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(
          color: selected ? const Color(0xFF176BFF) : const Color(0xFFE2E8F0),
          width: selected ? 2 : 1,
        ),
        boxShadow: selected
            ? [
                BoxShadow(
                  color: const Color(0x33176BFF),
                  blurRadius: 24 * scale,
                  offset: Offset(0, 14 * scale),
                ),
              ]
            : null,
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
                  color: const Color(0xFFFFB800),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12 * scale),
                    bottomLeft: Radius.circular(12 * scale),
                  ),
                ),
                child: Text(
                  plan.badge!,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 12 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 24 * scale,
                height: 24 * scale,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selected ? Colors.white : const Color(0xFFE2E8F0),
                    width: selected ? 4 : 2,
                  ),
                ),
              ),
              SizedBox(width: 16 * scale),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plan.title,
                      style: GoogleFonts.poppins(
                        color: selected ? Colors.white : const Color(0xFF0B1220),
                        fontSize: 18 * scale,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4 * scale),
                    Text(
                      plan.description,
                      style: GoogleFonts.inter(
                        color: selected ? Colors.white.withValues(alpha: 0.9) : const Color(0xFF475569),
                        fontSize: 14 * scale,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    plan.price,
                    style: GoogleFonts.poppins(
                      color: selected ? Colors.white : const Color(0xFF0B1220),
                      fontSize: 22 * scale,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    plan.cadence,
                    style: GoogleFonts.inter(
                      color: selected ? Colors.white.withValues(alpha: 0.8) : const Color(0xFF475569),
                      fontSize: 14 * scale,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (plan.savings != null) ...[
            SizedBox(height: 12 * scale),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
              decoration: BoxDecoration(
                color: selected ? Colors.white.withValues(alpha: 0.2) : const Color(0x30FFB800),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Text(
                plan.savings!,
                style: GoogleFonts.inter(
                  color: selected ? Colors.white : const Color(0xFF16A34A),
                  fontSize: 12 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
          SizedBox(height: 12 * scale),
          ...plan.details.map(
            (detail) => Padding(
              padding: EdgeInsets.only(bottom: detail == plan.details.last ? 0 : 6 * scale),
              child: Row(
                children: [
                  Icon(Icons.check_circle_outline, size: 16 * scale, color: selected ? Colors.white : const Color(0xFF16A34A)),
                  SizedBox(width: 8 * scale),
                  Expanded(
                    child: Text(
                      detail,
                      style: GoogleFonts.inter(
                        color: selected ? Colors.white.withValues(alpha: 0.9) : const Color(0xFF475569),
                        fontSize: 13 * scale,
                      ),
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

class _HighlightCard extends StatelessWidget {
  const _HighlightCard({required this.scale, required this.highlight});

  final double scale;
  final _Highlight highlight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36 * scale,
            height: 36 * scale,
            decoration: BoxDecoration(
              color: highlight.color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12 * scale),
            ),
            alignment: Alignment.center,
            child: Icon(highlight.icon, color: highlight.color, size: 20 * scale),
          ),
          SizedBox(height: 12 * scale),
          Text(
            highlight.title,
            style: GoogleFonts.inter(
              color: const Color(0xFF0B1220),
              fontSize: 14 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4 * scale),
          Text(
            highlight.subtitle,
            style: GoogleFonts.inter(
              color: const Color(0xFF475569),
              fontSize: 12 * scale,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({required this.scale, required this.feature});

  final double scale;
  final _ComparisonFeature feature;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48 * scale,
                height: 48 * scale,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16 * scale),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                alignment: Alignment.center,
                child: Icon(Icons.check_rounded, color: const Color(0xFF176BFF), size: 22 * scale),
              ),
              SizedBox(width: 16 * scale),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feature.title,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF0B1220),
                        fontSize: 16 * scale,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4 * scale),
                    Text(
                      feature.description,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF475569),
                        fontSize: 14 * scale,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16 * scale),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gratuit',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF475569),
                        fontSize: 12 * scale,
                      ),
                    ),
                    SizedBox(height: 4 * scale),
                    Text(
                      feature.freeValue,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF64748B),
                        fontSize: 14 * scale,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Premium',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF176BFF),
                        fontSize: 12 * scale,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4 * scale),
                    Text(
                      feature.premiumValue,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF176BFF),
                        fontSize: 14 * scale,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  const _TestimonialCard({required this.scale, required this.testimonial});

  final double scale;
  final _Testimonial testimonial;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 16 * scale,
            offset: Offset(0, 8 * scale),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40 * scale,
                height: 40 * scale,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9999),
                  image: DecorationImage(image: NetworkImage(testimonial.avatarUrl), fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 12 * scale),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    testimonial.name,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF0B1220),
                      fontSize: 14 * scale,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2 * scale),
                  Text(
                    testimonial.role,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF475569),
                      fontSize: 12 * scale,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: List.generate(
                  5,
                  (index) => Padding(
                    padding: EdgeInsets.only(left: index == 0 ? 0 : 4 * scale),
                    child: Icon(
                      Icons.star_rounded,
                      color: const Color(0xFFFFB800),
                      size: 16 * scale,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12 * scale),
          Text(
            testimonial.quote,
            style: GoogleFonts.inter(
              color: const Color(0xFF475569),
              fontSize: 14 * scale,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _LinkButton extends StatelessWidget {
  const _LinkButton({required this.text, required this.scale});

  final String text;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.inter(
        color: const Color(0xFF176BFF),
        fontSize: 12 * scale,
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.underline,
      ),
    );
  }
}

class _Highlight {
  const _Highlight({required this.icon, required this.title, required this.subtitle, required this.color});

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
}

class _Plan {
  const _Plan({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.cadence,
    required this.details,
    this.badge,
    this.savings,
    this.popular,
  });

  final String id;
  final String title;
  final String description;
  final String price;
  final String cadence;
  final List<String> details;
  final String? badge;
  final String? savings;
  final bool? popular;
}

class _ComparisonFeature {
  const _ComparisonFeature({
    required this.title,
    required this.description,
    required this.freeValue,
    required this.premiumValue,
  });

  final String title;
  final String description;
  final String freeValue;
  final String premiumValue;
}

class _Testimonial {
  const _Testimonial({required this.name, required this.role, required this.quote, required this.avatarUrl});

  final String name;
  final String role;
  final String quote;
  final String avatarUrl;
}

class _Stat {
  const _Stat({required this.label, required this.value, required this.color});

  final String label;
  final String value;
  final Color color;
}

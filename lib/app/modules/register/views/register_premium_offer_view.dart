import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/register_controller.dart';

class RegisterPremiumOfferView extends GetView<RegisterController> {
  const RegisterPremiumOfferView({super.key});

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
                      _Header(scale: scale),
                      SizedBox(height: 20 * scale),
                      _HeroSection(scale: scale),
                      SizedBox(height: 24 * scale),
                      _BenefitsCard(scale: scale),
                      SizedBox(height: 24 * scale),
                      _PricingHighlight(scale: scale),
                      SizedBox(height: 24 * scale),
                      _PlanSelector(scale: scale),
                      SizedBox(height: 24 * scale),
                      _SocialProof(scale: scale),
                      SizedBox(height: 24 * scale),
                      _ReassuranceRow(scale: scale),
                      SizedBox(height: 24 * scale),
                      _FooterActions(scale: scale),
                      SizedBox(height: 16 * scale),
                      _FinePrint(scale: scale),
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

class _Header extends GetView<RegisterController> {
  const _Header({required this.scale});

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
            'Abonnement Premium',
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

class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 180 * scale,
          height: 180 * scale,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF176BFF), Color(0xFF0F5AE0), Color(0xFFFFB800)],
              begin: Alignment(-0.35, 0.35),
              end: Alignment(0.35, 1.06),
            ),
            borderRadius: BorderRadius.circular(120 * scale),
            boxShadow: [
              BoxShadow(
                color: const Color(0x40176BFF),
                blurRadius: 36 * scale,
                offset: Offset(0, 24 * scale),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 150 * scale,
                height: 150 * scale,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100 * scale),
                ),
              ),
              Icon(Icons.workspace_premium_rounded, size: 72 * scale, color: const Color(0xFF176BFF)),
            ],
          ),
        ),
        SizedBox(height: 24 * scale),
        Text(
          'Passez Premium',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: const Color(0xFF0B1220),
            fontSize: 30 * scale,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 12 * scale),
        Text(
          'Faites-en davantage avec notre abonnement Premium.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: const Color(0xFF475569),
            fontSize: 18 * scale,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}

class _BenefitsCard extends StatelessWidget {
  const _BenefitsCard({required this.scale});

  final double scale;

  static const _benefits = [
    _Benefit(
      title: 'Créer des clubs privés',
      subtitle: 'Organisez vos communautés sportives exclusives',
      icon: Icons.groups_rounded,
      iconColor: Color(0xFF16A34A),
    ),
    _Benefit(
      title: 'Accès illimité aux événements',
      subtitle: 'Participez à tous les tournois et compétitions',
      icon: Icons.emoji_events_outlined,
      iconColor: Color(0xFFFFB800),
    ),
    _Benefit(
      title: 'Réservations prioritaires',
      subtitle: 'Réservez en premier sur les terrains populaires',
      icon: Icons.event_available_outlined,
      iconColor: Color(0xFF0EA5E9),
    ),
    _Benefit(
      title: 'Support VIP',
      subtitle: 'Assistance prioritaire 7j/7 par chat et téléphone',
      icon: Icons.support_agent,
      iconColor: Color(0xFFEF4444),
    ),
    _Benefit(
      title: 'Statistiques avancées',
      subtitle: 'Analyses détaillées de vos performances',
      icon: Icons.query_stats_rounded,
      iconColor: Color(0xFF16A34A),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 24 * scale,
            offset: Offset(0, 12 * scale),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tous les avantages Premium',
            style: GoogleFonts.poppins(
              color: const Color(0xFF0B1220),
              fontSize: 20 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 20 * scale),
          ..._benefits.map(
            (benefit) => Padding(
              padding: EdgeInsets.only(bottom: benefit == _benefits.last ? 0 : 16 * scale),
              child: _BenefitTile(scale: scale, benefit: benefit),
            ),
          ),
        ],
      ),
    );
  }
}

class _BenefitTile extends StatelessWidget {
  const _BenefitTile({required this.scale, required this.benefit});

  final double scale;
  final _Benefit benefit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44 * scale,
          height: 44 * scale,
          decoration: BoxDecoration(
            color: benefit.iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12 * scale),
          ),
          alignment: Alignment.center,
          child: Icon(benefit.icon, color: benefit.iconColor, size: 22 * scale),
        ),
        SizedBox(width: 16 * scale),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                benefit.title,
                style: GoogleFonts.inter(
                  color: const Color(0xFF0B1220),
                  fontSize: 16 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4 * scale),
              Text(
                benefit.subtitle,
                style: GoogleFonts.inter(
                  color: const Color(0xFF475569),
                  fontSize: 14 * scale,
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

class _PricingHighlight extends StatelessWidget {
  const _PricingHighlight({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24 * scale, vertical: 28 * scale),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0x33176BFF), width: 2),
        gradient: const LinearGradient(
          colors: [Color(0xFFFFFFFF), Color(0xFFEFF4FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0x40176BFF),
            blurRadius: 18 * scale,
            offset: Offset(0, 12 * scale),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'À partir de',
            style: GoogleFonts.inter(
              color: const Color(0xFF475569),
              fontSize: 18 * scale,
            ),
          ),
          SizedBox(height: 12 * scale),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: GoogleFonts.poppins(color: const Color(0xFF0B1220)),
              children: [
                TextSpan(text: '19,90', style: TextStyle(fontSize: 48 * scale, fontWeight: FontWeight.w700)),
                TextSpan(text: ' €', style: TextStyle(fontSize: 24 * scale, fontWeight: FontWeight.w600)),
                TextSpan(
                  text: ' / mois',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF475569),
                    fontSize: 18 * scale,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12 * scale),
          Text(
            'Sans engagement',
            style: GoogleFonts.inter(
              color: const Color(0xFF16A34A),
              fontSize: 14 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanSelector extends GetView<RegisterController> {
  const _PlanSelector({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final plans = [
      _PlanOption(
        id: 'monthly',
        title: 'Mensuel',
        subtitle: 'Flexible et sans engagement',
        price: '19,90€',
        priceNote: 'par mois',
      ),
      _PlanOption(
        id: 'annual',
        title: 'Annuel',
        subtitle: 'Économisez 40 %',
        price: '14,90€',
        priceNote: 'par mois',
        crossedPrice: '23,90€',
        isHighlighted: true,
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
            padding: EdgeInsets.only(bottom: plan == plans.last ? 0 : 12 * scale),
            child: Obx(
              () {
                final selected = controller.selectedPremiumPlan.value == plan.id;
                return GestureDetector(
                  onTap: () => controller.selectPremiumPlan(plan.id),
                  child: Container(
                    padding: EdgeInsets.all(20 * scale),
                    decoration: BoxDecoration(
                      gradient: plan.isHighlighted && selected
                          ? const LinearGradient(
                              colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            )
                          : null,
                      color: plan.isHighlighted && selected ? null : Colors.white,
                      borderRadius: BorderRadius.circular(16 * scale),
                      border: Border.all(
                        color: selected ? const Color(0xFF176BFF) : const Color(0xFFE2E8F0),
                        width: selected ? 2 : 1,
                      ),
                      boxShadow: plan.isHighlighted && selected
                          ? [
                              BoxShadow(
                                color: const Color(0x33176BFF),
                                blurRadius: 20 * scale,
                                offset: Offset(0, 14 * scale),
                              ),
                            ]
                          : null,
                    ),
                    child: Row(
                      children: [
                        _PlanIcon(scale: scale, highlighted: plan.isHighlighted && selected),
                        SizedBox(width: 16 * scale),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                plan.title,
                                style: GoogleFonts.inter(
                                  color: selected ? Colors.white : const Color(0xFF0B1220),
                                  fontSize: 16 * scale,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 4 * scale),
                              Text(
                                plan.subtitle,
                                style: GoogleFonts.inter(
                                  color: selected
                                      ? Colors.white.withValues(alpha: 0.85)
                                      : const Color(0xFF475569),
                                  fontSize: 14 * scale,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (plan.crossedPrice != null)
                              Text(
                                plan.crossedPrice!,
                                style: GoogleFonts.inter(
                                  color: selected
                                      ? Colors.white.withValues(alpha: 0.6)
                                      : const Color(0xFF64748B),
                                  fontSize: 12 * scale,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            Text(
                              plan.price,
                              style: GoogleFonts.poppins(
                                color: selected ? Colors.white : const Color(0xFF0B1220),
                                fontSize: 18 * scale,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              plan.priceNote,
                              style: GoogleFonts.inter(
                                color: selected
                                    ? Colors.white.withValues(alpha: 0.75)
                                    : const Color(0xFF475569),
                                fontSize: 12 * scale,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _SocialProof extends StatelessWidget {
  const _SocialProof({required this.scale});

  final double scale;

  static const _avatars = [
    'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=200&q=60',
    'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=200&q=60',
    'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=60',
    'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?auto=format&fit=crop&w=200&q=60',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24 * scale),
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
        children: [
          Text(
            'Rejoignez +50 000 sportifs',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: const Color(0xFF0B1220),
              fontSize: 18 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12 * scale),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ..._avatars.map(
                (url) => Padding(
                  padding: EdgeInsets.only(right: 8 * scale),
                  child: Container(
                    width: 32 * scale,
                    height: 32 * scale,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9999),
                      border: Border.all(color: Colors.white, width: 2 * scale),
                      image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
              Container(
                width: 32 * scale,
                height: 32 * scale,
                decoration: BoxDecoration(
                  color: const Color(0xFF176BFF),
                  borderRadius: BorderRadius.circular(9999),
                  border: Border.all(color: Colors.white, width: 2 * scale),
                ),
                alignment: Alignment.center,
                child: Text(
                  '+9K',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 12 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16 * scale),
          Text(
            '« Sportify Premium a transformé ma façon de pratiquer le sport. Les réservations prioritaires et les clubs privés sont parfaits ! »',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF475569),
              fontSize: 14 * scale,
              height: 1.55,
            ),
          ),
          SizedBox(height: 12 * scale),
          Text(
            'Marie L. • Coach Tennis',
            style: GoogleFonts.inter(
              color: const Color(0xFF0B1220),
              fontSize: 14 * scale,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReassuranceRow extends StatelessWidget {
  const _ReassuranceRow({required this.scale});

  final double scale;

  final _items = const [
    _Reassurance(icon: Icons.lock_outline, label: 'Paiement sécurisé'),
    _Reassurance(icon: Icons.cancel_outlined, label: 'Résiliation facile'),
    _Reassurance(icon: Icons.support_agent, label: 'Support 24/7'),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _items
          .map(
            (item) => Expanded(
              child: Column(
                children: [
                  Container(
                    width: 48 * scale,
                    height: 48 * scale,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5FF),
                      borderRadius: BorderRadius.circular(12 * scale),
                    ),
                    alignment: Alignment.center,
                    child: Icon(item.icon, color: const Color(0xFF176BFF), size: 24 * scale),
                  ),
                  SizedBox(height: 12 * scale),
                  Text(
                    item.label,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF475569),
                      fontSize: 12 * scale,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _FooterActions extends GetView<RegisterController> {
  const _FooterActions({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: controller.openSubscriptionChoice,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 18 * scale),
              backgroundColor: const Color(0xFF176BFF),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scale)),
            ),
            child: Text(
              'Voir les abonnements',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(height: 12 * scale),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: controller.skipPremiumOffer,
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16 * scale),
              side: const BorderSide(color: Color(0xFFE2E8F0)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scale)),
            ),
            child: Text(
              'Continuer sans abonnement',
              style: GoogleFonts.inter(
                color: const Color(0xFF475569),
                fontSize: 14 * scale,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        SizedBox(height: 12 * scale),
        TextButton(
          onPressed: controller.restorePremiumSubscription,
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF475569),
            textStyle: GoogleFonts.inter(
              fontSize: 14 * scale,
              fontWeight: FontWeight.w500,
            ),
          ),
          child: const Text('Restaurer un abonnement'),
        ),
      ],
    );
  }
}

class _FinePrint extends StatelessWidget {
  const _FinePrint({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Le paiement sera débité lors de la confirmation. L’abonnement se renouvelle automatiquement sauf annulation au moins 24h avant la fin de la période.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: const Color(0xFF475569),
            fontSize: 12 * scale,
            height: 1.55,
          ),
        ),
        SizedBox(height: 12 * scale),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 24 * scale,
          children: [
            _LinkText(text: 'Politique de confidentialité', scale: scale),
            _LinkText(text: 'CGV', scale: scale),
          ],
        ),
      ],
    );
  }
}

class _PlanIcon extends StatelessWidget {
  const _PlanIcon({required this.scale, required this.highlighted});

  final double scale;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48 * scale,
      height: 48 * scale,
      decoration: BoxDecoration(
        color: highlighted ? Colors.white.withValues(alpha: 0.2) : const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(12 * scale),
      ),
      alignment: Alignment.center,
      child: Icon(Icons.star_rate_rounded, color: highlighted ? Colors.white : const Color(0xFF176BFF), size: 24 * scale),
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

class _LinkText extends StatelessWidget {
  const _LinkText({required this.text, required this.scale});

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

class _Benefit {
  const _Benefit({required this.title, required this.subtitle, required this.icon, required this.iconColor});

  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
}

class _PlanOption {
  const _PlanOption({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.priceNote,
    this.crossedPrice,
    this.isHighlighted = false,
  });

  final String id;
  final String title;
  final String subtitle;
  final String price;
  final String priceNote;
  final String? crossedPrice;
  final bool isHighlighted;
}

class _Reassurance {
  const _Reassurance({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

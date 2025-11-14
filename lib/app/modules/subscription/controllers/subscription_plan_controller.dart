import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscriptionPlanController extends GetxController {
  final RxString selectedBillingCycleId = 'monthly'.obs;

  List<BillingCycle> get billingCycles => const [
        BillingCycle(id: 'monthly', label: 'Mensuel'),
        BillingCycle(id: 'annual', label: 'Annuel', badge: '-20%'),
      ];

  List<SubscriptionPlan> get plans => const [
        SubscriptionPlan(
          id: 'pro',
          title: 'Sportify Pro',
          description: 'Pour les sportifs réguliers',
          badge: 'POPULAIRE',
          accentColor: Color(0xFFFFB800),
          pricePerCycle: {
            'monthly': PriceLabel(primary: '9,99€', secondary: '/mois', note: 'Première semaine gratuite'),
            'annual': PriceLabel(primary: '95,90€', secondary: '/an', note: 'Économisez 20% par rapport au mensuel'),
          },
          features: [
            PlanFeature(title: 'Réservations illimitées'),
            PlanFeature(title: 'Accès prioritaire aux créneaux populaires'),
            PlanFeature(title: 'Annulation gratuite jusqu’à 2h avant'),
            PlanFeature(title: 'Matching premium avec joueurs pro'),
            PlanFeature(title: 'Statistiques avancées & coaching IA'),
            PlanFeature(title: 'Support prioritaire 24/7'),
          ],
          ctaLabel: 'Commencer l’essai gratuit',
          highlighted: true,
        ),
        SubscriptionPlan(
          id: 'basic',
          title: 'Sportify Basic',
          description: 'Pour débuter',
          accentColor: Color(0xFF176BFF),
          pricePerCycle: {
            'monthly': PriceLabel(primary: '4,99€', secondary: '/mois'),
            'annual': PriceLabel(primary: '49,90€', secondary: '/an'),
          },
          features: [
            PlanFeature(title: '15 réservations par mois'),
            PlanFeature(title: 'Annulation 24h à l’avance'),
            PlanFeature(title: 'Matching standard'),
            PlanFeature(title: 'Statistiques avancées', enabled: false),
          ],
          ctaLabel: 'Choisir ce plan',
        ),
        SubscriptionPlan(
          id: 'free',
          title: 'Sportify Free',
          description: 'Plan actuel',
          accentColor: Color(0xFF16A34A),
          pricePerCycle: {
            'monthly': PriceLabel(primary: '0€', secondary: '/mois'),
            'annual': PriceLabel(primary: '0€', secondary: '/an'),
          },
          features: [
            PlanFeature(title: '5 réservations par mois'),
            PlanFeature(title: 'Matching de base'),
            PlanFeature(title: 'Annulation gratuite', enabled: false),
          ],
          ctaLabel: 'Plan actuel',
          disabled: true,
        ),
      ];

  List<ComparisonRow> get comparisonTable => const [
        ComparisonRow(label: 'Réservations/mois', freeLabel: '5', basicLabel: '15', proLabel: 'Illimitées', highlightPro: true),
        ComparisonRow(label: 'Annulation gratuite', freeLabel: '✕', basicLabel: '24h', proLabel: '2h', highlightPro: true),
        ComparisonRow(label: 'Accès prioritaire', freeLabel: '✕', basicLabel: '✕', proLabel: '✔'),
        ComparisonRow(label: 'Matching premium', freeLabel: '✕', basicLabel: '✕', proLabel: '✔'),
        ComparisonRow(label: 'Statistiques IA', freeLabel: '✕', basicLabel: '✕', proLabel: '✔'),
        ComparisonRow(label: 'Support prioritaire', freeLabel: '✕', basicLabel: '✕', proLabel: '✔'),
      ];

  List<SpecialOffer> get specialOffers => const [
        SpecialOffer(
          title: 'Réduction Étudiant',
          description: '50% de réduction sur tous les plans avec ton email .edu',
          buttonLabel: 'Vérifier',
          gradient: [Color(0xFF0EA5E9), Color(0xFF176BFF)],
          iconColor: Colors.white,
        ),
        SpecialOffer(
          title: 'Plan Famille',
          description: 'Jusqu’à 6 comptes Pro pour 19,99€/mois',
          buttonLabel: 'Découvrir',
          gradient: [Color(0xFF16A34A), Color(0xFF059669)],
          iconColor: Colors.white,
        ),
        SpecialOffer(
          title: 'Abonnement Annuel',
          description: 'Économise 20% en payant à l’année',
          priceLabel: '95,90€',
          previousPriceLabel: '119,88€',
          gradient: [Color(0xFFFFB800), Color(0xFFF97316)],
          iconColor: Colors.white,
        ),
      ];

  List<FaqItem> get faqs => const [
        FaqItem(question: 'Puis-je annuler mon abonnement à tout moment ?'),
        FaqItem(question: 'L’essai gratuit se renouvelle-t-il automatiquement ?'),
        FaqItem(question: 'Puis-je changer de plan en cours d’abonnement ?'),
        FaqItem(question: 'Y a-t-il des frais cachés ?'),
        FaqItem(question: 'Comment fonctionne le remboursement ?'),
      ];

  List<Testimonial> get testimonials => const [
        Testimonial(
          name: 'Marie L.',
          role: 'Membre Pro depuis 8 mois',
          message:
              'Sportify Pro a révolutionné ma pratique du tennis. L’accès prioritaire aux courts et le matching avec des joueurs de mon niveau, c’est parfait !',
          rating: 5,
        ),
        Testimonial(
          name: 'Thomas R.',
          role: 'Membre Pro depuis 1 an',
          message:
              'Les statistiques IA m’ont aidé à améliorer mon jeu de foot. Je recommande vivement l’abonnement Pro à tous les sportifs sérieux.',
          rating: 5,
        ),
        Testimonial(
          name: 'Sophie M.',
          role: 'Membre Pro depuis 6 mois',
          message:
              'L’annulation gratuite jusqu’à 2h avant m’a sauvée plusieurs fois ! Et le support client est vraiment réactif.',
          rating: 5,
        ),
      ];

  List<PaymentMethod> get paymentMethods => const [
        PaymentMethod(
          title: 'Carte bancaire',
          description: 'Visa, Mastercard',
          background: Color(0xFFFFFFFF),
          accentColor: Color(0xFF3B82F6),
        ),
        PaymentMethod(
          title: 'Apple Pay',
          description: 'Paiement sécurisé',
          background: Color(0xFFFFFFFF),
          accentColor: Color(0xFF0B1220),
        ),
        PaymentMethod(
          title: 'Google Pay',
          description: 'Paiement rapide',
          background: Color(0xFFFFFFFF),
          accentColor: Color(0xFF22C55E),
        ),
        PaymentMethod(
          title: 'PayPal',
          description: 'Compte PayPal',
          background: Color(0xFFFFFFFF),
          accentColor: Color(0xFF2563EB),
        ),
      ];

  SupportStats get supportStats => const SupportStats(
        supportHours: '24/7',
        responseTime: '<2min',
        satisfaction: '98%',
      );
}

class BillingCycle {
  const BillingCycle({
    required this.id,
    required this.label,
    this.badge,
  });

  final String id;
  final String label;
  final String? badge;
}

class SubscriptionPlan {
  const SubscriptionPlan({
    required this.id,
    required this.title,
    required this.description,
    required this.accentColor,
    required this.pricePerCycle,
    required this.features,
    required this.ctaLabel,
    this.badge,
    this.highlighted = false,
    this.disabled = false,
  });

  final String id;
  final String title;
  final String description;
  final Color accentColor;
  final Map<String, PriceLabel> pricePerCycle;
  final List<PlanFeature> features;
  final String ctaLabel;
  final String? badge;
  final bool highlighted;
  final bool disabled;
}

class PriceLabel {
  const PriceLabel({
    required this.primary,
    this.secondary,
    this.note,
  });

  final String primary;
  final String? secondary;
  final String? note;
}

class PlanFeature {
  const PlanFeature({
    required this.title,
    this.enabled = true,
  });

  final String title;
  final bool enabled;
}

class ComparisonRow {
  const ComparisonRow({
    required this.label,
    required this.freeLabel,
    required this.basicLabel,
    required this.proLabel,
    this.highlightPro = false,
  });

  final String label;
  final String freeLabel;
  final String basicLabel;
  final String proLabel;
  final bool highlightPro;
}

class SpecialOffer {
  const SpecialOffer({
    required this.title,
    required this.description,
    required this.gradient,
    required this.iconColor,
    this.buttonLabel,
    this.priceLabel,
    this.previousPriceLabel,
  });

  final String title;
  final String description;
  final List<Color> gradient;
  final Color iconColor;
  final String? buttonLabel;
  final String? priceLabel;
  final String? previousPriceLabel;
}

class FaqItem {
  const FaqItem({required this.question});

  final String question;
}

class Testimonial {
  const Testimonial({
    required this.name,
    required this.role,
    required this.message,
    required this.rating,
  });

  final String name;
  final String role;
  final String message;
  final int rating;
}

class PaymentMethod {
  const PaymentMethod({
    required this.title,
    required this.description,
    required this.background,
    required this.accentColor,
  });

  final String title;
  final String description;
  final Color background;
  final Color accentColor;
}

class SupportStats {
  const SupportStats({
    required this.supportHours,
    required this.responseTime,
    required this.satisfaction,
  });

  final String supportHours;
  final String responseTime;
  final String satisfaction;
}


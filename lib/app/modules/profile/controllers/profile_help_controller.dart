import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileHelpController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  final List<String> suggestedTags = const [
    'réservation',
    'paiement',
    'compte',
    'match',
    'premium',
    'notifications',
  ];

  final List<HelpCategory> categories = const [
    HelpCategory(
      icon: Icons.event_available_outlined,
      iconColor: Color(0xFF176BFF),
      title: 'Réservations',
      articlesCount: 12,
    ),
    HelpCategory(
      icon: Icons.payments_outlined,
      iconColor: Color(0xFF16A34A),
      title: 'Paiements',
      articlesCount: 8,
    ),
    HelpCategory(
      icon: Icons.person_outline_rounded,
      iconColor: Color(0xFFFFB800),
      title: 'Compte',
      articlesCount: 15,
    ),
    HelpCategory(
      icon: Icons.groups_2_outlined,
      iconColor: Color(0xFF0EA5E9),
      title: 'Communauté',
      articlesCount: 9,
    ),
    HelpCategory(
      icon: Icons.lock_outline_rounded,
      iconColor: Color(0xFFEF4444),
      title: 'Sécurité',
      articlesCount: 6,
    ),
    HelpCategory(
      icon: Icons.settings_suggest_outlined,
      iconColor: Color(0xFF6366F1),
      title: 'Paramètres',
      articlesCount: 11,
    ),
  ];

  final List<HelpQuickAction> quickActions = const [
    HelpQuickAction(
      icon: Icons.chat_bubble_outline_rounded,
      background: Color(0x19176BFF),
      iconColor: Color(0xFF176BFF),
      title: 'Chat en direct',
      subtitle: 'Disponible 24h/7j',
      statusLabel: 'En ligne',
      statusColor: Color(0xFF16A34A),
    ),
    HelpQuickAction(
      icon: Icons.call_outlined,
      background: Color(0x19FFB800),
      iconColor: Color(0xFFFFB800),
      title: 'Nous appeler',
      subtitle: '+33 1 23 45 67 89',
      statusLabel: '9h-18h',
      statusColor: Color(0xFFF59E0B),
    ),
  ];

  final List<FaqItem> faqs = [
    FaqItem(
      question: 'Comment annuler une réservation ?',
      answer:
          'Vous pouvez annuler votre réservation jusqu\'à 24h avant le créneau réservé. Rendez-vous dans "Mes réservations" puis sélectionnez "Annuler". Un remboursement sera effectué selon nos conditions.',
    ),
    FaqItem(
      question: 'Puis-je modifier mon niveau de jeu ?',
      answer:
          'Oui, allez dans Profil > Mes sports et ajustez votre niveau. Cela améliorera la précision du matching avec d\'autres joueurs de votre niveau.',
    ),
    FaqItem(
      question: 'Comment inviter des amis ?',
      answer:
          'Utilisez le bouton "Inviter" dans votre profil ou partagez votre code de parrainage. Vos amis reçoivent 10€ de crédit à l’inscription et vous aussi.',
    ),
    FaqItem(
      question: 'Que faire si un terrain est fermé ?',
      answer:
          'Contactez immédiatement notre support via le chat. Nous vous proposerons un terrain alternatif ou un remboursement intégral dans les plus brefs délais.',
    ),
    FaqItem(
      question: 'Comment fonctionne le système de notation ?',
      answer:
          'Après chaque match, notez vos partenaires sur leur ponctualité, fair-play et niveau. Ces notes aident à améliorer le matching futur.',
    ),
  ];

  final RxSet<int> expandedFaqIndexes = <int>{}.obs;

  final List<HelpArticle> popularArticles = const [
    HelpArticle(
      icon: Icons.location_on_outlined,
      iconColor: Color(0xFF176BFF),
      title: 'Comment trouver des terrains près de chez moi',
      description: 'Guide complet pour utiliser la géolocalisation et les filtres de recherche.',
      viewsLabel: '1.2k vues',
      helpfulLabel: '89% utile',
    ),
    HelpArticle(
      icon: Icons.groups_outlined,
      iconColor: Color(0xFF16A34A),
      title: 'Organiser un match avec des inconnus',
      description: 'Conseils pour créer des matchs réussis et rencontrer de nouveaux partenaires.',
      viewsLabel: '956 vues',
      helpfulLabel: '92% utile',
    ),
    HelpArticle(
      icon: Icons.stars_rounded,
      iconColor: Color(0xFFFFB800),
      title: 'Système de points et récompenses',
      description: 'Découvrez comment gagner des points et débloquer des avantages exclusifs.',
      viewsLabel: '743 vues',
      helpfulLabel: '87% utile',
    ),
  ];

  final List<HelpVideo> tutorialVideos = const [
    HelpVideo(
      title: 'Première réservation sur Sportify',
      description: 'Guide pas à pas pour effectuer votre première réservation de terrain.',
      duration: '3:42',
      viewsLabel: '2.1k vues • Il y a 1 semaine',
      ratingLabel: '4.8',
      gradient: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
    ),
    HelpVideo(
      title: 'Optimiser son profil joueur',
      description: 'Conseils pour créer un profil attractif et trouver plus facilement des partenaires.',
      duration: '5:18',
      viewsLabel: '1.8k vues • Il y a 3 jours',
      ratingLabel: '4.9',
      gradient: [Color(0xFF16A34A), Color(0xFF0EA5E9)],
    ),
  ];

  final List<CommunityPost> communityPosts = const [
    CommunityPost(
      author: 'Marc_Tennis',
      timeAgo: 'Il y a 2h',
      title: 'Meilleurs terrains de tennis à Paris ?',
      replies: 12,
      likes: 8,
      tagLabel: 'Tennis',
      tagColor: Color(0xFFFFB800),
    ),
    CommunityPost(
      author: 'Sarah_Foot',
      timeAgo: 'Il y a 4h',
      title: 'Comment améliorer son niveau rapidement ?',
      replies: 23,
      likes: 15,
      tagLabel: 'Football',
      tagColor: Color(0xFF16A34A),
    ),
  ];

  final List<ContactMethod> contactMethods = const [
    ContactMethod(
      icon: Icons.alternate_email_rounded,
      iconColor: Color(0xFF0EA5E9),
      title: 'Twitter',
      detail: '@SportifySupport',
    ),
    ContactMethod(
      icon: Icons.facebook_outlined,
      iconColor: Color(0xFF176BFF),
      title: 'Facebook',
      detail: 'Sportify Official',
    ),
    ContactMethod(
      icon: Icons.email_outlined,
      iconColor: Color(0xFFEF4444),
      title: 'Email',
      detail: 'support@sportify.app',
    ),
  ];

  final List<ServiceStatus> serviceStatuses = const [
    ServiceStatus(title: 'Réservations', status: 'Opérationnel', color: Color(0xFF16A34A)),
    ServiceStatus(title: 'Paiements', status: 'Opérationnel', color: Color(0xFF16A34A)),
    ServiceStatus(title: 'Chat & Messages', status: 'Ralentissements', color: Color(0xFFF59E0B)),
    ServiceStatus(title: 'Matching', status: 'Opérationnel', color: Color(0xFF16A34A)),
  ];

  final MaintenanceNotice maintenance = const MaintenanceNotice(
    title: 'Maintenance programmée',
    description: 'Dimanche 3 décembre, 2h-4h du matin. Services temporairement indisponibles.',
  );

  void updateSearch(String value) {
    searchQuery.value = value;
  }

  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
  }

  void toggleFaq(int index) {
    if (expandedFaqIndexes.contains(index)) {
      expandedFaqIndexes.remove(index);
    } else {
      expandedFaqIndexes.add(index);
    }
  }

  void startChat() {
    Get.snackbar('Support', 'Connexion au chat en direct...');
  }

  void callSupport() {
    Get.snackbar('Téléphone', 'Composez le +33 1 23 45 67 89');
  }

  void reportIssue() {
    Get.snackbar('Signalement', 'Formulaire de signalement en cours d’ouverture...');
  }

  void openArticle(HelpArticle article) {
    Get.snackbar(article.title, 'Contenu détaillé prochainement.');
  }

  void playVideo(HelpVideo video) {
    Get.snackbar('Tutoriel vidéo', 'Lecture de "${video.title}"');
  }

  void joinCommunity() {
    Get.snackbar('Communauté', 'Rejoignez la communauté Sportify dès maintenant !');
  }

  void openContact(ContactMethod method) {
    Get.snackbar(method.title, 'Ouverture de ${method.detail}');
  }

  void rateApp() {
    Get.snackbar('Merci !', 'Redirection vers la boutique d’applications.');
  }

  void sendFeedback() {
    Get.snackbar('Feedback', 'Merci pour vos retours, ils nous aident à progresser !');
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}

class HelpQuickAction {
  const HelpQuickAction({
    required this.icon,
    required this.background,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    this.statusLabel,
    this.statusColor,
  });

  final IconData icon;
  final Color background;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String? statusLabel;
  final Color? statusColor;
}

class HelpCategory {
  const HelpCategory({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.articlesCount,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final int articlesCount;
}

class FaqItem {
  FaqItem({required this.question, required this.answer});

  final String question;
  final String answer;
}

class HelpArticle {
  const HelpArticle({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.viewsLabel,
    required this.helpfulLabel,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final String viewsLabel;
  final String helpfulLabel;
}

class HelpVideo {
  const HelpVideo({
    required this.title,
    required this.description,
    required this.duration,
    required this.viewsLabel,
    required this.ratingLabel,
    required this.gradient,
  });

  final String title;
  final String description;
  final String duration;
  final String viewsLabel;
  final String ratingLabel;
  final List<Color> gradient;
}

class CommunityPost {
  const CommunityPost({
    required this.author,
    required this.timeAgo,
    required this.title,
    required this.replies,
    required this.likes,
    required this.tagLabel,
    required this.tagColor,
  });

  final String author;
  final String timeAgo;
  final String title;
  final int replies;
  final int likes;
  final String tagLabel;
  final Color tagColor;
}

class ContactMethod {
  const ContactMethod({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.detail,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String detail;
}

class ServiceStatus {
  const ServiceStatus({
    required this.title,
    required this.status,
    required this.color,
  });

  final String title;
  final String status;
  final Color color;
}

class MaintenanceNotice {
  const MaintenanceNotice({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;
}


import 'package:get/get.dart';

class NotificationsController extends GetxController {
  final RxList<NotificationItem> notifications = <NotificationItem>[
    NotificationItem.comment(
      id: 'notif_001',
      fromName: 'July Doe',
      avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=60',
      messagePreview: '« Salut ! Je suis intéressée pour rejoindre votre match... »',
      referenceTitle: 'Match de football ce soir',
      minutesAgo: 40,
    ),
    NotificationItem.friendRequest(
      id: 'notif_002',
      fromName: 'David Lee',
      avatarUrl: 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=200&q=60',
      messagePreview: 'Salut ! J\'ai vu qu’on joue les mêmes sports. Ça te dit de jouer ensemble ?',
      mutualSports: const ['Football', 'Padel', 'Running'],
      minutesAgo: 60,
    ),
    NotificationItem.bookingConfirmed(
      id: 'notif_003',
      fromName: 'Futsal Indoor 06',
      avatarUrl: null,
      venue: 'Terrain A',
      schedule: 'Aujourd’hui • 18:00 - 19:00',
      priceLabel: '25,00 €',
      minutesAgo: 40,
    ),
    NotificationItem.systemMessage(
      id: 'notif_004',
      fromName: 'David Lee',
      avatarUrl: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=200&q=60',
      body: [
        'Contenu texte généré par le système.',
        'Cette notification contient des informations importantes concernant vos activités récentes.',
      ],
      daysAgo: 5,
    ),
    NotificationItem.friendAccepted(
      id: 'notif_005',
      fromName: 'Marie Claire',
      avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=200&q=60',
      daysAgo: 2,
    ),
    NotificationItem.newMessage(
      id: 'notif_006',
      fromName: 'Alex Martin',
      avatarUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=200&q=60',
      messagePreview: 'Hey ! Le match de demain est toujours d’actualité ? J’ai hâte de jouer avec toi 🏀',
      hoursAgo: 1,
    ),
    NotificationItem.paymentError(
      id: 'notif_007',
      fromName: 'Système Sportify',
      body: [
        'Votre paiement pour la réservation du 15/11 a échoué.',
        'Veuillez mettre à jour votre méthode de paiement.',
      ],
      daysAgo: 3,
    ),
    NotificationItem.reward(
      id: 'notif_008',
      fromName: 'Sportify',
      title: 'Niveau Argent',
      body: [
        'Félicitations ! Vous avez atteint le niveau Argent avec 15 matchs joués ce mois-ci.',
      ],
      weeksAgo: 1,
    ),
    NotificationItem.announcement(
      id: 'notif_009',
      fromName: 'Équipe Sportify',
      title: 'Nouvelle fonctionnalité disponible',
      body: [
        'Découvrez notre système de matchmaking intelligent qui vous propose des partenaires selon votre niveau et vos préférences.',
      ],
      weeksAgo: 1,
    ),
  ].obs;

  final RxString selectedFilter = 'Toutes'.obs;

  final filters = const ['Toutes', 'Non lues', 'Commentaires', 'Amis', 'Réservations', 'Système', 'Récompenses'];

  Iterable<NotificationItem> get filteredNotifications {
    Iterable<NotificationItem> base = notifications;
    switch (selectedFilter.value) {
      case 'Non lues':
        base = base.where((item) => !item.isRead.value);
        break;
      case 'Commentaires':
        base = base.where((item) => item.type == NotificationType.comment);
        break;
      case 'Amis':
        base = base.where((item) => item.type == NotificationType.friendRequest || item.type == NotificationType.friendAccepted);
        break;
      case 'Réservations':
        base = base.where((item) => item.type == NotificationType.bookingConfirmed);
        break;
      case 'Système':
        base = base.where((item) => item.type == NotificationType.system || item.type == NotificationType.paymentError || item.type == NotificationType.announcement);
        break;
      case 'Récompenses':
        base = base.where((item) => item.type == NotificationType.reward);
        break;
      default:
        break;
    }
    return base;
  }

  RxInt get unreadCount => notifications.where((item) => !item.isRead.value).length.obs;

  String formatRelativeTime(NotificationItem item) {
    if (item.minutesAgo != null) {
      final minutes = item.minutesAgo!;
      if (minutes < 1) return 'À l’instant';
      if (minutes < 60) return '${minutes}min';
      final hours = minutes ~/ 60;
      return '${hours}h';
    }
    if (item.hoursAgo != null) {
      return '${item.hoursAgo}h';
    }
    if (item.daysAgo != null) {
      final days = item.daysAgo!;
      if (days == 1) return 'Hier';
      if (days < 7) {
        const weekdays = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
        final weekday = DateTime.now().subtract(Duration(days: days)).weekday - 1;
        return weekdays[weekday];
      }
      return '${DateTime.now().subtract(Duration(days: days)).day}/${DateTime.now().subtract(Duration(days: days)).month.toString().padLeft(2, '0')}';
    }
    if (item.weeksAgo != null) {
      return '${item.weeksAgo}sem';
    }
    return '';
  }

  void selectFilter(String value) {
    selectedFilter.value = value;
  }

  void markAsRead(NotificationItem item) {
    item.isRead.value = true;
  }

  void markAllAsRead() {
    for (final notification in notifications) {
      notification.isRead.value = true;
    }
  }

  void archive(NotificationItem item) {
    notifications.remove(item);
    Get.snackbar('Notification archivée', 'Vous ne recevrez plus de rappel pour cet élément.');
  }

  void openNotification(NotificationItem item) {
    // Placeholder for navigation according to type
    switch (item.type) {
      case NotificationType.comment:
        Get.snackbar('Commentaire', 'Ouvrir l’annonce pour répondre.');
        break;
      case NotificationType.friendRequest:
        acceptFriendRequest(item);
        break;
      case NotificationType.bookingConfirmed:
        Get.snackbar('Réservation', 'Voir la réservation.');
        break;
      case NotificationType.system:
      case NotificationType.paymentError:
      case NotificationType.reward:
      case NotificationType.announcement:
        Get.snackbar('Notification', 'Détails supplémentaires à venir.');
        break;
      case NotificationType.friendAccepted:
      case NotificationType.newMessage:
        Get.snackbar('Conversation', 'Ouvrir le tchat associé.');
        break;
    }
    item.isRead.value = true;
  }

  void acceptFriendRequest(NotificationItem item) {
    Get.snackbar('Demande acceptée', '${item.fromName} est désormais dans vos amis.');
    item.type = NotificationType.friendAccepted;
    item.isRead.value = true;
  }

  void refuseFriendRequest(NotificationItem item) {
    notifications.remove(item);
    Get.snackbar('Demande refusée', 'Vous pourrez la retrouver dans vos archives.');
  }
}

enum NotificationType {
  comment,
  friendRequest,
  bookingConfirmed,
  system,
  friendAccepted,
  newMessage,
  paymentError,
  reward,
  announcement,
}

class NotificationItem {
  NotificationItem._({
    required this.id,
    required this.type,
    required this.fromName,
    this.avatarUrl,
    this.title,
    this.messagePreview,
    this.referenceTitle,
    this.venue,
    this.schedule,
    this.priceLabel,
    this.body,
    this.mutualSports,
    this.minutesAgo,
    this.hoursAgo,
    this.daysAgo,
    this.weeksAgo,
  }) : isRead = false.obs;

  factory NotificationItem.comment({
    required String id,
    required String fromName,
    required String avatarUrl,
    required String messagePreview,
    required String referenceTitle,
    required int minutesAgo,
  }) {
    return NotificationItem._(
      id: id,
      type: NotificationType.comment,
      fromName: fromName,
      avatarUrl: avatarUrl,
      messagePreview: messagePreview,
      referenceTitle: referenceTitle,
      minutesAgo: minutesAgo,
    );
  }

  factory NotificationItem.friendRequest({
    required String id,
    required String fromName,
    required String avatarUrl,
    required String messagePreview,
    required List<String> mutualSports,
    required int minutesAgo,
  }) {
    return NotificationItem._(
      id: id,
      type: NotificationType.friendRequest,
      fromName: fromName,
      avatarUrl: avatarUrl,
      messagePreview: messagePreview,
      mutualSports: mutualSports,
      minutesAgo: minutesAgo,
    );
  }

  factory NotificationItem.bookingConfirmed({
    required String id,
    required String fromName,
    String? avatarUrl,
    required String venue,
    required String schedule,
    required String priceLabel,
    required int minutesAgo,
  }) {
    return NotificationItem._(
      id: id,
      type: NotificationType.bookingConfirmed,
      fromName: fromName,
      avatarUrl: avatarUrl,
      venue: venue,
      schedule: schedule,
      priceLabel: priceLabel,
      minutesAgo: minutesAgo,
    );
  }

  factory NotificationItem.systemMessage({
    required String id,
    required String fromName,
    String? avatarUrl,
    required List<String> body,
    required int daysAgo,
  }) {
    return NotificationItem._(
      id: id,
      type: NotificationType.system,
      fromName: fromName,
      avatarUrl: avatarUrl,
      body: body,
      daysAgo: daysAgo,
    );
  }

  factory NotificationItem.friendAccepted({
    required String id,
    required String fromName,
    required String avatarUrl,
    required int daysAgo,
  }) {
    return NotificationItem._(
      id: id,
      type: NotificationType.friendAccepted,
      fromName: fromName,
      avatarUrl: avatarUrl,
      daysAgo: daysAgo,
    );
  }

  factory NotificationItem.newMessage({
    required String id,
    required String fromName,
    required String avatarUrl,
    required String messagePreview,
    required int hoursAgo,
  }) {
    return NotificationItem._(
      id: id,
      type: NotificationType.newMessage,
      fromName: fromName,
      avatarUrl: avatarUrl,
      messagePreview: messagePreview,
      hoursAgo: hoursAgo,
    );
  }

  factory NotificationItem.paymentError({
    required String id,
    required String fromName,
    required List<String> body,
    required int daysAgo,
  }) {
    return NotificationItem._(
      id: id,
      type: NotificationType.paymentError,
      fromName: fromName,
      body: body,
      daysAgo: daysAgo,
    );
  }

  factory NotificationItem.reward({
    required String id,
    required String fromName,
    required String title,
    required List<String> body,
    required int weeksAgo,
  }) {
    return NotificationItem._(
      id: id,
      type: NotificationType.reward,
      fromName: fromName,
      title: title,
      body: body,
      weeksAgo: weeksAgo,
    );
  }

  factory NotificationItem.announcement({
    required String id,
    required String fromName,
    required String title,
    required List<String> body,
    required int weeksAgo,
  }) {
    return NotificationItem._(
      id: id,
      type: NotificationType.announcement,
      fromName: fromName,
      title: title,
      body: body,
      weeksAgo: weeksAgo,
    );
  }

  final String id;
  NotificationType type;
  final String fromName;
  final String? avatarUrl;
  final String? title;
  final String? messagePreview;
  final String? referenceTitle;
  final String? venue;
  final String? schedule;
  final String? priceLabel;
  final List<String>? body;
  final List<String>? mutualSports;
  final int? minutesAgo;
  final int? hoursAgo;
  final int? daysAgo;
  final int? weeksAgo;
  final RxBool isRead;
}


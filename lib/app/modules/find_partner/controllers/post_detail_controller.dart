import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostDetailController extends GetxController {
  final PageController mediaController = PageController();
  final RxInt currentImageIndex = 0.obs;
  final Rx<ParticipationStatus> participationStatus = ParticipationStatus.none.obs;
  final commentController = TextEditingController();

  final HostProfile hostProfile = const HostProfile(
    name: 'Thomas Martin',
    avatarUrl: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=200&q=60',
    location: 'Nice, Alpes-Maritimes, France',
    distanceLabel: '4 km',
    ratingLabel: '5.0 • 127 matchs',
    levelLabel: 'Niveau Pro',
    verified: true,
    badges: ['Fair-play', 'Organisateur'],
    isOnline: true,
  );

  final EventInfo eventInfo = const EventInfo(
    date: 'Sam. 2 Nov',
    timeRange: '14h30 - 16h30',
    participants: '6/10 confirmés',
    price: '8€ / personne',
  );

  final VenueInfo venueInfo = const VenueInfo(
    name: 'Stade Municipal Jean Médecin',
    address: 'Boulevard Jean Médecin, Nice',
    distanceLabel: '4.6 (89 avis)',
    amenities: ['Parking gratuit', 'Vestiaires'],
    availabilityLabel: 'Disponible',
  );

  final List<TagChipData> tags = const [
    TagChipData(label: 'Football', background: Color(0xFF176BFF), foreground: Colors.white, icon: Icons.sports_soccer_rounded),
    TagChipData(label: 'Sport Collectif', background: Color(0xFF16A34A), foreground: Colors.white, icon: Icons.groups_rounded),
    TagChipData(label: 'Compétitif', background: Color(0xFFFFB800), foreground: Colors.white, icon: Icons.local_fire_department_rounded),
    TagChipData(label: 'Nice', background: Color(0xFF0EA5E9), foreground: Colors.white, icon: Icons.location_on_rounded),
  ];

  final List<QuickActionData> quickActions = const [
    QuickActionData(label: 'Rejoindre', icon: Icons.group_add_rounded, background: Color(0xFF16A34A)),
    QuickActionData(label: 'Calendrier', icon: Icons.event_available_rounded, background: Color(0xFFFFB800)),
    QuickActionData(label: 'Partager', icon: Icons.ios_share_rounded, background: Color(0xFF0EA5E9)),
  ];

  final commentHighlights = const [
    CommentHighlight(
      comment: Comment(
        author: 'Julie Dubois',
        avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=100&q=60',
        messageLines: ['Super ! J\'ai hâte de jouer avec vous. Le terrain a l\'air parfait 👌'],
        timeAgo: 'Il y a 1h',
      ),
      likes: 3,
      replies: 1,
    ),
    CommentHighlight(
      comment: Comment(
        author: 'Marc Lefebvre',
        avatarUrl: 'https://images.unsplash.com/photo-1521412644187-c49fa049e84d?auto=format&fit=crop&w=100&q=60',
        messageLines: ['Est-ce qu\'on peut amener des amis ? J\'ai 2 potes qui cherchent aussi à jouer'],
        timeAgo: 'Il y a 45min',
      ),
      likes: 1,
      replies: 1,
    ),
  ];

  final PostDetail detail = const PostDetail(
    images: [
      'https://images.unsplash.com/photo-1521412644187-c49fa049e84d?auto=format&fit=crop&w=1400&q=60',
      'https://images.unsplash.com/photo-1518081461904-9c3261b51f77?auto=format&fit=crop&w=1400&q=60',
      'https://images.unsplash.com/photo-1517649763962-0c623066013b?auto=format&fit=crop&w=1400&q=60',
    ],
    author: Author(
      name: 'Alexandre M.',
      avatarUrl: 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=200&q=60',
      location: '4 km • Nice, France',
      timeAgo: 'Il y a 2h',
      isUrgent: true,
    ),
    title: 'Qui est chaud pour un foot ce soir ? ⚽',
    sportTag: 'Football',
    likes: 12,
    commentsCount: 25,
    shares: 3,
    views: 20,
    description: [
      'Salut tout le monde ! On cherche des joueurs pour un foot assez régulièrement sur Nice. Niveau intermédiaire, ambiance décontractée mais on aime bien jouer sérieusement.',
      'Ce soir c\'est prévu à 19h au stade des Baumettes. On est déjà 6, il nous manque 4-5 joueurs pour faire deux équipes équilibrées. Qui est motivé ? 🔥',
    ],
    session: SessionDetail(
      dateLabel: "Aujourd'hui, 19h00",
      duration: 'Durée: 2h environ',
      location: 'Stade des Baumettes',
      address: 'Avenue des Baumettes, Nice',
      attendeesLabel: '6/11 joueurs confirmés',
      levelInfo: 'Niveau intermédiaire requis',
    ),
    participants: [
      'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=100&q=60',
      'https://images.unsplash.com/photo-1521412644187-c49fa049e84d?auto=format&fit=crop&w=100&q=60',
      'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=100&q=60',
      'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=100&q=60',
      'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=100&q=60',
    ],
    participantsSummary: 'Thomas, Kevin, Lisa et 3 autres sont intéressés',
    participantsFootnote: '2 personnes ont déjà confirmé leur présence',
  );

  final comments = <Comment>[
    const Comment(
      author: 'Marine L.',
      avatarUrl: 'https://images.unsplash.com/photo-1521412644187-c49fa049e84d?auto=format&fit=crop&w=100&q=60',
      messageLines: ['Super ! Je peux venir avec mon copain,', 'ça fait 2 de plus 👍'],
      timeAgo: 'Il y a 1h',
    ),
    const Comment(
      author: 'Julien P.',
      avatarUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=100&q=60',
      messageLines: ['Quel niveau exactement ? Moi ça fait', 'longtemps que j\'ai pas joué 😅'],
      timeAgo: 'Il y a 45min',
    ),
  ].obs;

  final similarSessions = const [
    SimilarSession(
      imageUrl: 'https://images.unsplash.com/photo-1517649763962-0c623066013b?auto=format&fit=crop&w=600&q=60',
      title: 'Basketball ce weekend',
      venue: 'Salle Omnisports • 2.1 km',
      label: 'Basketball',
      spots: '3 places libres',
      time: 'Sam 14h',
    ),
    SimilarSession(
      imageUrl: 'https://images.unsplash.com/photo-1518081461904-9c3261b51f77?auto=format&fit=crop&w=600&q=60',
      title: 'Tennis en double demain',
      venue: 'Club Tennis Nice • 1.8 km',
      label: 'Tennis',
      spots: '1 place libre',
      time: 'Dim 10h',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    mediaController.addListener(() {
      currentImageIndex.value = mediaController.page?.round() ?? 0;
    });
  }

  @override
  void onClose() {
    mediaController.dispose();
    commentController.dispose();
    super.onClose();
  }

  void join() {
    participationStatus.value = ParticipationStatus.going;
    Get.snackbar('Participation', 'Tu participes à cette session.');
  }

  void maybe() {
    participationStatus.value = ParticipationStatus.maybe;
    Get.snackbar('Participation', 'Tu es notifié en tant que "Peut-être".');
  }

  void toggleLike(Comment comment) {
    Get.snackbar(comment.author, 'Une réaction sera bientôt disponible.');
  }

  void reply(Comment comment) {
    Get.snackbar('Commentaires', 'Réponse à ${comment.author} à venir.');
  }

  void submitComment() {
    final text = commentController.text.trim();
    if (text.isEmpty) return;
    comments.insert(
      0,
      Comment(
        author: 'Vous',
        avatarUrl: 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=100&q=60',
        messageLines: text.split('\n'),
        timeAgo: 'À l’instant',
      ),
    );
    commentController.clear();
  }

  void reportPost() {
    Get.snackbar('Signalement', 'Merci pour votre retour.');
  }

  void openSimilarSession(SimilarSession session) {
    Get.snackbar(session.title, 'Ouverture de la session prochainement.');
  }
}

class PostDetail {
  const PostDetail({
    required this.images,
    required this.author,
    required this.title,
    required this.sportTag,
    required this.likes,
    required this.commentsCount,
    required this.shares,
    required this.views,
    required this.description,
    required this.session,
    required this.participants,
    required this.participantsSummary,
    required this.participantsFootnote,
  });

  final List<String> images;
  final Author author;
  final String title;
  final String sportTag;
  final int likes;
  final int commentsCount;
  final int shares;
  final int views;
  final List<String> description;
  final SessionDetail session;
  final List<String> participants;
  final String participantsSummary;
  final String participantsFootnote;
}

class Author {
  const Author({
    required this.name,
    required this.avatarUrl,
    required this.location,
    required this.timeAgo,
    this.isUrgent = false,
  });

  final String name;
  final String avatarUrl;
  final String location;
  final String timeAgo;
  final bool isUrgent;
}

class SessionDetail {
  const SessionDetail({
    required this.dateLabel,
    required this.duration,
    required this.location,
    required this.address,
    required this.attendeesLabel,
    required this.levelInfo,
  });

  final String dateLabel;
  final String duration;
  final String location;
  final String address;
  final String attendeesLabel;
  final String levelInfo;
}

class Comment {
  const Comment({
    required this.author,
    required this.avatarUrl,
    required this.messageLines,
    required this.timeAgo,
  });

  final String author;
  final String avatarUrl;
  final List<String> messageLines;
  final String timeAgo;
}

class SimilarSession {
  const SimilarSession({
    required this.imageUrl,
    required this.title,
    required this.venue,
    required this.label,
    required this.spots,
    required this.time,
  });

  final String imageUrl;
  final String title;
  final String venue;
  final String label;
  final String spots;
  final String time;
}

enum ParticipationStatus { none, going, maybe }

class HostProfile {
  const HostProfile({
    required this.name,
    required this.avatarUrl,
    required this.location,
    required this.distanceLabel,
    required this.ratingLabel,
    required this.levelLabel,
    required this.verified,
    required this.badges,
    required this.isOnline,
  });

  final String name;
  final String avatarUrl;
  final String location;
  final String distanceLabel;
  final String ratingLabel;
  final String levelLabel;
  final bool verified;
  final List<String> badges;
  final bool isOnline;
}

class EventInfo {
  const EventInfo({
    required this.date,
    required this.timeRange,
    required this.participants,
    required this.price,
  });

  final String date;
  final String timeRange;
  final String participants;
  final String price;
}

class VenueInfo {
  const VenueInfo({
    required this.name,
    required this.address,
    required this.distanceLabel,
    required this.amenities,
    required this.availabilityLabel,
  });

  final String name;
  final String address;
  final String distanceLabel;
  final List<String> amenities;
  final String availabilityLabel;
}

class TagChipData {
  const TagChipData({
    required this.label,
    required this.background,
    required this.foreground,
    this.icon,
  });

  final String label;
  final Color background;
  final Color foreground;
  final IconData? icon;
}

class QuickActionData {
  const QuickActionData({
    required this.label,
    required this.icon,
    required this.background,
  });

  final String label;
  final IconData icon;
  final Color background;
}

class CommentHighlight {
  const CommentHighlight({
    required this.comment,
    required this.likes,
    required this.replies,
  });

  final Comment comment;
  final int likes;
  final int replies;
}

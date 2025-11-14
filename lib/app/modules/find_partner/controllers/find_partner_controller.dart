import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

import '../../../data/api/api_exception.dart';
import '../../../data/friends/friends_repository.dart';
import '../../../data/messages/messages_repository.dart';
import '../../../data/users/users_repository.dart';
import '../../../routes/app_routes.dart';

class FindPartnerController extends GetxController {
  FindPartnerController(this._friendsRepository, this._messagesRepository, this._usersRepository);

  final FriendsRepository _friendsRepository;
  final MessagesRepository _messagesRepository;
  final UsersRepository _usersRepository;
  final Rx<UserActionFeedback?> userActionFeedback = Rx<UserActionFeedback?>(null);
  final PartnerProfile profile = const PartnerProfile(
    name: 'Esam SHARFELDIN',
    age: 28,
    city: 'Nice, France',
    distance: '2 km',
    avatarUrl: 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=200&q=60',
    coverImageUrl: 'https://images.unsplash.com/photo-1521412644187-c49fa049e84d?auto=format&fit=crop&w=1200&q=60',
    heroGradient: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
    levelLabel: 'Niv. 2',
    isOnline: true,
    onlineLabel: 'En ligne',
    friendsCount: 247,
    mutualFriendsCount: 12,
    matchesCount: 89,
    isPrivate: false,
  );

  final List<StoryPreview> stories = const [
    StoryPreview(isCreate: true),
    StoryPreview(
      name: 'Marc',
      imageUrl: 'https://images.unsplash.com/photo-1521412644187-c49fa049e84d?auto=format&fit=crop&w=200&q=60',
      status: StoryStatus.online,
    ),
    StoryPreview(
      name: 'Sarah',
      imageUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=200&q=60',
      status: StoryStatus.recent,
    ),
    StoryPreview(
      name: 'Tom',
      imageUrl: 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=200&q=60',
      status: StoryStatus.idle,
    ),
    StoryPreview(
      name: 'Lisa',
      imageUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=60',
      status: StoryStatus.online,
    ),
  ];

  final List<MutualFriend> mutualFriends = const [
    MutualFriend(
      name: 'Marc',
      avatarUrl: 'https://images.unsplash.com/photo-1521412644187-c49fa049e84d?auto=format&fit=crop&w=200&q=60',
    ),
    MutualFriend(
      name: 'Sophie',
      avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=60',
    ),
    MutualFriend(
      name: 'Thomas',
      avatarUrl: 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=200&q=60',
    ),
    MutualFriend(
      name: 'Julie',
      avatarUrl: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=200&q=60',
    ),
  ];

  final int mutualFriendsOverflow = 9;

  final PartnerProfile pendingProfile = const PartnerProfile(
    name: 'Anita Lops',
    age: 28,
    city: 'Nice, France',
    distance: '2 km',
    avatarUrl: 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=200&q=60',
    coverImageUrl: 'https://images.unsplash.com/photo-1521412644187-c49fa049e84d?auto=format&fit=crop&w=1200&q=60',
    heroGradient: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
    levelLabel: 'Niv. 2',
    isOnline: true,
    onlineLabel: 'En ligne',
    friendsCount: 120,
    mutualFriendsCount: 55,
    matchesCount: 42,
    isPrivate: true,
  );

  final RxBool pendingRequestSent = true.obs;

  final List<PendingSocialStat> pendingSocialStats = const [
    PendingSocialStat(
      value: '120',
      label: 'Amis',
      accent: Color(0xFF176BFF),
    ),
    PendingSocialStat(
      value: '55',
      label: 'En commun',
      accent: Color(0xFF16A34A),
      pillLabel: 'En commun',
    ),
  ];

  final List<PendingSportCardData> pendingSports = const [
    PendingSportCardData(
      name: 'Football',
      level: 'D2 national',
      detail: 'Niveau',
      cardGradient: [Color(0xFFF3E8FF), Color(0xFFE9D5FF)],
      cardBorderColor: Color(0xFFD8B4FE),
      iconGradient: [Color(0xFFA855F7), Color(0xFF7C3AED)],
      chipLabel: 'Expert',
      chipColor: Color(0xFFA855F7),
    ),
    PendingSportCardData(
      name: 'Tennis de table',
      level: 'Régional',
      detail: 'Niveau',
      cardGradient: [Color(0xFFFEF9C3), Color(0xFFFEF08A)],
      cardBorderColor: Color(0xFFFDE047),
      iconGradient: [Color(0xFFEAB308), Color(0xFFF59E0B)],
      chipLabel: 'Avancé',
      chipColor: Color(0xFFEAB308),
    ),
    PendingSportCardData(
      name: 'Course à pied',
      level: 'Loisir',
      detail: 'Niveau',
      cardGradient: [Color(0xFFFCE7F3), Color(0xFFFBCFE8)],
      cardBorderColor: Color(0xFFF9A8D4),
      iconGradient: [Color(0xFFEC4899), Color(0xFFDB2777)],
      chipLabel: 'Intermédiaire',
      chipColor: Color(0xFFEC4899),
    ),
  ];

  final List<PendingAnnouncement> pendingAnnouncements = const [
    PendingAnnouncement(
      title: 'Match de Football',
      message: 'Contenu restreint',
      helper: 'Devenez ami pour voir cette annonce',
    ),
    PendingAnnouncement(
      title: 'Tournoi Ping-Pong',
      message: 'Contenu privé',
      helper: 'Rejoignez Anita pour débloquer ses annonces',
    ),
  ];

  final List<ActivityFeedItem> pendingRecentActivity = const [
    ActivityFeedItem(
      iconColor: Color(0xFF16A34A),
      icon: Icons.emoji_events_rounded,
      message: 'Match terminé',
      timeAgo: 'Il y a 2 jours',
    ),
    ActivityFeedItem(
      iconColor: Color(0xFF176BFF),
      icon: Icons.calendar_today_rounded,
      message: 'Réservation effectuée',
      timeAgo: 'Il y a 1 semaine',
    ),
  ];

  final List<MutualFriend> pendingMutualFriends = const [
    MutualFriend(
      name: 'Marc D.',
      avatarUrl: 'https://images.unsplash.com/photo-1521412644187-c49fa049e84d?auto=format&fit=crop&w=200&q=60',
    ),
    MutualFriend(
      name: 'Julie M.',
      avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=60',
    ),
    MutualFriend(
      name: 'Tom R.',
      avatarUrl: 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=200&q=60',
    ),
  ];

  final int pendingMutualFriendsOverflow = 2;

  final List<PendingPrivacySetting> pendingPrivacySettings = const [
    PendingPrivacySetting(
      title: 'Profil privé',
      description: 'Demande d\'ami requise',
      accent: Color(0xFFF59E0B),
    ),
    PendingPrivacySetting(
      title: 'Messages limités',
      description: 'Après demande acceptée',
      accent: Color(0xFF0EA5E9),
    ),
  ];

  final List<PendingRecommendation> pendingRecommendations = const [
    PendingRecommendation(
      title: 'Rejoindre son groupe',
      subtitle: 'Football Féminin Nice',
      iconColor: Color(0xFF176BFF),
    ),
    PendingRecommendation(
      title: 'Terrains similaires',
      subtitle: 'Complexe Sportif Pasteur',
      iconColor: Color(0xFF16A34A),
    ),
  ];

  final TextEditingController friendSearchController = TextEditingController();
  final RxString friendSearchQuery = ''.obs;
  final RxString selectedFriendFilter = 'Tous'.obs;

  final List<String> friendFilters = const [
    'Tous',
    'Football',
    'Basketball',
    'Course',
    'Proche',
  ];

  final List<OnlineFriend> onlineFriends = const [
    OnlineFriend(
      name: 'Sarah',
      avatarUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=200&q=60',
    ),
    OnlineFriend(
      name: 'Marc',
      avatarUrl: 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=200&q=60',
    ),
    OnlineFriend(
      name: 'Alex',
      avatarUrl: 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=200&q=60',
    ),
    OnlineFriend(
      name: 'Emma',
      avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=200&q=60',
    ),
    OnlineFriend(
      name: 'Tom',
      avatarUrl: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=200&q=60',
    ),
    OnlineFriend(
      name: 'Léa',
      avatarUrl: 'https://images.unsplash.com/photo-1521412644187-c49fa049e84d?auto=format&fit=crop&w=200&q=60',
    ),
  ];

  final List<FriendQuickAction> friendQuickActions = const [
    FriendQuickAction(
      label: 'Inviter',
      icon: Icons.person_add_alt_rounded,
      background: Color(0x19176BFF),
      foreground: Color(0xFF176BFF),
    ),
    FriendQuickAction(
      label: 'Organiser',
      icon: Icons.calendar_month_rounded,
      background: Color(0x19FFB800),
      foreground: Color(0xFFFFB800),
    ),
    FriendQuickAction(
      label: 'Défier',
      icon: Icons.sports_kabaddi_rounded,
      background: Color(0x1916A34A),
      foreground: Color(0xFF16A34A),
    ),
  ];

  final List<Friend> friends = const [
    Friend(
      name: 'Alice Youp',
      avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=60',
      distance: 'à 2 km',
      levelTag: FriendTag(label: 'Pro', color: Color(0xFF16A34A)),
      statusTag: FriendTag(label: 'En ligne', color: Color(0xFF16A34A)),
      attributes: ['Football', 'Pro'],
    ),
    Friend(
      name: 'Marc Dubois',
      avatarUrl: 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=200&q=60',
      distance: 'à 5 km',
      levelTag: FriendTag(label: 'Inter', color: Color(0xFFF59E0B)),
      statusTag: FriendTag(label: 'Il y a 2h', color: Color(0xFF475569)),
      attributes: ['Basketball', 'Coach'],
    ),
    Friend(
      name: 'Emma Martin',
      avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=60',
      distance: 'à 1 km',
      levelTag: FriendTag(label: 'Expert', color: Color(0xFFEF4444)),
      statusTag: FriendTag(label: 'En ligne', color: Color(0xFF16A34A)),
      attributes: ['Course', 'Coach'],
    ),
    Friend(
      name: 'Alex Rousseau',
      avatarUrl: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=200&q=60',
      distance: 'à 8 km',
      levelTag: FriendTag(label: 'Débutant', color: Color(0xFF176BFF)),
      statusTag: FriendTag(label: 'Hier', color: Color(0xFF475569)),
      attributes: ['Football'],
    ),
    Friend(
      name: 'Sophie Leroy',
      avatarUrl: 'https://images.unsplash.com/photo-1521412644187-c49fa049e84d?auto=format&fit=crop&w=200&q=60',
      distance: 'à 3 km',
      levelTag: FriendTag(label: 'Coach', color: Color(0xFF0EA5E9)),
      statusTag: FriendTag(label: 'En ligne', color: Color(0xFF16A34A)),
      attributes: ['Fitness', 'Coach'],
    ),
    Friend(
      name: 'Thomas Garcia',
      avatarUrl: 'https://images.unsplash.com/photo-1502767089025-6572583495b0?auto=format&fit=crop&w=200&q=60',
      distance: 'à 12 km',
      levelTag: FriendTag(label: 'Semi-pro', color: Color(0xFFFFB800)),
      statusTag: FriendTag(label: 'Il y a 1j', color: Color(0xFF475569)),
      attributes: ['Tennis'],
    ),
    Friend(
      name: 'Camille Moreau',
      avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=200&q=60',
      distance: 'à 6 km',
      levelTag: FriendTag(label: 'Pro', color: Color(0xFF16A34A)),
      statusTag: FriendTag(label: 'Il y a 5h', color: Color(0xFF475569)),
      attributes: ['Yoga'],
    ),
    Friend(
      name: 'Lucas Bernard',
      avatarUrl: 'https://images.unsplash.com/photo-1521412644187-c49fa049e84d?auto=format&fit=crop&w=200&q=60',
      distance: 'à 4 km',
      levelTag: FriendTag(label: 'Inter', color: Color(0xFFF59E0B)),
      statusTag: FriendTag(label: 'Il y a 3j', color: Color(0xFF475569)),
      attributes: ['Football', 'Course'],
    ),
    Friend(
      name: 'Pierre Durand',
      avatarUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=200&q=60',
      distance: 'à 15 km',
      levelTag: FriendTag(label: 'Débutant', color: Color(0xFF176BFF)),
      statusTag: FriendTag(label: 'Il y a 3j', color: Color(0xFF475569)),
      attributes: ['Running'],
    ),
  ];

  final RxInt friendsShownCount = 9.obs;
  final int friendsTotalCount = 127;

  final List<FriendStatCard> friendStats = const [
    FriendStatCard(
      value: '127',
      label: 'Total amis',
      icon: Icons.people_alt_outlined,
    ),
    FriendStatCard(
      value: '12',
      label: 'En ligne',
      icon: Icons.bolt_rounded,
    ),
    FriendStatCard(
      value: '45',
      label: 'Football',
      icon: Icons.sports_soccer_rounded,
    ),
    FriendStatCard(
      value: '32',
      label: 'Basketball',
      icon: Icons.sports_basketball_rounded,
    ),
    FriendStatCard(
      value: '28',
      label: 'Course',
      icon: Icons.directions_run_rounded,
    ),
  ];

  final List<FriendActivityItem> friendActivity = const [
    FriendActivityItem(
      avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=60',
      message: 'Alice Youp a rejoint un match de football',
      timeAgo: 'Il y a 2 heures',
    ),
    FriendActivityItem(
      avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=60',
      message: 'Emma Martin a terminé une course de 5 km',
      timeAgo: 'Il y a 4 heures',
    ),
    FriendActivityItem(
      avatarUrl: 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=200&q=60',
      message: 'Marc Dubois a réservé un terrain de basket',
      timeAgo: 'Hier',
    ),
  ];

  final List<FriendSuggestion> friendSuggestions = const [
    FriendSuggestion(
      name: 'Kevin Petit',
      avatarUrl: 'https://images.unsplash.com/photo-1502767089025-6572583495b0?auto=format&fit=crop&w=200&q=60',
      subtitle: '3 amis en commun • à 2 km',
    ),
    FriendSuggestion(
      name: 'Julie Blanc',
      avatarUrl: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=200&q=60',
      subtitle: '1 ami en commun • à 1 km',
    ),
  ];

  final List<ProfileAvailabilityDay> profileAvailability = const [
    ProfileAvailabilityDay(day: 'Lun', date: '12', isAvailable: false),
    ProfileAvailabilityDay(day: 'Mar', date: '13', isAvailable: true),
    ProfileAvailabilityDay(day: 'Mer', date: '14', isAvailable: true),
    ProfileAvailabilityDay(day: 'Jeu', date: '15', isAvailable: false),
    ProfileAvailabilityDay(day: 'Ven', date: '16', isAvailable: true),
    ProfileAvailabilityDay(day: 'Sam', date: '17', isAvailable: true),
    ProfileAvailabilityDay(day: 'Dim', date: '18', isAvailable: false),
  ];

  final ProfilePresence profilePresence = const ProfilePresence(
    statusLabel: 'En ligne maintenant',
    responseLabel: 'Répond généralement en',
    responseValue: 'moins de 2h',
    lastActivity: 'Match de football • Il y a 3h',
  );

  final ProfileCompatibility profileCompatibility = const ProfileCompatibility(
    percentage: 84,
    sportsInCommon: 3,
    levelsMatch: true,
    proximity: 'Zone proche',
    experienceSummary: ["7 ans d'expérience", "Dernière activité : Hier"],
  );

  final List<ProfileContactPreference> profileContactPreferences = const [
    ProfileContactPreference(
      icon: Icons.message_outlined,
      background: Color(0x1916A34A),
      title: 'Messages instantanés',
      subtitle: "Répond généralement en moins d'1h",
      statusLabel: 'Actif',
      statusColor: Color(0xFF16A34A),
    ),
    ProfileContactPreference(
      icon: Icons.event_available_outlined,
      background: Color(0x19176BFF),
      title: "Invitations d'événements",
      subtitle: 'Accepte les invitations spontanées',
      statusLabel: 'Ouvert',
      statusColor: Color(0xFF176BFF),
    ),
    ProfileContactPreference(
      icon: Icons.call_outlined,
      background: Color(0x19F59E0B),
      title: 'Appels téléphoniques',
      subtitle: 'Uniquement pour les urgences',
      statusLabel: 'Limité',
      statusColor: Color(0xFFF59E0B),
    ),
  ];

  final ProfileAvailabilitySummary profileAvailabilitySummary = const ProfileAvailabilitySummary(
    headline: 'Souvent libre',
    preferredTime: 'Préfère: 18h-20h',
  );

  final List<SportExperience> sportExperiences = const [
    SportExperience(
      name: 'Football',
      level: 'Niveau D2 national',
      iconGradient: [Color(0xFFFFB800), Color(0xFFFFA000)],
      highlightBadge: SportBadge(
        label: '🏅 En commun',
        background: Color(0x33FFB800),
        textColor: Color(0xFFFFB800),
      ),
    ),
    SportExperience(
      name: 'Danse moderne',
      level: 'Niveau intermédiaire',
      iconGradient: [Color(0xFFFF6B9D), Color(0xFFE91E63)],
      tenureLines: ['Depuis 3', 'ans'],
    ),
    SportExperience(
      name: 'Padel',
      level: 'Niveau débutant+',
      iconGradient: [Color(0xFFFF4444), Color(0xFFD32F2F)],
      highlightBadge: SportBadge(
        label: 'Nouveau',
        background: Color(0x3316A34A),
        textColor: Color(0xFF16A34A),
      ),
    ),
    SportExperience(
      name: 'Tennis',
      level: 'Niveau 15/2',
      iconGradient: [Color(0xFF4CAF50), Color(0xFF388E3C)],
      highlightBadge: SportBadge(
        label: '🏅 En commun',
        background: Color(0x33176BFF),
        textColor: Color(0xFF176BFF),
      ),
    ),
  ];

  final List<ProfileAchievement> achievements = const [
    ProfileAchievement(
      title: 'Champion local',
      subtitle: 'Football',
      iconColor: Color(0xFFFFB800),
      backgroundColor: Color(0x19FFB800),
    ),
    ProfileAchievement(
      title: '100 matchs',
      subtitle: 'Tous sports',
      iconColor: Color(0xFF16A34A),
      backgroundColor: Color(0x1916A34A),
    ),
    ProfileAchievement(
      title: '5 étoiles',
      subtitle: 'Évaluation',
      iconColor: Color(0xFF0EA5E9),
      backgroundColor: Color(0x190EA5E9),
    ),
  ];

  final List<ProfileAnnouncement> profileAnnouncements = const [
    ProfileAnnouncement(
      author: 'Anita Lops',
      avatarUrl: 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=200&q=60',
      timeAgo: 'il y a 2h',
      message:
          'Recherche partenaire pour match de football ce samedi 16h au stade municipal de Nice. Niveau D2 souhaité 🔥',
      imageUrl: 'https://images.unsplash.com/photo-1489515217757-5fd1be406fef?auto=format&fit=crop&w=1200&q=60',
      dateLabel: 'Sam 14 oct',
      timeLabel: '16:00',
      slotsLabel: '1/2 places',
      priceLabel: 'Gratuit',
      interestedLabel: '3 intéressés',
      actionLabel: 'Rejoindre',
      statsLabel: '12 joueurs',
      distanceLabel: '1.2 km',
    ),
    ProfileAnnouncement(
      author: 'Anita Lops',
      avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=60',
      timeAgo: 'il y a 1j',
      message:
          'Cours de danse moderne tous les mardis 19h. Débutants bienvenus ! Ambiance conviviale assurée 💃',
      imageUrl: 'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?auto=format&fit=crop&w=1200&q=60',
      dateLabel: 'Chaque mardi',
      timeLabel: '19:00',
      slotsLabel: '8 places',
      priceLabel: '15€',
      interestedLabel: '7 intéressés',
      actionLabel: 'S\'inscrire',
      statsLabel: 'Cours hebdomadaire',
      distanceLabel: '0.8 km',
    ),
  ];

  final double profileRating = 4.9;
  final int profileReviewCount = 47;

  final List<ProfileReview> profileReviews = const [
    ProfileReview(
      author: 'Marc Dubois',
      avatarUrl: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=200&q=60',
      rating: 5,
      message:
          'Excellente partenaire de jeu ! Très technique et toujours de bonne humeur. Je recommande vivement.',
      timeAgo: 'il y a 3 jours',
    ),
    ProfileReview(
      author: 'Sophie Martin',
      avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=60',
      rating: 5,
      message:
          'Super prof de danse ! Très pédagogue et patiente avec les débutants. Ambiance top !',
      timeAgo: 'il y a 1 semaine',
    ),
  ];

  final List<ProfileStatistic> profileStatistics = const [
    ProfileStatistic(value: '89', label: 'Matchs joués', accent: Color(0xFF176BFF)),
    ProfileStatistic(value: '67', label: 'Victoires', accent: Color(0xFF16A34A)),
    ProfileStatistic(value: '156h', label: 'Temps de jeu', accent: Color(0xFFFFB800)),
    ProfileStatistic(value: '4.9', label: 'Note moyenne', accent: Color(0xFF0EA5E9)),
  ];

  final List<HeroAction> heroActions = const [
    HeroAction(
      label: 'Créer annonce',
      icon: Icons.edit_outlined,
      background: Color(0xFF176BFF),
      foreground: Colors.white,
    ),
    HeroAction(
      label: 'Planifier match',
      icon: Icons.calendar_month_outlined,
      background: Color(0x1916A34A),
      foreground: Color(0xFF16A34A),
    ),
    HeroAction(
      label: 'Près de moi',
      icon: Icons.near_me_outlined,
      background: Color(0x19FFB800),
      foreground: Color(0xFFFFB800),
    ),
    HeroAction(
      label: 'Maintenant',
      icon: Icons.flash_on_rounded,
      background: Color(0x190EA5E9),
      foreground: Color(0xFF0EA5E9),
    ),
  ];

  final List<String> activeFilters = const [
    'Football',
    '5 km',
    'Récent',
    'Niveau Pro',
    'Disponible',
  ];

  final List<PartnerHighlightSection> partnerSections = const [
    PartnerHighlightSection(
      title: 'Nouveaux inscrits',
      icon: Icons.fiber_new_rounded,
      color: Color(0xFF16A34A),
      partners: [
        PartnerHighlight(
          name: 'Marie',
          avatarUrl: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=400&q=60',
          distance: '1.2 km',
          rating: '4.9',
          availabilityLabel: 'Libre',
          availabilityColor: Color(0xFF16A34A),
          tags: ['Running', 'Yoga'],
          isOnline: true,
        ),
        PartnerHighlight(
          name: 'Thomas',
          avatarUrl: 'https://images.unsplash.com/photo-1521412644187-c49fa049e84d?auto=format&fit=crop&w=400&q=60',
          distance: '0.8 km',
          rating: '4.7',
          availabilityLabel: 'Occupé',
          availabilityColor: Color(0xFFF59E0B),
          tags: ['Football', 'Padel'],
        ),
        PartnerHighlight(
          name: 'Sophie',
          avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=400&q=60',
          distance: '2.1 km',
          rating: '4.5',
          availabilityLabel: 'Libre',
          availabilityColor: Color(0xFF16A34A),
          tags: ['Natation', 'Pilates'],
          isOnline: true,
        ),
      ],
    ),
    PartnerHighlightSection(
      title: 'Football',
      icon: Icons.sports_soccer_rounded,
      color: Color(0xFFFFB800),
      partners: [
        PartnerHighlight(
          name: 'David',
          avatarUrl: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=400&q=60',
          distance: '1.5 km',
          rating: '4.8',
          availabilityLabel: 'Libre',
          availabilityColor: Color(0xFF16A34A),
          tags: ['Organisateur', 'Capitaine'],
          isPro: true,
        ),
        PartnerHighlight(
          name: 'Julie',
          avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=400&q=60',
          distance: '1.1 km',
          rating: '4.6',
          availabilityLabel: 'Libre',
          availabilityColor: Color(0xFF16A34A),
          tags: ['Milieu', 'Jogging'],
        ),
        PartnerHighlight(
          name: 'Marc',
          avatarUrl: 'https://images.unsplash.com/photo-1489515217757-5fd1be406fef?auto=format&fit=crop&w=400&q=60',
          distance: '4.3 km',
          rating: '4.2',
          availabilityLabel: 'Occupé',
          availabilityColor: Color(0xFFF59E0B),
          tags: ['Défenseur', 'Matchs du soir'],
        ),
      ],
    ),
    PartnerHighlightSection(
      title: 'Running',
      icon: Icons.directions_run_rounded,
      color: Color(0xFF176BFF),
      partners: [
        PartnerHighlight(
          name: 'Alex',
          avatarUrl: 'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?auto=format&fit=crop&w=400&q=60',
          distance: '0.5 km',
          rating: '4.9',
          availabilityLabel: 'Libre',
          availabilityColor: Color(0xFF16A34A),
          tags: ['Coach Pro', 'Fractionné'],
          isVip: true,
        ),
        PartnerHighlight(
          name: 'Emma',
          avatarUrl: 'https://images.unsplash.com/photo-1502823403499-6ccfcf4fb453?auto=format&fit=crop&w=400&q=60',
          distance: '1.8 km',
          rating: '4.8',
          availabilityLabel: 'Libre',
          availabilityColor: Color(0xFF16A34A),
          tags: ['10 km', 'Trail'],
        ),
        PartnerHighlight(
          name: 'Marc',
          avatarUrl: 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=400&q=60',
          distance: '4.5 km',
          rating: '4.4',
          availabilityLabel: 'Occupé',
          availabilityColor: Color(0xFFF59E0B),
          tags: ['Sprinteur', 'Vitesse'],
        ),
      ],
    ),
    PartnerHighlightSection(
      title: 'Tennis',
      icon: Icons.sports_tennis_rounded,
      color: Color(0xFF0EA5E9),
      partners: [
        PartnerHighlight(
          name: 'Clara',
          avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=400&q=60',
          distance: '1.7 km',
          rating: '4.9',
          availabilityLabel: 'Libre',
          availabilityColor: Color(0xFF16A34A),
          tags: ['Double', 'Tournoi'],
        ),
        PartnerHighlight(
          name: 'Paul',
          avatarUrl: 'https://images.unsplash.com/photo-1521412644187-c49fa049e84d?auto=format&fit=crop&w=400&q=60',
          distance: '2.9 km',
          rating: '4.6',
          availabilityLabel: 'Libre',
          availabilityColor: Color(0xFF16A34A),
          tags: ['Simple', 'Service'],
          isVip: true,
        ),
        PartnerHighlight(
          name: 'Lisa',
          avatarUrl: 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=400&q=60',
          distance: '3.4 km',
          rating: '4.3',
          availabilityLabel: 'Occupé',
          availabilityColor: Color(0xFFF59E0B),
          tags: ['Mixte', 'Club'],
        ),
      ],
    ),
    PartnerHighlightSection(
      title: 'Natation',
      icon: Icons.pool_rounded,
      color: Color(0xFF0EA5E9),
      partners: [
        PartnerHighlight(
          name: 'Nina',
          avatarUrl: 'https://images.unsplash.com/photo-1502720705749-3c161r?auto=format&fit=crop&w=400&q=60',
          distance: '1.4 km',
          rating: '4.8',
          availabilityLabel: 'Libre',
          availabilityColor: Color(0xFF16A34A),
          tags: ['Endurance', 'Piscine'],
        ),
        PartnerHighlight(
          name: 'Ryan',
          avatarUrl: 'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?auto=format&fit=crop&w=400&q=60',
          distance: '2.2 km',
          rating: '4.6',
          availabilityLabel: 'Libre',
          availabilityColor: Color(0xFF16A34A),
          tags: ['Sprinteur', 'Club'],
          isNew: true,
        ),
        PartnerHighlight(
          name: 'Camille',
          avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=400&q=60',
          distance: '2.8 km',
          rating: '4.4',
          availabilityLabel: 'Libre',
          availabilityColor: Color(0xFF16A34A),
          tags: ['Triathlon', 'Coach'],
          isCoach: true,
        ),
      ],
    ),
    PartnerHighlightSection(
      title: 'Cyclisme',
      icon: Icons.directions_bike_rounded,
      color: Color(0xFF176BFF),
      partners: [
        PartnerHighlight(
          name: 'Antoine',
          avatarUrl: 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=400&q=60',
          distance: '3.1 km',
          rating: '4.5',
          availabilityLabel: 'Libre',
          availabilityColor: Color(0xFF16A34A),
          tags: ['Sorties longues', 'Route'],
        ),
        PartnerHighlight(
          name: 'Sarah',
          avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=400&q=60',
          distance: '0.7 km',
          rating: '4.9',
          availabilityLabel: 'Libre',
          availabilityColor: Color(0xFF16A34A),
          tags: ['VTT', 'Cardio'],
        ),
        PartnerHighlight(
          name: 'Camille',
          avatarUrl: 'https://images.unsplash.com/photo-1521412644187-c49fa049e84d?auto=format&fit=crop&w=400&q=60',
          distance: '2.8 km',
          rating: '4.6',
          availabilityLabel: 'Libre',
          availabilityColor: Color(0xFF16A34A),
          tags: ['Coach', 'Endurance'],
          isCoach: true,
        ),
      ],
    ),
  ];

  final List<VenueHighlight> venueHighlights = const [
    VenueHighlight(
      title: 'Complexe Sportif Mark',
      subtitle: 'Terrain de football synthétique',
      badge: 'Disponible maintenant',
      rating: '4.8',
      price: '25€ / h',
      distance: '1.2 km',
      capacity: '22 joueurs max',
      extras: ['Parking gratuit', 'Vestiaires'],
      sports: ['Football', 'Basket'],
      imageUrl: 'https://images.unsplash.com/photo-1546519638-68e109498ffc?auto=format&fit=crop&w=1200&q=60',
      accent: Color(0xFF176BFF),
    ),
    VenueHighlight(
      title: 'Arena Mark Sport',
      subtitle: 'Salle multisports couverte',
      badge: 'Presque complet',
      rating: '4.6',
      price: '30€ / h',
      distance: '2.8 km',
      capacity: '16 joueurs max',
      extras: ['Climatisé', 'Parking gratuit'],
      sports: ['Volley', 'Tennis'],
      imageUrl: 'https://images.unsplash.com/photo-1546483875-ad9014c88eba?auto=format&fit=crop&w=1200&q=60',
      accent: Color(0xFF16A34A),
    ),
  ];

  final List<AnnouncementCard> announcements = const [
    AnnouncementCard(
      author: 'Mark Davis',
      avatarUrl: 'https://images.unsplash.com/photo-1489515217757-5fd1be406fef?auto=format&fit=crop&w=400&q=60',
      timeAgo: 'il y a 2h',
      badges: ['Organisateur'],
      title: 'Match de football ce soir - 2 places libres!',
      body:
          'Salut les amis! On organise un match de foot ce soir à 19h au stade Mark. Il nous manque 2 joueurs, niveau intermédiaire/avancé. Ambiance garantie! 🔥',
      stats: ['12 partages', '5 commentaires', 'Gratuit'],
      actionLabel: 'Rejoindre',
      distance: '1.5 km',
      participants: '8/10 joueurs',
      priceLabel: 'Gratuit',
    ),
    AnnouncementCard(
      author: 'Mark Wilson',
      avatarUrl: 'https://images.unsplash.com/photo-1502720705749-3c161r?auto=format&fit=crop&w=400&q=60',
      timeAgo: 'il y a 4h',
      badges: ['Coach Pro'],
      title: 'Cours de tennis privé - Tous niveaux',
      body:
          'Coach diplômé propose des cours de tennis individuels ou en petit groupe. Technique, tactique, préparation physique. Premier cours d\'essai offert! 🎾',
      stats: ['28 partages', '15 commentaires', '35€/h'],
      actionLabel: 'Contacter',
      distance: '3.2 km',
      participants: 'Flexible',
      priceLabel: '35€/h',
    ),
    AnnouncementCard(
      author: 'Mark Garcia',
      avatarUrl: 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=400&q=60',
      timeAgo: 'il y a 6h',
      badges: ['Capitaine'],
      title: 'Tournoi de basket 3v3 ce weekend!',
      body:
          'Tournoi amical de basketball 3 contre 3 samedi prochain. Inscription gratuite, lots à gagner! Venez nombreux, tous niveaux bienvenus 🏀',
      stats: ['45 partages', '23 commentaires', 'Lots à gagner'],
      actionLabel: 'S\'inscrire',
      distance: '2.1 km',
      participants: 'Samedi 14h',
      priceLabel: 'Gratuit',
    ),
  ];

  final List<QuickActionCard> quickActions = const [
    QuickActionCard(
      label: 'Affiner la recherche',
      icon: Icons.filter_alt_outlined,
      background: Color(0xFF176BFF),
      foreground: Colors.white,
    ),
    QuickActionCard(
      label: 'Vue carte',
      icon: Icons.map_outlined,
      background: Color(0xFF16A34A),
      foreground: Colors.white,
    ),
    QuickActionCard(
      label: 'Sauvegarder',
      icon: Icons.bookmark_outline_rounded,
      background: Color(0xFFFFB800),
      foreground: Colors.white,
    ),
    QuickActionCard(
      label: 'Historique',
      icon: Icons.history_rounded,
      background: Color(0xFF0EA5E9),
      foreground: Colors.white,
    ),
  ];

  final List<SuggestionBucket> suggestionBuckets = const [
    SuggestionBucket(
      title: 'Matchs de football près de vous',
      subtitle: '15 matchs cette semaine',
      iconColor: Color(0xFF176BFF),
    ),
    SuggestionBucket(
      title: 'Joueurs de votre niveau',
      subtitle: '32 joueurs intermédiaires',
      iconColor: Color(0xFF16A34A),
    ),
    SuggestionBucket(
      title: 'Créneaux disponibles aujourd\'hui',
      subtitle: '8 terrains libres',
      iconColor: Color(0xFFFFB800),
    ),
  ];

  final List<String> similarSearches = const [
    'Mark + Football',
    'Joueurs proches',
    'Terrains Mark',
    'Matchs ce soir',
    'Niveau intermédiaire',
    'Gratuit',
  ];

  final EventHighlight eventHighlight = const EventHighlight(
    badge: 'DEMAIN',
    title: 'Match de Tennis',
    subtitle: 'Tournoi amateur mixte',
    schedule: '14h00 - 17h00',
    distance: '1.5 km',
    participants: 'Marc, Julie, Sarah +5',
    price: '25€',
    accent: Color(0xFF176BFF),
  );

  final EventHighlight groupRunHighlight = const EventHighlight(
    badge: 'SAMEDI',
    title: 'Course en Groupe',
    subtitle: '10km dans le Bois de Boulogne',
    schedule: '08h00 - 10h00',
    distance: '3.2 km',
    participants: '12 inscrits • Tous niveaux',
    price: 'Gratuit',
    accent: Color(0xFF16A34A),
  );

  final List<GroupHighlight> groups = const [
    GroupHighlight(
      title: 'Running Club Paris 15',
      subtitle: 'Groupe de course à pied du 15ème arrondissement',
      distance: '1.2 km',
      members: '45 membres',
      badge: '12',
      badgeLabel: 'Nouveaux membres',
      accent: Color(0xFF176BFF),
      joinLabel: 'Rejoindre',
    ),
    GroupHighlight(
      title: 'Foot Loisir Montparnasse',
      subtitle: 'Matchs amicaux tous les mercredis soir',
      distance: '2.1 km',
      members: '22 membres',
      badge: '8',
      badgeLabel: 'Places',
      accent: Color(0xFFFFB800),
      joinLabel: 'Rejoindre',
    ),
    GroupHighlight(
      title: 'Fitness Squad',
      subtitle: 'Entraînement en groupe, motivation garantie',
      distance: '0.8 km',
      members: '18 membres',
      badge: '5',
      badgeLabel: 'Coachs',
      accent: Color(0xFF16A34A),
      joinLabel: 'Rejoindre',
    ),
  ];

  final List<EventCardData> nearbyEvents = const [
    EventCardData(
      title: 'Match de Tennis',
      subtitle: 'Tournoi amateur mixte',
      dateLabel: 'DEMAIN',
      schedule: '14h00 - 17h00',
      distance: '1.5 km',
      participants: '12 participants',
      priceLabel: '25€',
      accent: Color(0xFF176BFF),
    ),
    EventCardData(
      title: 'Course en Groupe',
      subtitle: '10km dans le Bois de Boulogne',
      dateLabel: 'SAMEDI',
      schedule: '08h00 - 10h00',
      distance: '3.2 km',
      participants: '20 participants',
      priceLabel: 'Gratuit',
      accent: Color(0xFF16A34A),
    ),
  ];

  final List<QuickShortcut> shortcuts = const [
    QuickShortcut(label: 'Running', icon: Icons.directions_run_rounded, color: Color(0xFF176BFF)),
    QuickShortcut(label: 'Football', icon: Icons.sports_soccer_rounded, color: Color(0xFF16A34A)),
    QuickShortcut(label: 'Tennis', icon: Icons.sports_tennis_rounded, color: Color(0xFFFFB800)),
    QuickShortcut(label: 'Basket', icon: Icons.sports_basketball_rounded, color: Color(0xFF0EA5E9)),
  ];

  final List<PartnerPost> feed = const [
    PartnerPost(
      author: 'Esam SHARFELDIN',
      avatarUrl: 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=200&q=60',
      heading: 'Match de foot 5v5 ce soir',
      message: 'Qui est chaud pour un match de foot 5v5 ce soir ? Il nous manque 3 joueurs ! ⚽️🔥',
      sport: 'Football',
      sportColor: Color(0xFF16A34A),
      chips: ['#Football', '#5v5', '#CeSoir'],
      scheduleLabel: "Aujourd'hui 19h30 • 7/10 joueurs",
      levelLabel: 'Niveau intermédiaire • 5€/personne',
      imageUrl: 'https://images.unsplash.com/photo-1489515217757-5fd1be406fef?auto=format&fit=crop&w=1200&q=60',
      stats: PartnerPostStats(likes: 24, comments: 8, shares: 3, participants: 156),
      contactLabel: 'Message',
    ),
    PartnerPost(
      author: 'Julie Martin',
      avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=60',
      heading: 'Session running matinale',
      message: 'Session running matinale demain 7h au Bois de Boulogne ! Qui se joint à moi pour 10km ? 🏃‍♀️',
      sport: 'Running',
      sportColor: Color(0xFF16A34A),
      chips: ['#Running', '#Matin', '#10km'],
      scheduleLabel: "Aujourd'hui 19h30 • 7/10 joueurs",
      levelLabel: 'Niveau intermédiaire • Gratuit',
      imageUrl: 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?auto=format&fit=crop&w=1200&q=60',
      stats: PartnerPostStats(likes: 18, comments: 12, shares: 5, participants: 89),
      contactLabel: 'Message',
    ),
    PartnerPost(
      author: 'Tom Leroy',
      avatarUrl: 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=200&q=60',
      heading: 'Tournoi basket 3v3',
      message: 'Tournoi 3x3 ce weekend ! Inscription ouverte, 50€ par équipe. Lots à gagner ! 🏆',
      sport: 'Basketball',
      sportColor: Color(0xFFFFB800),
      chips: ['#Basketball', '#3v3', '#Weekend'],
      scheduleLabel: 'Samedi 14h00 • 1/2 joueurs',
      levelLabel: 'Niveau confirmé • 12€/h',
      imageUrl: 'https://images.unsplash.com/photo-1518300670436-36662a63304a?auto=format&fit=crop&w=1200&q=60',
      stats: PartnerPostStats(likes: 42, comments: 15, shares: 7, participants: 203),
      contactLabel: 'Message',
    ),
  ];

  final List<PartnerSuggestion> suggestions = const [
    PartnerSuggestion(
      name: 'Alex Moreau',
      avatarUrl: 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=200&q=60',
      tags: ['Running', 'Football'],
    ),
    PartnerSuggestion(
      name: 'Emma Dubois',
      avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=60',
      tags: ['Tennis', 'Yoga'],
    ),
  ];

  final WeeklySummary summary = const WeeklySummary(
    activeFriends: 24,
    sessions: 8,
    streak: 12,
    points: 1247,
  );

  final List<UpcomingEvent> upcomingEvents = const [
    UpcomingEvent(
      title: 'Match Football avec Marc',
      dateLabel: 'MAR 15',
      timeLabel: '19h30',
      location: 'Parc des Sports',
      participantsLabel: 'Marc, Julie, Lisa +5',
      accentColor: Color(0xFF176BFF),
    ),
    UpcomingEvent(
      title: 'Running avec Sarah',
      dateLabel: 'MER 16',
      timeLabel: '07h00',
      location: 'Parc Monceau',
      participantsLabel: 'Sarah, Tom +2',
      accentColor: Color(0xFF16A34A),
    ),
  ];

  final List<ActivityFeedItem> recentActivity = const [
    ActivityFeedItem(
      iconColor: Color(0xFF16A34A),
      icon: Icons.emoji_events_rounded,
      message: 'Victoire en match de football',
      timeAgo: 'Il y a 2 jours',
    ),
    ActivityFeedItem(
      iconColor: Color(0xFF0EA5E9),
      icon: Icons.campaign_rounded,
      message: 'Nouvelle annonce publiée',
      timeAgo: 'Il y a 3 jours',
    ),
    ActivityFeedItem(
      iconColor: Color(0xFFFFB800),
      icon: Icons.military_tech_rounded,
      message: 'Badge "Champion local" obtenu',
      timeAgo: 'Il y a 1 semaine',
    ),
    ActivityFeedItem(
      iconColor: Color(0xFF176BFF),
      icon: Icons.group_add_rounded,
      message: '15 nouveaux amis ajoutés',
      timeAgo: 'Il y a 2 semaines',
    ),
  ];

  final RxBool hasSentRequest = false.obs;
  final RxBool isLoadingRequest = false.obs;
  final RxString currentUserId = ''.obs;
  String? _profileUserId;

  @override
  void onInit() {
    super.onInit();
    _loadCurrentUserId();
    _checkFriendshipStatus();
  }

  Future<void> _loadCurrentUserId() async {
    try {
      final user = await _usersRepository.getCurrentUser();
      currentUserId.value = user.id;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error loading current user: $e');
      }
    }
  }

  Future<void> _checkFriendshipStatus() async {
    // Get profile user ID from arguments if available
    final args = Get.arguments;
    if (args is String) {
      _profileUserId = args;
    } else if (args is Map<String, dynamic> && args['userId'] != null) {
      _profileUserId = args['userId'] as String;
    }

    if (_profileUserId == null || currentUserId.value.isEmpty) return;

    try {
      final status = await _friendsRepository.getFriendshipStatus(_profileUserId!);
      if (status['status'] == 'PENDING') {
        hasSentRequest.value = true;
      } else if (status['status'] == 'ACCEPTED') {
        hasSentRequest.value = false; // Already friends, show different UI
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error checking friendship status: $e');
      }
    }
  }

  Future<void> toggleRequest() async {
    if (_profileUserId == null || currentUserId.value.isEmpty) {
      Get.snackbar('Erreur', 'Impossible d\'envoyer la demande');
      return;
    }

    if (hasSentRequest.value) {
      // Cancel request - would need to implement cancel endpoint
      Get.snackbar('Information', 'Annulation de demande à venir');
      return;
    }

    isLoadingRequest.value = true;
    try {
      await _friendsRepository.sendFriendRequest(_profileUserId!);
      hasSentRequest.value = true;
      Get.snackbar('Demande envoyée', 'Votre demande d\'ami a été envoyée.');
    } on ApiException catch (e) {
      Get.snackbar('Erreur', e.message);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error sending friend request: $e');
      }
      Get.snackbar('Erreur', 'Impossible d\'envoyer la demande');
    } finally {
      isLoadingRequest.value = false;
    }
  }

  Future<void> openDirectMessage(String name) async {
    if (_profileUserId == null) {
      Get.snackbar('Erreur', 'Impossible d\'ouvrir la conversation');
      return;
    }

    try {
      // For now, we'll use the profile name and a default avatar
      // In a real scenario, you'd fetch the other user's profile
      Get.toNamed(Routes.chatDetail, arguments: {
        'userId': _profileUserId,
        'userName': name,
        'userAvatar': profile.avatarUrl,
      });
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error opening chat: $e');
      }
      Get.snackbar('Erreur', 'Impossible d\'ouvrir la conversation');
    }
  }

  Future<void> sendProfileMessage() async {
    await openDirectMessage(profile.name);
  }

  void openSearch() {
    Get.snackbar('Recherche', 'La recherche avancée arrive bientôt.');
  }

  void openFilters() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filtres rapides',
              style: Get.textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: shortcuts
                  .map(
                    (shortcut) => Chip(
                      label: Text(shortcut.label),
                      avatar: CircleAvatar(backgroundColor: shortcut.color.withValues(alpha: 0.2), child: Icon(shortcut.icon, size: 16, color: shortcut.color)),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  void viewAllMutualFriends() {
    Get.snackbar('Amis en commun', 'Affichage détaillé disponible prochainement.');
  }

  void joinAnnouncement() {
    Get.snackbar('Annonce', 'Participation enregistrée.');
  }

  void viewAllReviews() {
    Get.snackbar('Avis', 'Tous les avis seront bientôt disponibles.');
  }

  void inviteToActivity() {
    Get.snackbar('Invitation envoyée', 'Invitation transmise à ${profile.name}.');
    _setUserActionFeedback(
      UserActionFeedback(
        icon: Icons.event_available_rounded,
        title: 'Invitation envoyée',
        message: 'Invitation transmise à ${profile.name}.',
        background: const Color(0xFF176BFF),
        foreground: Colors.white,
      ),
    );
  }

  void followProfile() {
    Get.snackbar('Suivi', 'Vous suivez désormais ${profile.name}.');
    _setUserActionFeedback(
      UserActionFeedback(
        icon: Icons.check_rounded,
        title: 'Action effectuée',
        message: 'Vous suivez désormais ${profile.name}.',
        background: const Color(0xFF16A34A),
        foreground: Colors.white,
      ),
    );
  }

  void sendFriendRequest() {
    Get.snackbar('Demande envoyée', '${profile.name} recevra votre demande d\'ami.');
    _setUserActionFeedback(
      UserActionFeedback(
        icon: Icons.person_add_alt_1_rounded,
        title: 'Demande envoyée',
        message: '${profile.name} recevra votre demande d\'ami.',
        background: const Color(0xFF176BFF),
        foreground: Colors.white,
      ),
    );
  }

  void shareProfile() {
    Get.snackbar('Profil partagé', 'Le lien du profil de ${profile.name} a été copié.');
    _setUserActionFeedback(
      UserActionFeedback(
        icon: Icons.ios_share_rounded,
        title: 'Lien copié',
        message: 'Le lien du profil de ${profile.name} a été copié.',
        background: const Color(0xFF0EA5E9),
        foreground: Colors.white,
      ),
    );
  }

  void blockProfile() {
    Get.snackbar('Utilisateur bloqué', '${profile.name} ne pourra plus interagir avec vous.');
    _setUserActionFeedback(
      UserActionFeedback(
        icon: Icons.block_rounded,
        title: 'Utilisateur bloqué',
        message: '${profile.name} ne pourra plus interagir avec vous.',
        background: const Color(0xFFEF4444),
        foreground: Colors.white,
      ),
    );
  }

  void reportProfile() {
    Get.snackbar('Signalement envoyé', 'Notre équipe va examiner ce profil rapidement.');
    _setUserActionFeedback(
      UserActionFeedback(
        icon: Icons.flag_outlined,
        title: 'Signalement envoyé',
        message: 'Notre équipe va examiner ce profil rapidement.',
        background: const Color(0xFFF97316),
        foreground: Colors.white,
      ),
    );
  }

  void clearUserActionFeedback() {
    userActionFeedback.value = null;
  }

  void _setUserActionFeedback(UserActionFeedback feedback) {
    userActionFeedback.value = feedback;
    _feedbackTimer?.cancel();
    _feedbackTimer = Timer(const Duration(seconds: 4), () {
      if (userActionFeedback.value == feedback) {
        userActionFeedback.value = null;
      }
    });
  }

  Timer? _feedbackTimer;

  void cancelPendingRequest() {
    if (!pendingRequestSent.value) {
      return;
    }
    pendingRequestSent.value = false;
    Get.snackbar('Demande annulée', 'Votre demande a été annulée.');
  }

  void resendPendingRequest() {
    if (pendingRequestSent.value) {
      return;
    }
    pendingRequestSent.value = true;
    Get.snackbar('Demande envoyée', 'Votre demande a été renvoyée.');
  }

  void contactPendingProfile() {
    Get.snackbar('Messages', 'Ouverture de la conversation avec ${pendingProfile.name}');
  }

  void reportPendingProfile() {
    Get.snackbar('Signalement', 'Merci, nous allons examiner le profil d\'${pendingProfile.name}.');
  }

  @override
  void onClose() {
    _feedbackTimer?.cancel();
    friendSearchController.dispose();
    super.onClose();
  }

  void setFriendSearch(String value) {
    friendSearchQuery.value = value;
  }

  void selectFriendFilter(String filter) {
    selectedFriendFilter.value = filter;
  }

  List<Friend> get filteredFriends {
    final query = friendSearchQuery.value.toLowerCase();
    final filter = selectedFriendFilter.value;

    Iterable<Friend> results = friends;

    if (filter != 'Tous') {
      if (filter == 'Proche') {
        results = results.where((friend) {
          final match = RegExp(r'(\d+)').firstMatch(friend.distance);
          if (match == null) {
            return false;
          }
          final value = int.tryParse(match.group(1)!);
          return value != null && value <= 5;
        });
      } else {
        final filterLower = filter.toLowerCase();
        results = results.where(
          (friend) =>
              friend.attributes.any((attribute) => attribute.toLowerCase() == filterLower) ||
              friend.levelTag.label.toLowerCase() == filterLower,
        );
      }
    }

    if (query.isNotEmpty) {
      results = results.where(
        (friend) => friend.name.toLowerCase().contains(query),
      );
    }

    return results.take(friendsShownCount.value).toList();
  }

  void loadMoreFriends() {
    if (friendsShownCount.value >= friends.length) {
      Get.snackbar('Liste complète', 'Tous les amis ont été affichés.');
      return;
    }
    friendsShownCount.value = (friendsShownCount.value + 10).clamp(0, friends.length);
  }

  void onFriendQuickAction(FriendQuickAction action) {
    Get.snackbar(action.label, 'Action "${action.label}" en préparation.');
  }

  void onFriendTap(Friend friend) {
    Get.snackbar(friend.name, 'Ouverture du profil prochainement.');
  }

  void addSuggestedFriend(FriendSuggestion suggestion) {
    Get.snackbar('Invitation envoyée', 'Demande d\'ami envoyée à ${suggestion.name}.');
  }

  void viewAllSuggestedFriends() {
    Get.snackbar('Suggestions', 'Affichage de toutes les suggestions prochainement.');
  }

  void onCreateEventTap() {
    Get.snackbar('Planification', 'La planification d\'un événement arrive bientôt.');
    _setUserActionFeedback(
      UserActionFeedback(
        icon: Icons.calendar_month_rounded,
        title: 'Planification à venir',
        message: 'Nous vous préviendrons dès que la planification d\'événements sera disponible.',
        background: const Color(0xFF6366F1),
        foreground: Colors.white,
      ),
    );
  }
}

class HeroAction {
  const HeroAction({
    required this.label,
    required this.icon,
    required this.background,
    required this.foreground,
  });

  final String label;
  final IconData icon;
  final Color background;
  final Color foreground;
}

class PartnerHighlightSection {
  const PartnerHighlightSection({
    required this.title,
    required this.icon,
    required this.color,
    required this.partners,
  });

  final String title;
  final IconData icon;
  final Color color;
  final List<PartnerHighlight> partners;
}

class PartnerHighlight {
  const PartnerHighlight({
    required this.name,
    required this.avatarUrl,
    required this.distance,
    required this.rating,
    required this.availabilityLabel,
    required this.availabilityColor,
    required this.tags,
    this.isOnline = false,
    this.isPro = false,
    this.isVip = false,
    this.isCoach = false,
    this.isNew = false,
  });

  final String name;
  final String avatarUrl;
  final String distance;
  final String rating;
  final String availabilityLabel;
  final Color availabilityColor;
  final List<String> tags;
  final bool isOnline;
  final bool isPro;
  final bool isVip;
  final bool isCoach;
  final bool isNew;
}

class VenueHighlight {
  const VenueHighlight({
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.rating,
    required this.price,
    required this.distance,
    required this.capacity,
    required this.extras,
    required this.sports,
    required this.imageUrl,
    required this.accent,
  });

  final String title;
  final String subtitle;
  final String badge;
  final String rating;
  final String price;
  final String distance;
  final String capacity;
  final List<String> extras;
  final List<String> sports;
  final String imageUrl;
  final Color accent;
}

class AnnouncementCard {
  const AnnouncementCard({
    required this.author,
    required this.avatarUrl,
    required this.timeAgo,
    required this.badges,
    required this.title,
    required this.body,
    required this.stats,
    required this.actionLabel,
    required this.distance,
    required this.participants,
    required this.priceLabel,
  });

  final String author;
  final String avatarUrl;
  final String timeAgo;
  final List<String> badges;
  final String title;
  final String body;
  final List<String> stats;
  final String actionLabel;
  final String distance;
  final String participants;
  final String priceLabel;
}

class QuickActionCard {
  const QuickActionCard({
    required this.label,
    required this.icon,
    required this.background,
    required this.foreground,
  });

  final String label;
  final IconData icon;
  final Color background;
  final Color foreground;
}

class SuggestionBucket {
  const SuggestionBucket({
    required this.title,
    required this.subtitle,
    required this.iconColor,
  });

  final String title;
  final String subtitle;
  final Color iconColor;
}

class EventHighlight {
  const EventHighlight({
    required this.badge,
    required this.title,
    required this.subtitle,
    required this.schedule,
    required this.distance,
    required this.participants,
    required this.price,
    required this.accent,
  });

  final String badge;
  final String title;
  final String subtitle;
  final String schedule;
  final String distance;
  final String participants;
  final String price;
  final Color accent;
}

class GroupHighlight {
  const GroupHighlight({
    required this.title,
    required this.subtitle,
    required this.distance,
    required this.members,
    required this.badge,
    required this.badgeLabel,
    required this.accent,
    required this.joinLabel,
  });

  final String title;
  final String subtitle;
  final String distance;
  final String members;
  final String badge;
  final String badgeLabel;
  final Color accent;
  final String joinLabel;
}

class EventCardData {
  const EventCardData({
    required this.title,
    required this.subtitle,
    required this.dateLabel,
    required this.schedule,
    required this.distance,
    required this.participants,
    required this.priceLabel,
    required this.accent,
  });

  final String title;
  final String subtitle;
  final String dateLabel;
  final String schedule;
  final String distance;
  final String participants;
  final String priceLabel;
  final Color accent;
}

class PartnerProfile {
  const PartnerProfile({
    required this.name,
    required this.age,
    required this.city,
    required this.distance,
    required this.avatarUrl,
    required this.coverImageUrl,
    required this.heroGradient,
    required this.levelLabel,
    required this.isOnline,
    required this.onlineLabel,
    required this.friendsCount,
    required this.mutualFriendsCount,
    required this.matchesCount,
    required this.isPrivate,
  });

  final String name;
  final int age;
  final String city;
  final String distance;
  final String avatarUrl;
  final String coverImageUrl;
  final List<Color> heroGradient;
  final String levelLabel;
  final bool isOnline;
  final String onlineLabel;
  final int friendsCount;
  final int mutualFriendsCount;
  final int matchesCount;
  final bool isPrivate;
}

class MutualFriend {
  const MutualFriend({required this.name, required this.avatarUrl});

  final String name;
  final String avatarUrl;
}

class SportExperience {
  const SportExperience({
    required this.name,
    required this.level,
    required this.iconGradient,
    this.highlightBadge,
    this.tenureLines,
  });

  final String name;
  final String level;
  final List<Color> iconGradient;
  final SportBadge? highlightBadge;
  final List<String>? tenureLines;
}

class SportBadge {
  const SportBadge({
    required this.label,
    required this.background,
    required this.textColor,
  });

  final String label;
  final Color background;
  final Color textColor;
}

class ProfileAchievement {
  const ProfileAchievement({
    required this.title,
    required this.subtitle,
    required this.iconColor,
    required this.backgroundColor,
  });

  final String title;
  final String subtitle;
  final Color iconColor;
  final Color backgroundColor;
}

class ProfileAnnouncement {
  const ProfileAnnouncement({
    required this.author,
    required this.avatarUrl,
    required this.timeAgo,
    required this.message,
    required this.imageUrl,
    required this.dateLabel,
    required this.timeLabel,
    required this.slotsLabel,
    required this.priceLabel,
    required this.interestedLabel,
    required this.actionLabel,
    required this.statsLabel,
    required this.distanceLabel,
  });

  final String author;
  final String avatarUrl;
  final String timeAgo;
  final String message;
  final String imageUrl;
  final String dateLabel;
  final String timeLabel;
  final String slotsLabel;
  final String priceLabel;
  final String interestedLabel;
  final String actionLabel;
  final String statsLabel;
  final String distanceLabel;
}

class ProfileReview {
  const ProfileReview({
    required this.author,
    required this.avatarUrl,
    required this.rating,
    required this.message,
    required this.timeAgo,
  });

  final String author;
  final String avatarUrl;
  final double rating;
  final String message;
  final String timeAgo;
}

class ProfileStatistic {
  const ProfileStatistic({required this.value, required this.label, required this.accent});

  final String value;
  final String label;
  final Color accent;
}

class PendingSocialStat {
  const PendingSocialStat({
    required this.value,
    required this.label,
    required this.accent,
    this.pillLabel,
  });

  final String value;
  final String label;
  final Color accent;
  final String? pillLabel;
}

class PendingSportCardData {
  const PendingSportCardData({
    required this.name,
    required this.level,
    required this.detail,
    required this.cardGradient,
    required this.cardBorderColor,
    required this.iconGradient,
    required this.chipLabel,
    required this.chipColor,
  });

  final String name;
  final String level;
  final String detail;
  final List<Color> cardGradient;
  final Color cardBorderColor;
  final List<Color> iconGradient;
  final String chipLabel;
  final Color chipColor;
}

class PendingAnnouncement {
  const PendingAnnouncement({
    required this.title,
    required this.message,
    required this.helper,
  });

  final String title;
  final String message;
  final String helper;
}

class PendingPrivacySetting {
  const PendingPrivacySetting({
    required this.title,
    required this.description,
    required this.accent,
  });

  final String title;
  final String description;
  final Color accent;
}

class PendingRecommendation {
  const PendingRecommendation({
    required this.title,
    required this.subtitle,
    required this.iconColor,
  });

  final String title;
  final String subtitle;
  final Color iconColor;
}

enum StoryStatus { online, recent, idle }

class StoryPreview {
  const StoryPreview({
    this.name,
    this.imageUrl,
    this.status = StoryStatus.idle,
    this.isCreate = false,
  });

  final String? name;
  final String? imageUrl;
  final StoryStatus status;
  final bool isCreate;
}

class QuickShortcut {
  const QuickShortcut({required this.label, required this.icon, required this.color});

  final String label;
  final IconData icon;
  final Color color;
}

class PartnerPost {
  const PartnerPost({
    required this.author,
    required this.avatarUrl,
    required this.heading,
    required this.message,
    required this.sport,
    required this.sportColor,
    required this.chips,
    required this.scheduleLabel,
    required this.levelLabel,
    required this.imageUrl,
    required this.stats,
    required this.contactLabel,
  });

  final String author;
  final String avatarUrl;
  final String heading;
  final String message;
  final String sport;
  final Color sportColor;
  final List<String> chips;
  final String scheduleLabel;
  final String levelLabel;
  final String imageUrl;
  final PartnerPostStats stats;
  final String contactLabel;
}

class PartnerPostStats {
  const PartnerPostStats({
    required this.likes,
    required this.comments,
    required this.shares,
    required this.participants,
  });

  final int likes;
  final int comments;
  final int shares;
  final int participants;
}

class PartnerSuggestion {
  const PartnerSuggestion({required this.name, required this.avatarUrl, required this.tags});

  final String name;
  final String avatarUrl;
  final List<String> tags;
}

class WeeklySummary {
  const WeeklySummary({
    required this.activeFriends,
    required this.sessions,
    required this.streak,
    required this.points,
  });

  final int activeFriends;
  final int sessions;
  final int streak;
  final int points;
}

class Friend {
  const Friend({
    required this.name,
    required this.avatarUrl,
    required this.distance,
    required this.levelTag,
    required this.statusTag,
    required this.attributes,
  });

  final String name;
  final String avatarUrl;
  final String distance;
  final FriendTag levelTag;
  final FriendTag statusTag;
  final List<String> attributes;
}

class FriendTag {
  const FriendTag({required this.label, required this.color});

  final String label;
  final Color color;
}

class FriendStatCard {
  const FriendStatCard({
    required this.value,
    required this.label,
    required this.icon,
  });

  final String value;
  final String label;
  final IconData icon;
}

class FriendActivityItem {
  const FriendActivityItem({
    required this.avatarUrl,
    required this.message,
    required this.timeAgo,
  });

  final String avatarUrl;
  final String message;
  final String timeAgo;
}

class FriendSuggestion {
  const FriendSuggestion({
    required this.name,
    required this.avatarUrl,
    required this.subtitle,
  });

  final String name;
  final String avatarUrl;
  final String subtitle;
}

class FriendQuickAction {
  const FriendQuickAction({
    required this.label,
    required this.icon,
    required this.background,
    required this.foreground,
  });

  final String label;
  final IconData icon;
  final Color background;
  final Color foreground;
}

class OnlineFriend {
  const OnlineFriend({
    required this.name,
    required this.avatarUrl,
  });

  final String name;
  final String avatarUrl;
}

class ProfileAvailabilityDay {
  const ProfileAvailabilityDay({
    required this.day,
    required this.date,
    required this.isAvailable,
  });

  final String day;
  final String date;
  final bool isAvailable;
}

class ProfileAvailabilitySummary {
  const ProfileAvailabilitySummary({
    required this.headline,
    required this.preferredTime,
  });

  final String headline;
  final String preferredTime;
}

class ProfilePresence {
  const ProfilePresence({
    required this.statusLabel,
    required this.responseLabel,
    required this.responseValue,
    required this.lastActivity,
  });

  final String statusLabel;
  final String responseLabel;
  final String responseValue;
  final String lastActivity;
}

class ProfileCompatibility {
  const ProfileCompatibility({
    required this.percentage,
    required this.sportsInCommon,
    required this.levelsMatch,
    required this.proximity,
    required this.experienceSummary,
  });

  final int percentage;
  final int sportsInCommon;
  final bool levelsMatch;
  final String proximity;
  final List<String> experienceSummary;
}

class ProfileContactPreference {
  const ProfileContactPreference({
    required this.icon,
    required this.background,
    required this.title,
    required this.subtitle,
    required this.statusLabel,
    required this.statusColor,
  });

  final IconData icon;
  final Color background;
  final String title;
  final String subtitle;
  final String statusLabel;
  final Color statusColor;
}

class UpcomingEvent {
  const UpcomingEvent({
    required this.title,
    required this.dateLabel,
    required this.timeLabel,
    required this.location,
    required this.participantsLabel,
    required this.accentColor,
  });

  final String title;
  final String dateLabel;
  final String timeLabel;
  final String location;
  final String participantsLabel;
  final Color accentColor;
}

class ActivityFeedItem {
  const ActivityFeedItem({
    required this.iconColor,
    required this.icon,
    required this.message,
    required this.timeAgo,
  });

  final Color iconColor;
  final IconData icon;
  final String message;
  final String timeAgo;
}

class UserActionFeedback {
  const UserActionFeedback({
    required this.icon,
    required this.title,
    required this.message,
    required this.background,
    required this.foreground,
  });

  final IconData icon;
  final String title;
  final String message;
  final Color background;
  final Color foreground;
}

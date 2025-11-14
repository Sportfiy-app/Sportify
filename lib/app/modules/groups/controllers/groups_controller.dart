import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupsController extends GetxController {
  final RxString searchQuery = ''.obs;
  final RxString selectedFilter = 'Tous'.obs;

  List<GroupsFilterChip> get filters => const [
        GroupsFilterChip(label: 'Tous', icon: Icons.all_inclusive_rounded),
        GroupsFilterChip(label: 'Football', icon: Icons.sports_soccer_rounded),
        GroupsFilterChip(label: 'Basketball', icon: Icons.sports_basketball_rounded),
        GroupsFilterChip(label: 'Running', icon: Icons.directions_run_rounded),
        GroupsFilterChip(label: 'Tennis', icon: Icons.sports_tennis_rounded),
      ];

  List<GroupStatCard> get stats => const [
        GroupStatCard(icon: Icons.groups_rounded, value: '127', label: 'Groupes actifs', color: Color(0xFF176BFF)),
        GroupStatCard(icon: Icons.person_pin_circle_rounded, value: '1.2k', label: 'Membres', color: Color(0xFF16A34A)),
        GroupStatCard(icon: Icons.event_available_rounded, value: '45', label: 'Événements', color: Color(0xFFFFB800)),
      ];

  List<MyGroupCard> get myGroups => const [
        MyGroupCard(
          title: 'Lions de Paris FC',
          sport: 'Football',
          membersLabel: '24 membres',
          upcomingLabel: '3 matchs cette semaine',
          badgeColor: Color(0xFF176BFF),
        ),
        MyGroupCard(
          title: 'Basket Vincennes',
          sport: 'Basketball',
          membersLabel: '18 membres',
          upcomingLabel: '1 match demain',
          badgeColor: Color(0xFFFFB800),
        ),
      ];

  List<GroupHighlightCard> get recommended => const [
        GroupHighlightCard(
          name: 'FC Boulogne United',
          sport: 'Football',
          location: 'Boulogne-Billancourt',
          rating: 4.8,
          members: 32,
          distance: '2.1 km',
          activity: 'Actif',
        ),
        GroupHighlightCard(
          name: 'Paris Ballers',
          sport: 'Basketball',
          location: '15ᵉ arrondissement',
          rating: 4.6,
          members: 28,
          distance: '1.8 km',
          activity: 'En ligne',
        ),
      ];

  GroupHeroCard get featuredGroup => const GroupHeroCard(
        name: 'Runners de Paris',
        sport: 'Running • Île-de-France',
        members: 156,
        badges: [
          GroupBadge(icon: Icons.bolt_rounded, label: 'Très actif'),
          GroupBadge(icon: Icons.workspace_premium_rounded, label: 'Top groupe'),
        ],
      );

  List<GroupHeroCard> get popularGroups => const [
        GroupHeroCard(
          name: 'Volley Beach Paris',
          sport: 'Volleyball • Bois de Vincennes',
          members: 89,
          badges: [
            GroupBadge(icon: Icons.terrain_rounded, label: 'Extérieur'),
            GroupBadge(icon: Icons.people_alt_outlined, label: 'Mixte'),
          ],
          accentColor: Color(0xFF16A34A),
        ),
      ];

  List<GroupEventCard> get upcomingEvents => const [
        GroupEventCard(
          dayLabel: 'DIM',
          dayNumber: '24',
          title: 'Match amical - Lions vs Eagles',
          timeLabel: '14:00 - 16:00',
          locationLabel: 'Stade Jean Bouin',
          participantsLabel: '12 participants',
          statusLabel: 'Inscrit',
        ),
        GroupEventCard(
          dayLabel: 'LUN',
          dayNumber: '25',
          title: 'Tournoi de basket 3v3',
          timeLabel: '18:30 - 21:00',
          locationLabel: 'Gymnase Dupleix',
          participantsLabel: '8 participants',
        ),
      ];

  List<GroupCategoryCard> get categories => const [
        GroupCategoryCard(title: 'Football', activeGroups: '45 groupes actifs', color: Color(0xFF176BFF)),
        GroupCategoryCard(title: 'Basketball', activeGroups: '32 groupes actifs', color: Color(0xFFFFB800)),
        GroupCategoryCard(title: 'Running', activeGroups: '28 groupes actifs', color: Color(0xFF16A34A)),
        GroupCategoryCard(title: 'Tennis', activeGroups: '19 groupes actifs', color: Color(0xFFA855F7)),
      ];

  List<GroupFeatureCard> get features => const [
        GroupFeatureCard(
          title: 'Tournois & Ligues',
          description: 'Participez aux compétitions organisées',
          icon: Icons.emoji_events_rounded,
          background: Color(0x19176BFF),
        ),
        GroupFeatureCard(
          title: 'Classements',
          description: 'Suivez vos performances et progressez',
          icon: Icons.bar_chart_rounded,
          background: Color(0x1916A34A),
        ),
        GroupFeatureCard(
          title: 'Créer un groupe',
          description: 'Lancez votre propre communauté sportive',
          icon: Icons.add_circle_outline_rounded,
          background: Color(0x19FFB800),
        ),
      ];

  List<GroupActivityItem> get recentActivities => const [
        GroupActivityItem(
          author: 'Marc Dubois',
          message: 'a rejoint le groupe',
          target: 'Lions de Paris FC',
          timeLabel: 'Il y a 2 heures',
        ),
        GroupActivityItem(
          author: 'Sophie Martin',
          message: 'a organisé un nouveau match dans',
          target: 'Basket Vincennes',
          timeLabel: 'Il y a 4 heures',
        ),
        GroupActivityItem(
          author: 'Thomas Leroy',
          message: 'a remporté le tournoi de',
          target: 'Tennis Club Neuilly',
          timeLabel: 'Hier',
        ),
      ];
}

class GroupsFilterChip {
  const GroupsFilterChip({required this.label, required this.icon});
  final String label;
  final IconData icon;
}

class GroupStatCard {
  const GroupStatCard({required this.icon, required this.value, required this.label, required this.color});
  final IconData icon;
  final String value;
  final String label;
  final Color color;
}

class MyGroupCard {
  const MyGroupCard({
    required this.title,
    required this.sport,
    required this.membersLabel,
    required this.upcomingLabel,
    required this.badgeColor,
  });

  final String title;
  final String sport;
  final String membersLabel;
  final String upcomingLabel;
  final Color badgeColor;
}

class GroupHighlightCard {
  const GroupHighlightCard({
    required this.name,
    required this.sport,
    required this.location,
    required this.rating,
    required this.members,
    required this.distance,
    required this.activity,
  });

  final String name;
  final String sport;
  final String location;
  final double rating;
  final int members;
  final String distance;
  final String activity;
}

class GroupBadge {
  const GroupBadge({required this.icon, required this.label});
  final IconData icon;
  final String label;
}

class GroupHeroCard {
  const GroupHeroCard({
    required this.name,
    required this.sport,
    required this.members,
    required this.badges,
    this.accentColor = const Color(0xFF176BFF),
  });

  final String name;
  final String sport;
  final int members;
  final List<GroupBadge> badges;
  final Color accentColor;
}

class GroupEventCard {
  const GroupEventCard({
    required this.dayLabel,
    required this.dayNumber,
    required this.title,
    required this.timeLabel,
    required this.locationLabel,
    required this.participantsLabel,
    this.statusLabel,
  });

  final String dayLabel;
  final String dayNumber;
  final String title;
  final String timeLabel;
  final String locationLabel;
  final String participantsLabel;
  final String? statusLabel;
}

class GroupCategoryCard {
  const GroupCategoryCard({required this.title, required this.activeGroups, required this.color});
  final String title;
  final String activeGroups;
  final Color color;
}

class GroupFeatureCard {
  const GroupFeatureCard({required this.title, required this.description, required this.icon, required this.background});
  final String title;
  final String description;
  final IconData icon;
  final Color background;
}

class GroupActivityItem {
  const GroupActivityItem({required this.author, required this.message, required this.target, required this.timeLabel});
  final String author;
  final String message;
  final String target;
  final String timeLabel;
}

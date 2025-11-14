import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileActionsController extends GetxController {
  ProfileHeader get header => const ProfileHeader(
        name: 'Alexandre Martin',
        username: '@alexsport92',
        avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=300&q=60',
        levelLabel: 'Niveau Expert',
        sportsCountLabel: '5 sports',
        matches: 127,
        wins: 89,
        rating: 4,
      );

  List<QuickAction> get quickActions => const [
        QuickAction(label: 'Réserver', icon: Icons.calendar_month_rounded, gradient: [Color(0xFF176BFF), Color(0xFF0F5AE0)]),
        QuickAction(label: 'Inviter', icon: Icons.person_add_alt_1_rounded, gradient: [Color(0xFF16A34A), Color(0xFF22C55E)]),
        QuickAction(label: 'Tournois', icon: Icons.military_tech_rounded, gradient: [Color(0xFFFFB800), Color(0xFFF97316)]),
        QuickAction(label: 'Stats', icon: Icons.bar_chart_rounded, gradient: [Color(0xFF0EA5E9), Color(0xFF2563EB)]),
      ];

  List<SportEntry> get sports => const [
        SportEntry(
          name: 'Football',
          expertise: 'Expert • 5 ans',
          badgeLabel: 'Niveau 9/10',
          progress: 0.9,
          color: Color(0xFF176BFF),
        ),
        SportEntry(
          name: 'Tennis',
          expertise: 'Avancé • 3 ans',
          badgeLabel: 'Niveau 7/10',
          progress: 0.7,
          color: Color(0xFF16A34A),
        ),
        SportEntry(
          name: 'Basketball',
          expertise: 'Intermédiaire • 2 ans',
          badgeLabel: 'Niveau 6/10',
          progress: 0.6,
          color: Color(0xFFFFB800),
        ),
      ];

  List<BadgeEntry> get primaryBadges => const [
        BadgeEntry(label: 'Champion local', gradient: [Color(0xFFFFB800), Color(0xFFCA8A04)]),
        BadgeEntry(label: 'Série de 10', gradient: [Color(0xFF176BFF), Color(0xFF0F5AE0)]),
        BadgeEntry(label: 'Fair-Play', gradient: [Color(0xFF16A34A), Color(0xFF22C55E)]),
        BadgeEntry(label: 'Social', gradient: [Color(0xFFA855F7), Color(0xFF7E22CE)]),
        BadgeEntry(label: 'Régulier', gradient: [Color(0xFF0EA5E9), Color(0xFF2563EB)]),
        BadgeEntry(label: 'À débloquer', gradient: [Color(0xFFE2E8F0), Color(0xFFE2E8F0)], muted: true),
      ];

  List<ActivityEntry> get activities => const [
        ActivityEntry(
          title: 'Match gagné',
          subtitle: 'Football • Terrain Central',
          statusLabel: 'Victoire',
          statusColor: Color(0xFF16A34A),
          timeLabel: 'Il y a 2h',
        ),
        ActivityEntry(
          title: 'Réservation confirmée',
          subtitle: 'Tennis • Court 3',
          statusLabel: 'Demain 14h',
          statusColor: Color(0xFF176BFF),
          timeLabel: 'Il y a 1j',
        ),
        ActivityEntry(
          title: 'Nouveau badge obtenu',
          subtitle: 'Fair-Play • 50 matchs',
          statusLabel: 'Badge',
          statusColor: Color(0xFFFFB800),
          timeLabel: 'Il y a 3j',
        ),
      ];

  List<EventEntry> get upcomingEvents => const [
        EventEntry(
          day: '15',
          month: 'NOV',
          title: 'Match de Football',
          location: 'Terrain Central',
          time: '18h00',
          priceLabel: null,
          ctaLabel: 'Rejoindre',
          gradient: [Color(0x33176BFF), Color(0x33176BFF)],
          participantCount: 7,
        ),
        EventEntry(
          day: '18',
          month: 'NOV',
          title: 'Tournoi de Tennis',
          location: 'Club Raquette',
          time: '14h00',
          priceLabel: 'Prix: 50€',
          ctaLabel: 'S’inscrire',
          gradient: [Color(0x1916A34A), Color(0x1916A34A)],
          participantCount: null,
        ),
      ];

  List<PreferenceEntry> get preferences => const [
        PreferenceEntry(label: 'Notifications', icon: Icons.notifications_active_rounded, enabled: true),
        PreferenceEntry(label: 'Localisation', icon: Icons.location_on_rounded, enabled: true),
        PreferenceEntry(label: 'Profil public', icon: Icons.public_rounded, enabled: true),
      ];

  List<AccountActionEntry> get accountActions => const [
        AccountActionEntry(label: 'Modifier le profil', icon: Icons.edit_rounded),
        AccountActionEntry(label: 'Partager le profil', icon: Icons.share_rounded),
        AccountActionEntry(label: 'Exporter les données', icon: Icons.download_rounded),
        AccountActionEntry(label: 'Confidentialité', icon: Icons.lock_outline_rounded),
        AccountActionEntry(label: 'Se déconnecter', icon: Icons.logout_rounded, isDanger: true),
      ];
}

class ProfileHeader {
  const ProfileHeader({
    required this.name,
    required this.username,
    required this.avatarUrl,
    required this.levelLabel,
    required this.sportsCountLabel,
    required this.matches,
    required this.wins,
    required this.rating,
  });

  final String name;
  final String username;
  final String avatarUrl;
  final String levelLabel;
  final String sportsCountLabel;
  final int matches;
  final int wins;
  final int rating;
}

class QuickAction {
  const QuickAction({required this.label, required this.icon, required this.gradient});

  final String label;
  final IconData icon;
  final List<Color> gradient;
}

class SportEntry {
  const SportEntry({
    required this.name,
    required this.expertise,
    required this.badgeLabel,
    required this.progress,
    required this.color,
  });

  final String name;
  final String expertise;
  final String badgeLabel;
  final double progress;
  final Color color;
}

class BadgeEntry {
  const BadgeEntry({required this.label, required this.gradient, this.muted = false});

  final String label;
  final List<Color> gradient;
  final bool muted;
}

class ActivityEntry {
  const ActivityEntry({
    required this.title,
    required this.subtitle,
    required this.statusLabel,
    required this.statusColor,
    required this.timeLabel,
  });

  final String title;
  final String subtitle;
  final String statusLabel;
  final Color statusColor;
  final String timeLabel;
}

class EventEntry {
  const EventEntry({
    required this.day,
    required this.month,
    required this.title,
    required this.location,
    required this.time,
    required this.priceLabel,
    required this.ctaLabel,
    required this.gradient,
    this.participantCount,
  });

  final String day;
  final String month;
  final String title;
  final String location;
  final String time;
  final String? priceLabel;
  final String? ctaLabel;
  final List<Color> gradient;
  final int? participantCount;
}

class PreferenceEntry {
  const PreferenceEntry({required this.label, required this.icon, required this.enabled});

  final String label;
  final IconData icon;
  final bool enabled;
}

class AccountActionEntry {
  const AccountActionEntry({required this.label, required this.icon, this.isDanger = false});

  final String label;
  final IconData icon;
  final bool isDanger;
}


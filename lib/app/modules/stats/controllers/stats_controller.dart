import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatsController extends GetxController {
  final RxString performanceScope = 'month'.obs;

  PlayerProfile get playerProfile => const PlayerProfile(
        name: 'Alexandre Martin',
        role: 'Joueur Actif',
        avatarUrl: 'https://images.unsplash.com/photo-1502767089025-6572583495b0?auto=format&fit=crop&w=240&q=60',
        levelLabel: 'Niveau 12',
        points: 847,
        matchesPlayed: 156,
        presenceRate: 0.89,
        averageRating: 7.8,
      );

  KeyMetrics get keyMetrics => const KeyMetrics(
        weekPlaytimeHours: 8.5,
        weekWins: 124,
        winRate: 0.79,
        fitnessHours: 12,
        levelTrend: 6.5,
      );

  List<SportStat> get sports => const [
        SportStat(
          name: 'Football',
          roleLabel: 'Sport principal',
          iconColor: Color(0xFF176BFF),
          matches: 89,
          hours: 45,
          level: 8.2,
          badgeLabel: 'Expert',
          gradient: [Color(0x19176BFF), Color(0x0C0F5AE0)],
          progress: 0.75,
          trendLabel: '+15%',
        ),
        SportStat(
          name: 'Basketball',
          roleLabel: 'Sport secondaire',
          iconColor: Color(0xFFF59E0B),
          matches: 34,
          hours: 18,
          level: 7.1,
          badgeLabel: 'Avancé',
          gradient: [Color(0x19FFB800), Color(0x0CFFB800)],
          progress: 0.68,
          trendLabel: '+8%',
        ),
        SportStat(
          name: 'Tennis de table',
          roleLabel: 'Récréatif',
          iconColor: Color(0xFF0EA5E9),
          matches: 33,
          hours: 12,
          level: 6.5,
          badgeLabel: 'Intermédiaire',
          gradient: [Color(0x190EA5E9), Color(0x0C0EA5E9)],
          progress: 0.54,
          trendLabel: '+4%',
        ),
      ];

  List<PerformancePoint> get performanceData => const [
        PerformancePoint(monthLabel: 'Jan', matches: 4, level: 7.0),
        PerformancePoint(monthLabel: 'Fév', matches: 6, level: 7.2),
        PerformancePoint(monthLabel: 'Mar', matches: 7, level: 7.5),
        PerformancePoint(monthLabel: 'Avr', matches: 5, level: 7.3),
        PerformancePoint(monthLabel: 'Mai', matches: 8, level: 7.8),
        PerformancePoint(monthLabel: 'Jun', matches: 9, level: 8.1),
        PerformancePoint(monthLabel: 'Jul', matches: 6, level: 7.9),
        PerformancePoint(monthLabel: 'Août', matches: 10, level: 8.4),
        PerformancePoint(monthLabel: 'Sep', matches: 7, level: 8.0),
        PerformancePoint(monthLabel: 'Oct', matches: 11, level: 8.2),
        PerformancePoint(monthLabel: 'Nov', matches: 9, level: 8.1),
        PerformancePoint(monthLabel: 'Déc', matches: 5, level: 7.6),
      ];

  List<AchievementBadge> get badges => const [
        AchievementBadge(
          title: 'Série',
          description: '15 jours',
          gradient: [Color(0x4CFFB800), Color(0x19FFB800)],
          icon: Icons.local_fire_department_rounded,
        ),
        AchievementBadge(
          title: 'Champion',
          description: '5 victoires',
          gradient: [Color(0x3316A34A), Color(0x1916A34A)],
          icon: Icons.emoji_events_rounded,
        ),
        AchievementBadge(
          title: 'Social',
          description: '50 amis',
          gradient: [Color(0x33176BFF), Color(0x19176BFF)],
          icon: Icons.groups_rounded,
        ),
        AchievementBadge(
          title: 'Régulier',
          description: '100h jeu',
          gradient: [Color(0x330EA5E9), Color(0x190EA5E9)],
          icon: Icons.schedule_rounded,
        ),
        AchievementBadge(
          title: 'Expert',
          description: 'Niveau 8+',
          gradient: [Color(0x33F59E0B), Color(0x19F59E0B)],
          icon: Icons.verified_rounded,
        ),
        AchievementBadge(
          title: 'À débloquer',
          description: 'Prochain badge',
          gradient: [Color(0xFFF3F4F6), Color(0xFFE5E7EB)],
          icon: Icons.lock_open_rounded,
          muted: true,
        ),
      ];

  List<ActivityItem> get recentActivity => const [
        ActivityItem(
          iconColor: Color(0x3316A34A),
          title: 'Match de football gagné',
          subtitle: 'Terrain Municipal - Score: 3-1',
          timestamp: 'Il y a 2h',
          rewardLabel: '+25 XP',
          rewardColor: Color(0xFF16A34A),
        ),
        ActivityItem(
          iconColor: Color(0x33FFB800),
          title: 'Nouveau badge débloqué',
          subtitle: 'Série de 15 jours consécutifs',
          timestamp: 'Hier',
          rewardLabel: 'Badge',
          rewardColor: Color(0xFFFFB800),
        ),
        ActivityItem(
          iconColor: Color(0x33176BFF),
          title: 'Nouveau partenaire ajouté',
          subtitle: 'Marie L. - Tennis de table',
          timestamp: '2 jours',
          rewardLabel: 'Ami',
          rewardColor: Color(0xFF176BFF),
        ),
      ];

  List<ObjectiveGoal> get objectives => const [
        ObjectiveGoal(
          title: 'Défi mensuel',
          description: 'Jouer 20 matchs ce mois-ci',
          progressLabel: '13/20',
          progress: 0.65,
          statusLabel: 'En cours',
          statusColor: Color(0xFF16A34A),
          metaLabel: '7 matchs restants • 12 jours',
        ),
        ObjectiveGoal(
          title: 'Objectif fitness',
          description: 'Atteindre 30h de jeu ce mois',
          progressLabel: '25.5h/30h',
          progress: 0.85,
          statusLabel: 'Presque',
          statusColor: Color(0xFFF59E0B),
          metaLabel: '4.5h restantes • Plus que quelques matchs !',
        ),
        ObjectiveGoal(
          title: 'Défi social',
          description: 'Inviter 5 nouveaux amis',
          progressLabel: '2/5',
          progress: 0.4,
          statusLabel: 'Nouveau',
          statusColor: Color(0xFF176BFF),
          metaLabel: '3 invitations restantes • Récompense: 100 XP',
        ),
      ];

  WeeklySummary get weeklySummary => const WeeklySummary(
        dateRange: '28 Oct - 3 Nov',
        totalHours: 14,
        deltaHours: '+2h',
        activeDays: 6,
        dayEntries: [
          WeeklyDay(label: 'L', hours: '2h', state: WeeklyDayState.positive),
          WeeklyDay(label: 'M', hours: '1.5h', state: WeeklyDayState.positive),
          WeeklyDay(label: 'M', hours: '0h', state: WeeklyDayState.inactive),
          WeeklyDay(label: 'J', hours: '3h', state: WeeklyDayState.highlight),
          WeeklyDay(label: 'V', hours: '2.5h', state: WeeklyDayState.positive),
          WeeklyDay(label: 'S', hours: '4h', state: WeeklyDayState.positive),
          WeeklyDay(label: 'D', hours: '1h', state: WeeklyDayState.neutral),
        ],
      );

  List<RecordCard> get records => const [
        RecordCard(
          title: 'Série victoires',
          value: '8',
          description: 'matchs consécutifs',
          badgeLabel: 'Nouveau !',
          icon: Icons.local_fire_department_rounded,
          badgeColor: Color(0xFF16A34A),
        ),
        RecordCard(
          title: 'Plus long match',
          value: '2h45',
          description: 'Football - Dimanche',
          badgeLabel: 'Cette semaine',
          icon: Icons.timer_rounded,
          badgeColor: Color(0xFF176BFF),
        ),
        RecordCard(
          title: 'Partenaires uniques',
          value: '47',
          description: 'joueurs différents',
          badgeLabel: 'Ce mois',
          icon: Icons.diversity_3_rounded,
          badgeColor: Color(0xFFFFB800),
        ),
        RecordCard(
          title: 'Meilleure note',
          value: '9.2',
          description: 'Tennis de table',
          badgeLabel: 'Total',
          icon: Icons.military_tech_rounded,
          badgeColor: Color(0xFF0EA5E9),
        ),
      ];
}

class PlayerProfile {
  const PlayerProfile({
    required this.name,
    required this.role,
    required this.avatarUrl,
    required this.levelLabel,
    required this.points,
    required this.matchesPlayed,
    required this.presenceRate,
    required this.averageRating,
  });

  final String name;
  final String role;
  final String avatarUrl;
  final String levelLabel;
  final int points;
  final int matchesPlayed;
  final double presenceRate;
  final double averageRating;
}

class KeyMetrics {
  const KeyMetrics({
    required this.weekPlaytimeHours,
    required this.weekWins,
    required this.winRate,
    required this.fitnessHours,
    required this.levelTrend,
  });

  final double weekPlaytimeHours;
  final int weekWins;
  final double winRate;
  final double fitnessHours;
  final double levelTrend;
}

class SportStat {
  const SportStat({
    required this.name,
    required this.roleLabel,
    required this.iconColor,
    required this.matches,
    required this.hours,
    required this.level,
    required this.badgeLabel,
    required this.gradient,
    required this.progress,
    required this.trendLabel,
  });

  final String name;
  final String roleLabel;
  final Color iconColor;
  final int matches;
  final int hours;
  final double level;
  final String badgeLabel;
  final List<Color> gradient;
  final double progress;
  final String trendLabel;
}

class PerformancePoint {
  const PerformancePoint({required this.monthLabel, required this.matches, required this.level});
  final String monthLabel;
  final double matches;
  final double level;
}

class AchievementBadge {
  const AchievementBadge({
    required this.title,
    required this.description,
    required this.gradient,
    required this.icon,
    this.muted = false,
  });

  final String title;
  final String description;
  final List<Color> gradient;
  final IconData icon;
  final bool muted;
}

class ActivityItem {
  const ActivityItem({
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.timestamp,
    required this.rewardLabel,
    required this.rewardColor,
  });

  final Color iconColor;
  final String title;
  final String subtitle;
  final String timestamp;
  final String rewardLabel;
  final Color rewardColor;
}

class ObjectiveGoal {
  const ObjectiveGoal({
    required this.title,
    required this.description,
    required this.progressLabel,
    required this.progress,
    required this.statusLabel,
    required this.statusColor,
    required this.metaLabel,
  });

  final String title;
  final String description;
  final String progressLabel;
  final double progress;
  final String statusLabel;
  final Color statusColor;
  final String metaLabel;
}

class WeeklySummary {
  const WeeklySummary({required this.dateRange, required this.totalHours, required this.deltaHours, required this.activeDays, required this.dayEntries});

  final String dateRange;
  final double totalHours;
  final String deltaHours;
  final int activeDays;
  final List<WeeklyDay> dayEntries;
}

class WeeklyDay {
  const WeeklyDay({required this.label, required this.hours, required this.state});

  final String label;
  final String hours;
  final WeeklyDayState state;
}

enum WeeklyDayState { positive, highlight, inactive, neutral }

class RecordCard {
  const RecordCard({
    required this.title,
    required this.value,
    required this.description,
    required this.badgeLabel,
    required this.icon,
    required this.badgeColor,
  });

  final String title;
  final String value;
  final String description;
  final String badgeLabel;
  final IconData icon;
  final Color badgeColor;
}

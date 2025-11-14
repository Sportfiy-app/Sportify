import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalStatsController extends GetxController {
  final RxInt selectedRangeIndex = 0.obs;

  PlayerSnapshot get player => const PlayerSnapshot(
        name: 'Alexandre Martin',
        subtitle: 'Joueur actif',
        levelLabel: 'Niveau 12',
        xpPoints: 847,
        avatarUrl: 'https://images.unsplash.com/photo-1598970434795-0c54fe7c0648?auto=format&fit=crop&w=200&q=60',
        presenceRate: 89,
        averageRating: 7.8,
        matchesPlayed: 156,
      );

  List<SummaryHighlight> get focusHighlights => const [
        SummaryHighlight(title: 'Temps de jeu', value: '8h 30m', delta: '+15%', icon: Icons.access_time_rounded, color: Color(0xFF16A34A)),
        SummaryHighlight(title: 'Matchs gagnés', value: '124', delta: '79%', icon: Icons.emoji_events_rounded, color: Color(0xFF176BFF)),
      ];

  List<SportSummary> get sportsPracticed => const [
        SportSummary(
          name: 'Football',
          tag: 'Sport principal',
          matches: 89,
          timePlayed: '45h',
          level: 8.2,
          levelLabel: 'Expert',
          cardColor: Color(0xFF176BFF),
          accentColor: Color(0xFF16A34A),
        ),
        SportSummary(
          name: 'Basketball',
          tag: 'Sport secondaire',
          matches: 34,
          timePlayed: '18h',
          level: 7.1,
          levelLabel: 'Avancé',
          cardColor: Color(0xFFF59E0B),
          accentColor: Color(0xFFF59E0B),
        ),
        SportSummary(
          name: 'Tennis de table',
          tag: 'Récréatif',
          matches: 33,
          timePlayed: '12h',
          level: 6.5,
          levelLabel: 'Intermédiaire',
          cardColor: Color(0xFF0EA5E9),
          accentColor: Color(0xFF0EA5E9),
        ),
      ];

  List<PerformancePoint> get monthlyPerformance => List.generate(
        8,
        (index) => PerformancePoint(
          label: ['Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Jun', 'Jul', 'Août'][index],
          value: (sin(index / 1.5) + 1.3) * 5 + Random(index).nextDouble() * 2,
        ),
      );

  List<RadarMetric> get radarMetrics => const [
        RadarMetric(label: 'Assiduité', value: 0.89, color: Color(0xFF176BFF)),
        RadarMetric(label: 'Niveau moyen', value: 0.78, color: Color(0xFF16A34A)),
      ];

  List<AchievementBadge> get achievements => const [
        AchievementBadge(title: 'Série', subtitle: '15 jours', color: Color(0xFFFFB800), icon: Icons.local_fire_department_rounded),
        AchievementBadge(title: 'Champion', subtitle: '5 victoires', color: Color(0xFF16A34A), icon: Icons.emoji_events_rounded),
        AchievementBadge(title: 'Social', subtitle: '50 amis', color: Color(0xFF176BFF), icon: Icons.people_alt_rounded),
        AchievementBadge(title: 'Régulier', subtitle: '100h jeu', color: Color(0xFF0EA5E9), icon: Icons.alarm_rounded),
        AchievementBadge(title: 'Expert', subtitle: 'Niveau 8+', color: Color(0xFFF59E0B), icon: Icons.military_tech_rounded),
      ];

  List<ActivityItem> get recentActivity => const [
        ActivityItem(
          title: 'Match de football gagné',
          subtitle: 'Terrain Municipal - Score: 3-1',
          timeAgo: 'Il y a 2h',
          rewardLabel: '+25 XP',
          iconColor: Color(0xFF16A34A),
          icon: Icons.sports_soccer_rounded,
        ),
        ActivityItem(
          title: 'Nouveau badge débloqué',
          subtitle: 'Série de 15 jours consécutifs',
          timeAgo: 'Hier',
          rewardLabel: 'Badge',
          iconColor: Color(0xFFFFB800),
          icon: Icons.emoji_events_outlined,
        ),
        ActivityItem(
          title: 'Nouveau partenaire ajouté',
          subtitle: 'Marie L. - Tennis de table',
          timeAgo: 'Il y a 2 jours',
          rewardLabel: 'Ami',
          iconColor: Color(0xFF176BFF),
          icon: Icons.person_add_alt_rounded,
        ),
      ];

  List<ObjectiveCard> get objectives => const [
        ObjectiveCard(
          title: 'Défi mensuel',
          description: 'Jouer 20 matchs ce mois-ci',
          progress: 13,
          target: 20,
          remainingLabel: '7 matchs restants • 12 jours',
          statusColor: Color(0xFF16A34A),
          statusLabel: 'En cours',
        ),
        ObjectiveCard(
          title: 'Objectif fitness',
          description: 'Atteindre 30h de jeu ce mois',
          progressLabel: '25.5h/30h',
          progress: 25.5,
          target: 30,
          remainingLabel: '4.5h restantes • Plus que quelques matchs !',
          statusColor: Color(0xFFF59E0B),
          statusLabel: 'Presque',
        ),
        ObjectiveCard(
          title: 'Défi social',
          description: 'Inviter 5 nouveaux amis',
          progress: 2,
          target: 5,
          remainingLabel: '3 invitations restantes • Récompense: 100 XP',
          statusColor: Color(0xFF176BFF),
          statusLabel: 'Nouveau',
        ),
      ];

  WeeklySummary get weeklySummary => WeeklySummary(
        dateLabel: '28 Oct - 3 Nov',
        dailyEntries: const [
          DailySummary(label: 'L', hours: 2, color: Color(0xFF16A34A)),
          DailySummary(label: 'M', hours: 1.5, color: Color(0xFF176BFF)),
          DailySummary(label: 'M', hours: 0, color: Color(0xFF9CA3AF)),
          DailySummary(label: 'J', hours: 3, color: Color(0xFFFFB800)),
          DailySummary(label: 'V', hours: 2.5, color: Color(0xFF16A34A)),
          DailySummary(label: 'S', hours: 4, color: Color(0xFF176BFF)),
          DailySummary(label: 'D', hours: 1, color: Color(0xFF0EA5E9)),
        ],
        totalHours: 14,
        deltaHours: '+2h',
        activeDays: 6,
      );

  List<RecordCardData> get records => const [
        RecordCardData(title: 'Série victoires', value: '8', detail: 'matchs consécutifs', highlight: 'Nouveau !', color: Color(0xFF16A34A)),
        RecordCardData(title: 'Plus long match', value: '2h45', detail: 'Football - Dimanche', highlight: 'Cette semaine', color: Color(0xFF176BFF)),
        RecordCardData(title: 'Meilleure note', value: '9.2', detail: 'Tennis de table', highlight: 'Ce mois', color: Color(0xFFFFB800)),
        RecordCardData(title: 'Partenaires uniques', value: '47', detail: 'joueurs différents', highlight: 'Total', color: Color(0xFF0EA5E9)),
      ];
}

class PlayerSnapshot {
  const PlayerSnapshot({
    required this.name,
    required this.subtitle,
    required this.levelLabel,
    required this.xpPoints,
    required this.avatarUrl,
    required this.presenceRate,
    required this.averageRating,
    required this.matchesPlayed,
  });

  final String name;
  final String subtitle;
  final String levelLabel;
  final int xpPoints;
  final String avatarUrl;
  final int presenceRate;
  final double averageRating;
  final int matchesPlayed;
}

class SummaryHighlight {
  const SummaryHighlight({required this.title, required this.value, required this.delta, required this.icon, required this.color});
  final String title;
  final String value;
  final String delta;
  final IconData icon;
  final Color color;
}

class SportSummary {
  const SportSummary({
    required this.name,
    required this.tag,
    required this.matches,
    required this.timePlayed,
    required this.level,
    required this.levelLabel,
    required this.cardColor,
    required this.accentColor,
  });

  final String name;
  final String tag;
  final int matches;
  final String timePlayed;
  final double level;
  final String levelLabel;
  final Color cardColor;
  final Color accentColor;
}

class PerformancePoint {
  const PerformancePoint({required this.label, required this.value});
  final String label;
  final double value;
}

class RadarMetric {
  const RadarMetric({required this.label, required this.value, required this.color});
  final String label;
  final double value;
  final Color color;
}

class AchievementBadge {
  const AchievementBadge({required this.title, required this.subtitle, required this.color, required this.icon});
  final String title;
  final String subtitle;
  final Color color;
  final IconData icon;
}

class ActivityItem {
  const ActivityItem({required this.title, required this.subtitle, required this.timeAgo, required this.rewardLabel, required this.iconColor, required this.icon});
  final String title;
  final String subtitle;
  final String timeAgo;
  final String rewardLabel;
  final Color iconColor;
  final IconData icon;
}

class ObjectiveCard {
  const ObjectiveCard({
    required this.title,
    required this.description,
    this.progressLabel,
    required this.progress,
    required this.target,
    required this.remainingLabel,
    required this.statusColor,
    required this.statusLabel,
  });

  final String title;
  final String description;
  final double progress;
  final double target;
  final String? progressLabel;
  final String remainingLabel;
  final Color statusColor;
  final String statusLabel;
}

class WeeklySummary {
  WeeklySummary({required this.dateLabel, required this.dailyEntries, required this.totalHours, required this.deltaHours, required this.activeDays});
  final String dateLabel;
  final List<DailySummary> dailyEntries;
  final double totalHours;
  final String deltaHours;
  final int activeDays;
}

class DailySummary {
  const DailySummary({required this.label, required this.hours, required this.color});
  final String label;
  final double hours;
  final Color color;
}

class RecordCardData {
  const RecordCardData({required this.title, required this.value, required this.detail, required this.highlight, required this.color});
  final String title;
  final String value;
  final String detail;
  final String highlight;
  final Color color;
}

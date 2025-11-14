import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileStatsController extends GetxController {
  final RxString periodFilter = 'Mois'.obs;
  final RxString challengeFilter = 'En cours'.obs;

  ProfileOverview get overview => const ProfileOverview(
        name: 'Alexandre Martin',
        role: 'Joueur Actif',
        levelLabel: 'Niveau 12',
        xpPoints: 847,
        matchesPlayed: 156,
        presenceRate: 0.89,
        averageRating: 7.8,
        avatarUrl: 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=400&q=60',
      );

  List<QuickStat> get quickStats => const [
        QuickStat(title: 'Temps de jeu', value: '8h 30m', trend: '+15%', trendColor: Color(0xFF16A34A)),
        QuickStat(title: 'Matchs gagnés', value: '124', trend: '79%', trendColor: Color(0xFF16A34A)),
      ];

  List<SportPractice> get sportsPracticed => const [
        SportPractice(
          name: 'Football',
          label: 'Sport principal',
          matches: 89,
          hours: '45h',
          level: 'Expert',
          levelColor: Color(0xFFFFB800),
          levelScore: 8.2,
          trendLabel: '+15%',
          trendColor: Color(0xFF16A34A),
        ),
        SportPractice(
          name: 'Basketball',
          label: 'Sport secondaire',
          matches: 34,
          hours: '18h',
          level: 'Avancé',
          levelColor: Color(0xFFF59E0B),
          levelScore: 7.1,
          trendLabel: '+8%',
          trendColor: Color(0xFFF59E0B),
        ),
        SportPractice(
          name: 'Tennis de table',
          label: 'Récréatif',
          matches: 33,
          hours: '12h',
          level: 'Intermédiaire',
          levelColor: Color(0xFF0EA5E9),
          levelScore: 6.5,
          trendLabel: '+5%',
          trendColor: Color(0xFF0EA5E9),
        ),
      ];

  PerformanceGraph get performanceGraph => PerformanceGraph(
        points: const [
          PerformancePoint(label: 'Jan', value: 3.5),
          PerformancePoint(label: 'Fév', value: 4.2),
          PerformancePoint(label: 'Mar', value: 5.5),
          PerformancePoint(label: 'Avr', value: 4.8),
          PerformancePoint(label: 'Mai', value: 6.2),
          PerformancePoint(label: 'Jun', value: 6.5),
          PerformancePoint(label: 'Jul', value: 7.1),
        ],
        maxValue: 8,
      );

  List<RingStat> get ringStats => const [
        RingStat(title: 'Assiduité', valueLabel: '89%', color: Color(0xFF176BFF), percentage: 0.89),
        RingStat(title: 'Niveau Moyen', valueLabel: '7.8/10', color: Color(0xFF16A34A), percentage: 0.78),
      ];

  List<AchievementBadge> get badges => const [
        AchievementBadge(iconColor: Color(0xFFFFB800), title: 'Série', subtitle: '15 jours'),
        AchievementBadge(iconColor: Color(0xFF16A34A), title: 'Champion', subtitle: '5 victoires'),
        AchievementBadge(iconColor: Color(0xFF176BFF), title: 'Social', subtitle: '50 amis'),
        AchievementBadge(iconColor: Color(0xFF0EA5E9), title: 'Régulier', subtitle: '100h jeu'),
        AchievementBadge(iconColor: Color(0xFFF59E0B), title: 'Expert', subtitle: 'Niveau 8+'),
        AchievementBadge(iconColor: Color(0xFFE5E7EB), title: 'À débloquer', subtitle: 'Prochain badge'),
      ];

  List<ActivityItem> get recentActivity => const [
        ActivityItem(
          title: 'Match de football gagné',
          subtitle: 'Terrain Municipal · Score 3-1',
          timeAgo: 'Il y a 2h',
          deltaLabel: '+25 XP',
          deltaColor: Color(0xFF16A34A),
          iconColor: Color(0xFF16A34A),
        ),
        ActivityItem(
          title: 'Nouveau badge débloqué',
          subtitle: 'Série de 15 jours consécutifs',
          timeAgo: 'Hier',
          deltaLabel: 'Badge',
          deltaColor: Color(0xFFFFB800),
          iconColor: Color(0xFFFFB800),
        ),
        ActivityItem(
          title: 'Nouveau partenaire ajouté',
          subtitle: 'Marie L. · Tennis de table',
          timeAgo: '2 jours',
          deltaLabel: 'Ami',
          deltaColor: Color(0xFF176BFF),
          iconColor: Color(0xFF176BFF),
        ),
      ];

  List<ChallengeCard> get challenges => const [
        ChallengeCard(
          title: 'Défi mensuel',
          description: 'Jouer 20 matchs ce mois-ci',
          progressLabel: '13/20',
          progress: 0.65,
          statusLabel: 'En cours',
          statusColor: Color(0xFF16A34A),
          detail: '7 matchs restants • 12 jours',
          highlightColor: Color(0xFF16A34A),
        ),
        ChallengeCard(
          title: 'Objectif fitness',
          description: 'Atteindre 30h de jeu ce mois',
          progressLabel: '25.5h/30h',
          progress: 0.85,
          statusLabel: 'Presque',
          statusColor: Color(0xFFF59E0B),
          detail: '4.5h restantes • Plus que quelques matchs !',
          highlightColor: Color(0xFFF59E0B),
        ),
        ChallengeCard(
          title: 'Défi social',
          description: 'Inviter 5 nouveaux amis',
          progressLabel: '2/5',
          progress: 0.4,
          statusLabel: 'Nouveau',
          statusColor: Color(0xFF176BFF),
          detail: '3 invitations restantes • Récompense: 100 XP',
          highlightColor: Color(0xFF176BFF),
        ),
      ];

  WeeklySummary get weeklySummary => WeeklySummary(
        weekLabel: '28 Oct - 3 Nov',
        totalHours: '14h',
        hoursDelta: '+2h',
        deltaColor: const Color(0xFF16A34A),
        activeDays: 6,
        days: const [
          WeeklyDay(label: 'L', hours: 2, color: Color(0xFF16A34A)),
          WeeklyDay(label: 'M', hours: 1.5, color: Color(0xFF176BFF)),
          WeeklyDay(label: 'M', hours: 0, color: Color(0xFF9CA3AF)),
          WeeklyDay(label: 'J', hours: 3, color: Color(0xFFFFB800)),
          WeeklyDay(label: 'V', hours: 2.5, color: Color(0xFF16A34A)),
          WeeklyDay(label: 'S', hours: 4, color: Color(0xFF176BFF)),
          WeeklyDay(label: 'D', hours: 1, color: Color(0xFF0EA5E9)),
        ],
      );

  List<RecordCard> get records => const [
        RecordCard(title: 'Série victoires', value: '8', subtitle: 'matchs consécutifs', iconColor: Color(0xFF16A34A)),
        RecordCard(title: 'Plus long match', value: '2h45', subtitle: 'Football · Dimanche', iconColor: Color(0xFF176BFF)),
        RecordCard(title: 'Partenaires uniques', value: '47', subtitle: 'joueurs différents', iconColor: Color(0xFFFFB800)),
        RecordCard(title: 'Meilleure note', value: '9.2', subtitle: 'Tennis de table', iconColor: Color(0xFF0EA5E9)),
      ];
}

class ProfileOverview {
  const ProfileOverview({
    required this.name,
    required this.role,
    required this.levelLabel,
    required this.xpPoints,
    required this.matchesPlayed,
    required this.presenceRate,
    required this.averageRating,
    required this.avatarUrl,
  });

  final String name;
  final String role;
  final String levelLabel;
  final int xpPoints;
  final int matchesPlayed;
  final double presenceRate;
  final double averageRating;
  final String avatarUrl;
}

class QuickStat {
  const QuickStat({required this.title, required this.value, required this.trend, required this.trendColor});
  final String title;
  final String value;
  final String trend;
  final Color trendColor;
}

class SportPractice {
  const SportPractice({
    required this.name,
    required this.label,
    required this.matches,
    required this.hours,
    required this.level,
    required this.levelColor,
    required this.levelScore,
    required this.trendLabel,
    required this.trendColor,
  });

  final String name;
  final String label;
  final int matches;
  final String hours;
  final String level;
  final Color levelColor;
  final double levelScore;
  final String trendLabel;
  final Color trendColor;
}

class PerformanceGraph {
  PerformanceGraph({required this.points, required this.maxValue});
  final List<PerformancePoint> points;
  final double maxValue;
}

class PerformancePoint {
  const PerformancePoint({required this.label, required this.value});
  final String label;
  final double value;
}

class RingStat {
  const RingStat({required this.title, required this.valueLabel, required this.color, required this.percentage});
  final String title;
  final String valueLabel;
  final Color color;
  final double percentage;
}

class AchievementBadge {
  const AchievementBadge({required this.iconColor, required this.title, required this.subtitle});
  final Color iconColor;
  final String title;
  final String subtitle;
}

class ActivityItem {
  const ActivityItem({
    required this.title,
    required this.subtitle,
    required this.timeAgo,
    required this.deltaLabel,
    required this.deltaColor,
    required this.iconColor,
  });

  final String title;
  final String subtitle;
  final String timeAgo;
  final String deltaLabel;
  final Color deltaColor;
  final Color iconColor;
}

class ChallengeCard {
  const ChallengeCard({
    required this.title,
    required this.description,
    required this.progressLabel,
    required this.progress,
    required this.statusLabel,
    required this.statusColor,
    required this.detail,
    required this.highlightColor,
  });

  final String title;
  final String description;
  final String progressLabel;
  final double progress;
  final String statusLabel;
  final Color statusColor;
  final String detail;
  final Color highlightColor;
}

class WeeklySummary {
  WeeklySummary({
    required this.weekLabel,
    required this.totalHours,
    required this.hoursDelta,
    required this.deltaColor,
    required this.activeDays,
    required this.days,
  });

  final String weekLabel;
  final String totalHours;
  final String hoursDelta;
  final Color deltaColor;
  final int activeDays;
  final List<WeeklyDay> days;
}

class WeeklyDay {
  const WeeklyDay({required this.label, required this.hours, required this.color});
  final String label;
  final double hours;
  final Color color;
}

class RecordCard {
  const RecordCard({required this.title, required this.value, required this.subtitle, required this.iconColor});
  final String title;
  final String value;
  final String subtitle;
  final Color iconColor;
}

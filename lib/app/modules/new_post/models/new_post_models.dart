import 'package:flutter/material.dart';

class MediaOption {
  const MediaOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;
}

class CommunityTip {
  const CommunityTip(this.text);

  final String text;
}

class PreviousPost {
  const PreviousPost({required this.title, required this.timeAgo});

  final String title;
  final String timeAgo;
}

class EngagementStat {
  const EngagementStat({required this.value, required this.label, required this.accent});

  final String value;
  final String label;
  final Color accent;
}

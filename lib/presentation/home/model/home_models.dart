import 'package:flutter/foundation.dart';

@immutable
class FeaturedTree {
  final String image;
  final String name;
  final String latin;
  final String fact;

  const FeaturedTree({
    required this.image,
    required this.name,
    required this.latin,
    required this.fact,
  });
}

@immutable
class EcoStat {
  final String label;
  final String value;
  final String icon; // emoji for now (can replace with icons later)

  const EcoStat({
    required this.label,
    required this.value,
    required this.icon,
  });
}

@immutable
class QuickActionItem {
  final String title;
  final String subtitle;
  final String icon; // emoji for simplicity
  final String route;

  const QuickActionItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.route,
  });
}

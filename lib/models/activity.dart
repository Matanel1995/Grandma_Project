import 'package:flutter/foundation.dart';

enum Urgency {
  Low,
  Medium,
  High,
}

class Activity {
  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final List<String> requierd;
  final List<String> importance;
  final int duration;
  final Urgency urgency;
  final int score;

  const Activity({
    required this.id,
    required this.categories,
    required this.title,
    required this.imageUrl,
    required this.requierd,
    required this.importance,
    required this.duration,
    required this.urgency,
    required this.score,
  });
}

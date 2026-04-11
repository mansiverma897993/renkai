import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoodData {
  final double score;
  final List<String> tags;
  final DateTime loggedAt;

  MoodData({
    required this.score,
    required this.tags,
    required this.loggedAt,
  });
}

class CurrentMoodNotifier extends Notifier<MoodData?> {
  @override
  MoodData? build() {
    return null; // Return null if no mood has been logged yet
  }

  void saveMood(double score, List<String> tags) {
    state = MoodData(
      score: score,
      tags: List.from(tags),
      loggedAt: DateTime.now(),
    );
  }
  
  void clearMood() {
    state = null;
  }
}

final currentMoodProvider = NotifierProvider<CurrentMoodNotifier, MoodData?>(() {
  return CurrentMoodNotifier();
});

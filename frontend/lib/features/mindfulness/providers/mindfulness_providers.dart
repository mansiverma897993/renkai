import 'package:flutter_riverpod/flutter_riverpod.dart';

class MindfulnessSession {
  final String id;
  final String type; // 'breathing', 'meditation', 'ambient'
  final String title;
  final int durationMinutes;
  final DateTime completedAt;
  final String? moodBefore;
  final String? moodAfter;

  MindfulnessSession({
    required this.id,
    required this.type,
    required this.title,
    required this.durationMinutes,
    required this.completedAt,
    this.moodBefore,
    this.moodAfter,
  });
}

class MindfulnessHistoryNotifier extends Notifier<List<MindfulnessSession>> {
  @override
  List<MindfulnessSession> build() {
    return [
      MindfulnessSession(
        id: 'mock1',
        type: 'breathing',
        title: 'Box Breathing',
        durationMinutes: 5,
        completedAt: DateTime.now().subtract(const Duration(days: 1)),
        moodBefore: '😟',
        moodAfter: '🙂',
      ),
      MindfulnessSession(
        id: 'mock2',
        type: 'meditation',
        title: 'Sleep Preparation',
        durationMinutes: 10,
        completedAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
    ];
  }

  void addSession(MindfulnessSession session) {
    state = [session, ...state];
  }

  int get totalMindfulMinutes {
    return state.fold(0, (sum, session) => sum + session.durationMinutes);
  }
}

final mindfulnessHistoryProvider = NotifierProvider<MindfulnessHistoryNotifier, List<MindfulnessSession>>(() {
  return MindfulnessHistoryNotifier();
});

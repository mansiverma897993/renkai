import 'package:flutter_riverpod/flutter_riverpod.dart';

// --- Models ---
class ChatMessage {
  final String text;
  final bool isUser;
  final List<String>? options;
  ChatMessage({required this.text, required this.isUser, this.options});
}

class TherapyTeam {
  final String name;
  final String title;
  final String imageUrl;
  TherapyTeam({required this.name, required this.title, required this.imageUrl});
}

class CommunityChat {
  final String name;
  final int participants;
  final int online;
  final String avatarUrl;
  CommunityChat({required this.name, required this.participants, required this.online, required this.avatarUrl});
}

class WellbeingMetrics {
  final double moodTracker;
  final double qualitySleep;
  final double taskCompletion;
  final double stressLevels;
  final int dailySteps;
  final int dailyStepsGoal;
  final double waterIntake;
  final double waterGoal;
  WellbeingMetrics({required this.moodTracker, required this.qualitySleep, required this.taskCompletion, required this.stressLevels, required this.dailySteps, required this.dailyStepsGoal, required this.waterIntake, required this.waterGoal});
}

// --- Providers ---
final chatProvider = StateProvider<List<ChatMessage>>((ref) => [
  ChatMessage(text: "Hi Sage,\nHow would you like me to assist you.", isUser: false, options: [
    "Mental Health Assessment Test",
    "Book A Therapy",
    "Emergency Support",
    "Have a chat 😅"
  ]),
]);

final therapyTeamProvider = Provider<List<TherapyTeam>>((ref) => [
  TherapyTeam(name: "Dr. Maahi Madaan", title: "Therapist", imageUrl: "https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=150"),
  TherapyTeam(name: "Dr. Jessica", title: "Therapist", imageUrl: "https://images.unsplash.com/photo-1594824432258-297ab13f41c6?w=150"),
  TherapyTeam(name: "Dr. Mellisa Jones", title: "Therapist", imageUrl: "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=150"),
  TherapyTeam(name: "Dr. Rahul Menon", title: "Therapist", imageUrl: "https://images.unsplash.com/photo-1622253692010-333f2da6031d?w=150"),
]);

final communityProvider = Provider<List<CommunityChat>>((ref) => [
  CommunityChat(name: "Mind Matters", participants: 2439, online: 320, avatarUrl: "https://images.unsplash.com/photo-1542385151-efd9000785a0?q=80&w=150&auto=format&fit=crop"),
  CommunityChat(name: "Tranquil Tribe 🕊️", participants: 10056, online: 2599, avatarUrl: "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?q=80&w=150&auto=format&fit=crop"),
  CommunityChat(name: "EmpowerNest", participants: 7811, online: 990, avatarUrl: "https://images.unsplash.com/photo-1513360371669-4adf3dd7dff8?q=80&w=150&auto=format&fit=crop"),
  CommunityChat(name: "The Zen Zone", participants: 1136, online: 251, avatarUrl: "https://images.unsplash.com/photo-1493612276216-ee3925520721?q=80&w=150&auto=format&fit=crop"),
]);

final wellbeingProvider = StateProvider<WellbeingMetrics>((ref) => WellbeingMetrics(
  moodTracker: 0.9,
  qualitySleep: 0.75,
  taskCompletion: 0.85,
  stressLevels: 0.4,
  dailySteps: 5782,
  dailyStepsGoal: 8000,
  waterIntake: 2,
  waterGoal: 2.5,
));

class JournalEntry {
  final String title, preview, emoji, date;
  final double score;
  JournalEntry({required this.title, required this.preview, required this.emoji, required this.date, required this.score});
}

class JournalNotifier extends Notifier<List<JournalEntry>> {
  @override
  List<JournalEntry> build() {
    return [
      JournalEntry(title: 'Morning Reflection', preview: 'Today feels like a fresh start. I slept well and...', emoji: '😁', date: 'Today', score: 8.0),
      JournalEntry(title: 'Work Anxiety', preview: 'Felt overwhelmed during the meeting. My chest was tight...', emoji: '😕', date: 'Yesterday', score: 4.0),
      JournalEntry(title: 'Gratitude Moment', preview: 'Had coffee with a friend. Realized how much I needed that...', emoji: '😊', date: '2 days ago', score: 9.0),
      JournalEntry(title: 'Late Night Thoughts', preview: 'Can\'t sleep. My mind keeps racing about tomorrow...', emoji: '😢', date: '3 days ago', score: 3.0),
      JournalEntry(title: 'Breakthrough!', preview: 'Therapy was incredible today. I finally understand why...', emoji: '🙂', date: '4 days ago', score: 7.0),
    ];
  }

  void addEntry(JournalEntry entry) {
    state = [entry, ...state];
  }
}

final journalProvider = NotifierProvider<JournalNotifier, List<JournalEntry>>(() {
  return JournalNotifier();
});

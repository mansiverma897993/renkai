import 'package:flutter/material.dart';
import '../../shared/glass_container.dart';

class MoodEntryScreen extends StatefulWidget {
  const MoodEntryScreen({super.key});

  @override
  State<MoodEntryScreen> createState() => _MoodEntryScreenState();
}

class _MoodEntryScreenState extends State<MoodEntryScreen> {
  double _moodScore = 5;
  final List<String> _tags = ["Work", "Sleep", "Stress", "Social", "Exercise", "Family"];
  final Set<String> _selectedTags = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: AppBar(
        title: const Text("Log your mood"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text(
              "How are you feeling?",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            Text(
              _getMoodEmoji(_moodScore),
              style: const TextStyle(fontSize: 80),
            ),
            const SizedBox(height: 30),
            Slider(
              value: _moodScore,
              min: 1,
              max: 10,
              divisions: 9,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (val) {
                setState(() {
                  _moodScore = val;
                });
                // Note: Implement HapticFeedback here in production
              },
            ),
            const SizedBox(height: 40),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("What's affecting you?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _tags.map((tag) {
                final isSelected = _selectedTags.contains(tag);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      isSelected ? _selectedTags.remove(tag) : _selectedTags.add(tag);
                    });
                  },
                  child: GlassContainer(
                    blur: 5,
                    color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.3) : Colors.white.withOpacity(0.4),
                    borderRadius: 16,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(tag, style: TextStyle(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? Theme.of(context).primaryColor : Colors.black87,
                      )),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Send to Spring Boot Backend API
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text("Save Entry", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }

  String _getMoodEmoji(double score) {
    if (score <= 2) return "😢";
    if (score <= 4) return "😕";
    if (score <= 6) return "😐";
    if (score <= 8) return "🙂";
    return "😁";
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/glass_container.dart';

class MoodCheckinCard extends StatefulWidget {
  const MoodCheckinCard({super.key});

  @override
  State<MoodCheckinCard> createState() => _MoodCheckinCardState();
}

class _MoodCheckinCardState extends State<MoodCheckinCard>
    with SingleTickerProviderStateMixin {
  int? _selectedIndex;
  late AnimationController _pulseController;

  final _moods = const [
    _MoodOption('😢', 'Terrible', 2),
    _MoodOption('😕', 'Bad', 4),
    _MoodOption('😐', 'Okay', 6),
    _MoodOption('🙂', 'Good', 8),
    _MoodOption('😁', 'Great', 10),
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _selectMood(int index) {
    HapticFeedback.mediumImpact();
    setState(() => _selectedIndex = index);
    _pulseController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _selectedIndex != null
                      ? AppColors.moodColor(_moods[_selectedIndex!].score.toDouble())
                      : AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'How are you feeling?',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_moods.length, (i) {
              final isSelected = _selectedIndex == i;
              return GestureDetector(
                onTap: () => _selectMood(i),
                child: AnimatedScale(
                  scale: isSelected ? 1.25 : 1.0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.elasticOut,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.moodColor(_moods[i].score.toDouble()).withOpacity(0.18)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      children: [
                        Text(_moods[i].emoji, style: const TextStyle(fontSize: 32)),
                        const SizedBox(height: 4),
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                            color: isSelected
                                ? AppColors.moodColor(_moods[i].score.toDouble())
                                : Theme.of(context).textTheme.bodySmall?.color ?? Colors.grey,
                          ),
                          child: Text(_moods[i].label),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
          if (_selectedIndex != null) ...[
            const SizedBox(height: 16),
            AnimatedOpacity(
              opacity: _selectedIndex != null ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.moodColor(_moods[_selectedIndex!].score.toDouble()).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Logged! Keep the streak going 🔥',
                    style: TextStyle(
                      color: AppColors.moodColor(_moods[_selectedIndex!].score.toDouble()),
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _MoodOption {
  final String emoji;
  final String label;
  final int score;
  const _MoodOption(this.emoji, this.label, this.score);
}

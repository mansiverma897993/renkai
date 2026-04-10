import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class SuggestedPrompts extends StatelessWidget {
  final Function(String) onPromptTap;

  const SuggestedPrompts({super.key, required this.onPromptTap});

  static const _prompts = [
    '💭 I\'m feeling anxious',
    '😴 Help me sleep',
    '🧠 Let\'s do CBT',
    '😊 I feel grateful today',
    '😤 I need to vent',
    '🌱 Help me grow',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _prompts.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onPromptTap(_prompts[index]),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.2),
                ),
              ),
              child: Text(
                _prompts[index],
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

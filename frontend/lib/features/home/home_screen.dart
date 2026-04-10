import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/gradient_background.dart';
import 'widgets/greeting_header.dart';
import 'widgets/mood_checkin_card.dart';
import 'widgets/quick_actions_grid.dart';
import 'widgets/wellness_ring.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GradientBackground(
      colors: isDark ? AppColors.homeGradientDark : AppColors.homeGradient,
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GreetingHeader(),
              const SizedBox(height: 28),
              const MoodCheckinCard(),
              const SizedBox(height: 20),
              const WellnessRing(),
              const SizedBox(height: 24),
              Text(
                'Quick Actions',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 14),
              QuickActionsGrid(
                onActionTap: (index) {
                  // Navigation is handled by AppShell's PageController
                },
              ),
              const SizedBox(height: 24),
              _buildDailyPlan(context, isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDailyPlan(BuildContext context, bool isDark) {
    final tasks = [
      _PlanTask('Morning Meditation', '🧘', '5 min', true),
      _PlanTask('Journal Reflection', '✍️', '10 min', false),
      _PlanTask('Breathing Exercise', '🌬️', '3 min', false),
      _PlanTask('Gratitude Log', '🙏', '5 min', false),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Today's Plan", style: Theme.of(context).textTheme.headlineSmall),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.accent.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '1/4 done',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.accent,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 110,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: tasks.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Container(
                width: 140,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: task.done
                      ? AppColors.accent.withOpacity(isDark ? 0.15 : 0.1)
                      : (isDark ? AppColors.surfaceDark : Colors.white.withOpacity(0.7)),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: task.done
                        ? AppColors.accent.withOpacity(0.3)
                        : (isDark ? Colors.white.withOpacity(0.08) : Colors.white.withOpacity(0.5)),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(task.emoji, style: const TextStyle(fontSize: 24)),
                        if (task.done)
                          Icon(Icons.check_circle, color: AppColors.accent, size: 20),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.title,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            decoration: task.done ? TextDecoration.lineThrough : null,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          task.duration,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _PlanTask {
  final String title;
  final String emoji;
  final String duration;
  final bool done;
  const _PlanTask(this.title, this.emoji, this.duration, this.done);
}

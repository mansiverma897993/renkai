import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/mock_providers.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/gradient_background.dart';
import '../../shared/widgets/glass_container.dart';
import 'journal_entry_editor.dart';
import 'widgets/journal_card.dart';
import 'widgets/mood_chart.dart';
import 'widgets/insight_card.dart';

class JournalScreen extends ConsumerStatefulWidget {
  const JournalScreen({super.key});

  @override
  ConsumerState<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends ConsumerState<JournalScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;



  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GradientBackground(
      colors: isDark ? AppColors.journalGradientDark : AppColors.journalGradient,
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Journal', style: Theme.of(context).textTheme.displayMedium),
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const JournalEntryEditor()),
                      );
                    },
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.primary, AppColors.accent],
                        ),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.add_rounded, color: Colors.white, size: 26),
                    ),
                  ),
                ],
              ),
            ),

            // Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: GlassContainer(
                padding: const EdgeInsets.all(4),
                borderRadius: 16,
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Colors.white,
                  unselectedLabelColor: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                  labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  dividerColor: Colors.transparent,
                  tabs: const [
                    Tab(text: 'Entries'),
                    Tab(text: 'Insights'),
                  ],
                ),
              ),
            ),

            // Tab content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Entries tab
                  Consumer(
                    builder: (context, ref, child) {
                      final entries = ref.watch(journalProvider);
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
                        itemCount: entries.length,
                        itemBuilder: (context, index) {
                          final e = entries[index];
                          return JournalCard(
                            title: e.title,
                            preview: e.preview,
                            emoji: e.emoji,
                            date: e.date,
                            moodColor: AppColors.moodColor(e.score),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const JournalEntryEditor(),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                  ),

                  // Insights tab
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
                    child: Column(
                      children: [
                        const MoodChart(),
                        const SizedBox(height: 16),

                        // Stats row
                        Row(
                          children: [
                            _statBox(context, '23', 'Entries', '📝', isDark),
                            const SizedBox(width: 12),
                            _statBox(context, '7.2', 'Avg Mood', '📊', isDark),
                            const SizedBox(width: 12),
                            _statBox(context, '12', 'Streak', '🔥', isDark),
                          ],
                        ),

                        const SizedBox(height: 20),

                        Text(
                          'AI Insights',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 12),

                        const InsightCard(
                          emoji: '🏃',
                          title: 'Exercise Impact',
                          body: 'You feel 40% better on days you exercise. Try scheduling morning walks.',
                          accentColor: AppColors.accent,
                        ),
                        const InsightCard(
                          emoji: '😴',
                          title: 'Sleep Pattern',
                          body: 'Mood drops by 2 points after less than 6 hours of sleep. Consistency matters.',
                          accentColor: AppColors.secondary,
                        ),
                        const InsightCard(
                          emoji: '👥',
                          title: 'Social Connection',
                          body: 'Mood peaks on days with social interaction. Consider reaching out more often.',
                          accentColor: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statBox(BuildContext context, String value, String label, String emoji, bool isDark) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? Colors.white.withOpacity(0.06) : Colors.white.withOpacity(0.5),
          ),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 6),
            Text(value, style: Theme.of(context).textTheme.headlineSmall),
            Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 11)),
          ],
        ),
      ),
    );
  }
}



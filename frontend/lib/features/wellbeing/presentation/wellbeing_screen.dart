import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/mock_providers.dart';
import '../../../app_shell.dart';
import '../../../shared/widgets/bottom_assist_buttons.dart';
import '../../../core/theme/app_colors.dart';

class WellbeingScreen extends ConsumerWidget {
  const WellbeingScreen({super.key});

  void _safePop(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AppShell()));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metrics = ref.watch(wellbeingProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: AppColors.primary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: 28),
            onPressed: () => _safePop(context),
          ),
          centerTitle: true,
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Track Your Wellbeing', style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w900)),
              const Text('Take charge of your Wellbeing-every step forward counts', style: TextStyle(color: Colors.black87, fontSize: 13, fontWeight: FontWeight.normal)),
            ],
          ),
          elevation: 0,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.network("https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?q=80&w=200", height: 110), // mock illustration
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLinearProgress('Mood Tracker', metrics.moodTracker),
                          const SizedBox(height: 10),
                          _buildLinearProgress('Quality Sleep', metrics.qualitySleep),
                          const SizedBox(height: 10),
                          _buildLinearProgress('Task completion', metrics.taskCompletion),
                          const SizedBox(height: 10),
                          _buildLinearProgress('Stress Levels', metrics.stressLevels),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 110,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFC107),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Daily Steps', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                            const SizedBox(height: 6),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(text: '${metrics.dailySteps}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF00C853))),
                                  TextSpan(text: '/\n${metrics.dailyStepsGoal}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        height: 110,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue[200],
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.3, 0.3],
                            colors: [Colors.grey[200]!, Colors.lightBlue[300]!],
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Water Intake', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                            const SizedBox(height: 10),
                            Text('${metrics.waterIntake}/${metrics.waterGoal}L', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text('Practice', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                const SizedBox(height: 12),
                SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildPracticeCard('Meditation', 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=120'),
                      _buildPracticeCard('Yoga', 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=120'),
                      _buildPracticeCard('Breathing Exercise', 'https://images.unsplash.com/photo-1499209974431-9dddcece7f88?w=120'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: const Text('Book your Therapy Session', style: TextStyle(fontSize: 14, decoration: TextDecoration.underline, color: Colors.black87)),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
          const BottomAssistButtons(),
        ],
      ),
    );
  }

  Widget _buildLinearProgress(String title, double value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black)),
        const SizedBox(height: 4),
        Container(
          height: 10,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black87, width: 1.5),
            borderRadius: BorderRadius.circular(5),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: value,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF00C853),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPracticeCard(String title, String imageUrl) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFFFC107),
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(imageUrl, fit: BoxFit.cover, width: double.infinity),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(title, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black)),
          ),
        ],
      ),
    );
  }
}

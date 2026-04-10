import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/mock_providers.dart';
import '../../../shared/widgets/bottom_assist_buttons.dart';
import '../../../core/theme/app_colors.dart';

class TherapyScreen extends ConsumerWidget {
  const TherapyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final team = ref.watch(therapyTeamProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: AppColors.primary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: 28),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Book a Therapy', style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w900)),
              const Text('Your journey to healing starts with one conversation', style: TextStyle(color: Colors.black87, fontSize: 13, fontWeight: FontWeight.normal)),
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
                const Text('Therapy', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: _buildTherapyCard('Individual Therapy', 'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?w=150')),
                    const SizedBox(width: 8),
                    Expanded(child: _buildTherapyCard('Family Therapy', 'https://images.unsplash.com/photo-1543269865-cbf427effbad?w=150')),
                    const SizedBox(width: 8),
                    Expanded(child: _buildTherapyCard('Group Therapy', 'https://images.unsplash.com/photo-1529156069898-49953e39b3ac?w=150')),
                  ],
                ),
                const SizedBox(height: 20),
                const Text('Plans', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _buildPlanCard('Individual')),
                    const SizedBox(width: 10),
                    Expanded(child: _buildPlanCard('Workplace')),
                    const SizedBox(width: 10),
                    Expanded(child: _buildPlanCard('Schools/\nUniversities')),
                  ],
                ),
                const SizedBox(height: 20),
                const Text('Meet the Team', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black)),
                const SizedBox(height: 12),
                SizedBox(
                  height: 90,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: team.length,
                    itemBuilder: (context, index) {
                      final t = team[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(t.imageUrl),
                            ),
                            const SizedBox(height: 8),
                            Text(t.name, style: const TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle)),
                      const SizedBox(width: 5),
                      Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFC107),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColors.primary, width: 2),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Book your Therapy Session', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
                            const SizedBox(height: 5),
                            const Text('Healing takes time, and asking for help is a courageous step', style: TextStyle(fontSize: 11, color: Colors.black87)),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              ),
                              child: const Text('Book now', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: NetworkImage("https://images.unsplash.com/photo-1544717305-2782549b5136?q=80&w=150"),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
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

  Widget _buildTherapyCard(String title, String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFC107),
        border: Border.all(color: AppColors.primary, width: 2),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.network(imageUrl, height: 60, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            child: Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black)),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard(String title) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFFFC107),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black)),
      ),
    );
  }
}

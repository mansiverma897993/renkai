import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../wellbeing/presentation/wellbeing_screen.dart';
import '../therapy/presentation/therapy_screen.dart';
import '../community/presentation/community_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: Container(
          color: const Color(0xFFFFC107),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: const NetworkImage("https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=150"),
                    backgroundColor: Colors.grey[200],
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Sage', style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.black, fontSize: 26, fontWeight: FontWeight.w900)),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text('Premium', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              children: [
                _buildMenuItemRow(Icons.assignment, 'My Program'),
                _buildMenuItemRow(Icons.build_circle, 'Self-help tools'),
                _buildMenuItemRow(Icons.psychology, 'Wellbeing', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WellbeingScreen()))),
                _buildMenuItemRow(Icons.medical_services, 'Therapy', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TherapyScreen()))),
                _buildMenuItemRow(Icons.local_fire_department, 'Mind Streak', iconColor: Colors.orange),
                _buildMenuItemRow(Icons.people, 'Community', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CommunityScreen()))),
                _buildMenuItemRow(Icons.star, 'Premium', iconColor: const Color(0xFFFFC107)),
                _buildMenuItemRow(Icons.shopping_bag, 'Merch'),
                _buildMenuItemRow(Icons.receipt_long, 'Your Orders'),
                _buildMenuItemRow(Icons.feedback, 'Feedback'),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Colors.grey),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.settings, color: Colors.black54, size: 28),
                const SizedBox(width: 10),
                const Text('Settings', style: TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          const SizedBox(height: 80), // To account for bottom AppShell navigation bar
        ],
      ),
    );
  }

  Widget _buildMenuItemRow(IconData icon, String title, {VoidCallback? onTap, Color iconColor = Colors.black54}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: InkWell(
        onTap: onTap ?? () {},
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 28),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black87),
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, color: Colors.black26, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}

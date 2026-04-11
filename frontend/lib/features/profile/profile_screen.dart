import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../wellbeing/presentation/wellbeing_screen.dart';
import '../therapy/presentation/therapy_screen.dart';
import '../community/presentation/community_screen.dart';
import '../data/mock_providers.dart';

class PlaceholderScreen extends StatelessWidget {
  final String title;
  final IconData icon;
  
  const PlaceholderScreen({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: AppColors.primary,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.2), shape: BoxShape.circle),
              child: Icon(icon, size: 80, color: AppColors.primary),
            ),
            const SizedBox(height: 30),
            Text('$title Screen', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.black)),
            const SizedBox(height: 10),
            Text('This section is currently under construction.\nCheck back soon!', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

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
                    backgroundImage: NetworkImage(user.avatarUrl),
                    backgroundColor: Colors.grey[200],
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(user.name, style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.black, fontSize: 28, fontWeight: FontWeight.w900)),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: user.planType == 'Premium' ? Colors.black : AppColors.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(user.planType, style: TextStyle(color: user.planType == 'Premium' ? const Color(0xFFFFCA28) : Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
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
                _buildMenuItemRow(context, Icons.assignment, 'My Program', const PlaceholderScreen(title: 'My Program', icon: Icons.assignment)),
                _buildMenuItemRow(context, Icons.build_circle, 'Self-help tools', const PlaceholderScreen(title: 'Self-help tools', icon: Icons.build_circle)),
                _buildMenuItemRow(context, Icons.psychology, 'Wellbeing', const WellbeingScreen()),
                _buildMenuItemRow(context, Icons.medical_services, 'Therapy', const TherapyScreen()),
                _buildMenuItemRow(context, Icons.local_fire_department, 'Mind Streak', const PlaceholderScreen(title: 'Mind Streak', icon: Icons.local_fire_department), iconColor: Colors.orange),
                _buildMenuItemRow(context, Icons.people, 'Community', const CommunityScreen()),
                _buildMenuItemRow(context, Icons.star, 'Premium Benefits', const PlaceholderScreen(title: 'Premium Benefits', icon: Icons.star), iconColor: const Color(0xFFFFC107)),
                _buildMenuItemRow(context, Icons.shopping_bag, 'Merch Store', const PlaceholderScreen(title: 'Merch Store', icon: Icons.shopping_bag)),
                _buildMenuItemRow(context, Icons.receipt_long, 'Your Orders', const PlaceholderScreen(title: 'Your Orders', icon: Icons.receipt_long)),
                _buildMenuItemRow(context, Icons.feedback, 'Feedback', const PlaceholderScreen(title: 'Feedback', icon: Icons.feedback)),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Colors.black12),
          InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderScreen(title: 'Settings', icon: Icons.settings))),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.settings, color: Colors.black54, size: 28),
                  const SizedBox(width: 10),
                  const Text('Settings', style: TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 80), // To account for bottom AppShell navigation bar
        ],
      ),
    );
  }

  Widget _buildMenuItemRow(BuildContext context, IconData icon, String title, Widget destination, {Color iconColor = Colors.black54}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => destination)),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
                child: Icon(icon, color: iconColor, size: 28),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.black87),
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

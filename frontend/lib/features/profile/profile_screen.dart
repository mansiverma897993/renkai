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
      body: Row(
        children: [
          // Orange Left Strip
          Container(
            width: 80,
            color: AppColors.primary,
            child: SafeArea(
              child: Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),
          // Main Body
          Expanded(
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  // Header Block
                  Container(
                    width: double.infinity,
                    color: const Color(0xFFFFC107),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 45,
                          backgroundImage: const NetworkImage("https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=150"),
                          backgroundColor: Colors.grey[200],
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Sage', style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.black, fontSize: 32, fontWeight: FontWeight.w900)),
                            const Text('Premium', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Menu Items
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.only(top: 20, left: 30),
                      children: [
                        _buildMenuItem('My Program'),
                        _buildMenuItem('Self-help tools'),
                        _buildMenuItem('Wellbeing', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WellbeingScreen()))),
                        _buildMenuItem('Therapy', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TherapyScreen()))),
                        _buildMenuItem('Mind Streak'),
                        _buildMenuItem('Community', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CommunityScreen()))),
                        _buildMenuItem('Premium'),
                        _buildMenuItem('Merch'),
                        _buildMenuItem('Your Orders'),
                        _buildMenuItem('Feedback'),
                      ],
                    ),
                  ),
                  const Divider(height: 1, thickness: 1, color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.settings, color: Colors.black, size: 28),
                        SizedBox(width: 10),
                        Text('Settings', style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title, {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: InkWell(
        onTap: onTap ?? () {},
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }
}

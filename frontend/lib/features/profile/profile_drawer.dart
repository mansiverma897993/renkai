import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/placeholder_screen.dart';
import '../wellbeing/presentation/wellbeing_screen.dart';
import '../therapy/presentation/therapy_screen.dart';
import '../community/presentation/community_screen.dart';
import '../mindfulness/presentation/mindfulness_hub_screen.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({super.key});

  void _pushPlaceholder(BuildContext context, String title) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => PlaceholderScreen(title: title)));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20, bottom: 20, left: 20, right: 20),
            color: const Color(0xFFFFC107),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: const NetworkImage("https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=150"),
                  backgroundColor: Colors.grey[200],
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Sage', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black, fontWeight: FontWeight.w900)),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(20)),
                        child: const Text('Premium', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              children: [
                _buildMenuItemRow(Icons.assignment, 'My Program', onTap: () => _pushPlaceholder(context, 'My Program')),
                _buildMenuItemRow(Icons.build_circle, 'Self-help tools', onTap: () => _pushPlaceholder(context, 'Self-help tools')),
                _buildMenuItemRow(Icons.psychology, 'Mindfulness Hub', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MindfulnessHubScreen()))),
                _buildMenuItemRow(Icons.medical_services, 'Therapy', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TherapyScreen()))),
                _buildMenuItemRow(Icons.local_fire_department, 'Mind Streak', iconColor: Colors.orange, onTap: () => _pushPlaceholder(context, 'Mind Streak')),
                _buildMenuItemRow(Icons.people, 'Community', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CommunityScreen()))),
                _buildMenuItemRow(Icons.star, 'Premium', iconColor: const Color(0xFFFFC107), onTap: () => _pushPlaceholder(context, 'Premium')),
                _buildMenuItemRow(Icons.shopping_bag, 'Merch', onTap: () => _pushPlaceholder(context, 'Merch')),
                _buildMenuItemRow(Icons.receipt_long, 'Your Orders', onTap: () => _pushPlaceholder(context, 'Your Orders')),
                _buildMenuItemRow(Icons.feedback, 'Feedback', onTap: () => _pushPlaceholder(context, 'Feedback')),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Colors.grey),
          InkWell(
            onTap: () => _pushPlaceholder(context, 'Settings'),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.settings, color: Colors.black54, size: 24),
                  const SizedBox(width: 10),
                  const Text('Settings', style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 10),
        ],
      ),
    );
  }

  Widget _buildMenuItemRow(IconData icon, String title, {VoidCallback? onTap, Color iconColor = Colors.black54}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: InkWell(
        onTap: onTap ?? () {},
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 24),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87),
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, color: Colors.black26, size: 14),
            ],
          ),
        ),
      ),
    );
  }
}

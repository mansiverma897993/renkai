import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/gradient_background.dart';
import 'widgets/profile_header.dart';
import 'widgets/wellness_toolkit_card.dart';
import 'widgets/safe_circle_card.dart';
import 'breathing_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GradientBackground(
      colors: isDark ? AppColors.profileGradientDark : AppColors.profileGradient,
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Profile', style: Theme.of(context).textTheme.displayMedium),
              const SizedBox(height: 24),
              const ProfileHeader(),
              const SizedBox(height: 32),
              
              Text('Wellness Toolkit', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 16),
              WellnessToolkitCard(
                title: 'Breathing',
                emoji: '🌬️',
                subtitle: '4-7-8 Focus technique',
                color: AppColors.primary,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BreathingScreen()),
                  );
                },
              ),
              const SizedBox(height: 12),
              const WellnessToolkitCard(
                title: 'Meditation',
                emoji: '🧘',
                subtitle: 'Daily calm sessions',
                color: AppColors.accent,
              ),
              const SizedBox(height: 12),
              const WellnessToolkitCard(
                title: 'Focus Sounds',
                emoji: '🎧',
                subtitle: 'White noise & nature',
                color: AppColors.secondary,
              ),
              
              const SizedBox(height: 32),
              const SafeCircleCard(),
              
              const SizedBox(height: 32),
              Text('Settings', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 16),
              _buildSettingsOption(context, 'Notifications', Icons.notifications_none_rounded),
              _buildSettingsOption(context, 'Privacy & Security', Icons.lock_outline_rounded),
              _buildSettingsOption(context, 'Help & Support', Icons.help_outline_rounded),
              _buildSettingsOption(context, 'Logout', Icons.logout_rounded, isLogout: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsOption(BuildContext context, String title, IconData icon, {bool isLogout = false}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.06) : Colors.white.withOpacity(0.4),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, size: 22, color: isLogout ? AppColors.danger : AppColors.primary),
          const SizedBox(width: 14),
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: isLogout ? AppColors.danger : null,
            ),
          ),
          const Spacer(),
          Icon(Icons.chevron_right_rounded, size: 20, color: Colors.grey.withOpacity(0.5)),
        ],
      ),
    );
  }
}

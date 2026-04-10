import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class SafeCircleCard extends StatelessWidget {
  const SafeCircleCard({super.key});

  final _contacts = const [
    _Contact('Mom', '📱', '+91 98765-XXXXX'),
    _Contact('Therapist', '🩺', '+91 91234-XXXXX'),
    _Contact('Best Friend', '💜', '+91 87654-XXXXX'),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.06) : Colors.white.withOpacity(0.4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Safe Circle', style: Theme.of(context).textTheme.headlineSmall),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.danger.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.shield_rounded, size: 14, color: AppColors.danger),
                    const SizedBox(width: 4),
                    Text(
                      'Protected',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.danger),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ..._contacts.map((c) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Text(c.emoji, style: const TextStyle(fontSize: 20)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(c.name, style: Theme.of(context).textTheme.titleMedium),
                          Text(c.phone, style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.call_rounded, color: AppColors.accent, size: 20),
                      visualDensity: VisualDensity.compact,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.message_rounded, color: AppColors.primary, size: 20),
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 4),
          Center(
            child: TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.add_rounded, size: 18, color: AppColors.primary),
              label: Text('Add Contact', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}

class _Contact {
  final String name, emoji, phone;
  const _Contact(this.name, this.emoji, this.phone);
}

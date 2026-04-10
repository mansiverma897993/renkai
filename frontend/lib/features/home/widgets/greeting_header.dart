import 'package:flutter/material.dart';
import '../../../core/utils/greeting_helper.dart';

class GreetingHeader extends StatelessWidget {
  const GreetingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${GreetingHelper.getGreeting()} ${GreetingHelper.getGreetingEmoji()}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                'Garv',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ],
          ),
        ),
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0.3),
                Theme.of(context).colorScheme.secondary.withOpacity(0.3),
              ],
            ),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Text('G', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}

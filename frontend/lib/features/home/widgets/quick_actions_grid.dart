import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/glass_container.dart';

class QuickActionsGrid extends StatelessWidget {
  final void Function(int index) onActionTap;

  const QuickActionsGrid({super.key, required this.onActionTap});

  static const _actions = [
    _ActionItem('AI Chat', '🤖', AppColors.primary, 1),
    _ActionItem('Journal', '✍️', AppColors.accent, 2),
    _ActionItem('Breathe', '🌬️', AppColors.secondary, -1),
    _ActionItem('SOS', '🚨', AppColors.danger, -1),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 1.5,
      ),
      itemCount: _actions.length,
      itemBuilder: (context, index) {
        return _QuickActionCard(
          action: _actions[index],
          onTap: () {
            HapticFeedback.lightImpact();
            onActionTap(_actions[index].navIndex);
          },
        );
      },
    );
  }
}

class _QuickActionCard extends StatefulWidget {
  final _ActionItem action;
  final VoidCallback onTap;

  const _QuickActionCard({required this.action, required this.onTap});

  @override
  State<_QuickActionCard> createState() => _QuickActionCardState();
}

class _QuickActionCardState extends State<_QuickActionCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isSos = widget.action.label == 'SOS';

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: GlassContainer(
          color: isSos
              ? AppColors.danger.withOpacity(0.12)
              : widget.action.color.withOpacity(0.08),
          borderColor: isSos
              ? AppColors.danger.withOpacity(0.25)
              : null,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.action.emoji, style: const TextStyle(fontSize: 30)),
              const SizedBox(height: 8),
              Text(
                widget.action.label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isSos ? AppColors.danger : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionItem {
  final String label;
  final String emoji;
  final Color color;
  final int navIndex;
  const _ActionItem(this.label, this.emoji, this.color, this.navIndex);
}

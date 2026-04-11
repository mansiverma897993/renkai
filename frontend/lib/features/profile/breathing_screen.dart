import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';
import '../../app_shell.dart';

class BreathingScreen extends StatefulWidget {
  const BreathingScreen({super.key});

  @override
  State<BreathingScreen> createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<BreathingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  void _safePop(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AppShell()));
    }
  }
  late Animation<double> _animation;
  String _status = 'Get Ready';
  int _secondsRemaining = 4;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(seconds: 4));
    _animation = Tween<double>(begin: 1.0, end: 1.8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _startBreathingCycle();
  }

  void _startBreathingCycle() async {
    while (mounted) {
      if (!mounted) return;
      // Inhale
      setState(() {
        _status = 'Inhale';
        _secondsRemaining = 4;
      });
      HapticFeedback.lightImpact();
      _controller.forward();
      await _countdown(4);

      // Hold
      if (!mounted) return;
      setState(() {
        _status = 'Hold';
        _secondsRemaining = 7;
      });
      await _countdown(7);

      // Exhale
      if (!mounted) return;
      setState(() {
        _status = 'Exhale';
        _secondsRemaining = 8;
      });
      HapticFeedback.lightImpact();
      _controller.reverse();
      await _countdown(8);
    }
  }

  Future<void> _countdown(int seconds) async {
    for (int i = seconds; i > 0; i--) {
      if (!mounted) return;
      setState(() {
        _secondsRemaining = i;
      });
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark, // Typically dark for focus
      body: Stack(
        children: [
          // Close button
          Positioned(
            top: 60,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white70, size: 30),
              onPressed: () => _safePop(context),
            ),
          ),
          
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Container(
                      width: 150 * _animation.value,
                      height: 150 * _animation.value,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            AppColors.primary.withOpacity(0.4),
                            AppColors.accent.withOpacity(0.1),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.2),
                            blurRadius: 40 * _animation.value,
                            spreadRadius: 10,
                          ),
                        ],
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 100),
                Text(
                  _status,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '$_secondsRemaining',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w300,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          
          const Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Focus on your breath',
                style: TextStyle(color: Colors.white54, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

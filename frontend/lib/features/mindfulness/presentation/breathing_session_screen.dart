import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class BreathingSessionScreen extends StatefulWidget {
  final String title;
  final List<int> pattern; // [inhale, hold, exhale, hold] in seconds

  const BreathingSessionScreen({
    super.key,
    required this.title,
    required this.pattern,
  });

  @override
  State<BreathingSessionScreen> createState() => _BreathingSessionScreenState();
}

class _BreathingSessionScreenState extends State<BreathingSessionScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  
  String _currentInstruction = 'Get Ready';
  int _timeLeft = 3;
  Timer? _timer;
  int _phaseIndex = -1; // -1 means preparation
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    
    _startPreparation();
  }

  void _startPreparation() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_timeLeft > 1) {
        setState(() => _timeLeft--);
      } else {
        _timer?.cancel();
        setState(() {
          _isActive = true;
          _phaseIndex = 0;
        });
        _runPhase();
      }
    });
  }

  void _runPhase() {
    if (!mounted || !_isActive) return;

    int duration = widget.pattern[_phaseIndex];
    
    if (duration == 0) {
      _nextPhase();
      return;
    }

    setState(() {
      _timeLeft = duration;
      if (_phaseIndex == 0) {
        _currentInstruction = 'Inhale...';
        _controller.duration = Duration(seconds: duration);
        _controller.forward();
      } else if (_phaseIndex == 1) {
        _currentInstruction = 'Hold...';
      } else if (_phaseIndex == 2) {
        _currentInstruction = 'Exhale...';
        _controller.duration = Duration(seconds: duration);
        _controller.reverse();
      } else if (_phaseIndex == 3) {
        _currentInstruction = 'Hold...';
      }
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_timeLeft > 1) {
        setState(() => _timeLeft--);
      } else {
        _timer?.cancel();
        _nextPhase();
      }
    });
  }

  void _nextPhase() {
    _phaseIndex = (_phaseIndex + 1) % 4;
    _runPhase();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(widget.title, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isActive ? _currentInstruction : 'Get Ready',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.black87),
            ),
            const SizedBox(height: 10),
            Text(
              '$_timeLeft',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey[600]),
            ),
            const SizedBox(height: 80),
            SizedBox(
              height: 300,
              width: 300,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outer rings
                  Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary.withOpacity(0.1),
                    ),
                  ),
                  Container(
                    width: 240,
                    height: 240,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary.withOpacity(0.2),
                    ),
                  ),
                  // Animated inner orb
                  AnimatedBuilder(
                    animation: _scaleAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Container(
                          width: 180,
                          height: 180,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [Color(0xFFFFC107), AppColors.primary],
                            ),
                            boxShadow: [
                              BoxShadow(color: Colors.orangeAccent, blurRadius: 30, spreadRadius: 5)
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
            if (_isActive)
              ElevatedButton(
                onPressed: () {
                  setState(() => _isActive = false);
                  _timer?.cancel();
                  Navigator.pop(context); // Could redirect to a mood logging screen here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text('End Session', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              )
          ],
        ),
      ),
    );
  }
}

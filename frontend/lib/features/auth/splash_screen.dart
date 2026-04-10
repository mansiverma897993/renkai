import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const OnboardingScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7941D), // Adjusted to match the exact vibrant orange in screenshot
      body: Center(
        child: SizedBox(
          width: 320,
          height: 400,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              // Main large white circle background
              Positioned(
                top: 50,
                child: Container(
                  width: 260,
                  height: 260,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE8E9EB), // slightly grey-white as in image
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              
              // Top right small white circle
              Positioned(
                top: 30,
                right: 30,
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE8E9EB),
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              // Bottom left small orange circle inside the grey/white circle
              Positioned(
                bottom: 110,
                left: 50,
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF7941D),
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              // Lotus Icon / Drawing
              Positioned(
                top: 60,
                child: Column(
                  children: [
                    // Main Lotus placeholder (using icon for now)
                    Icon(
                      Icons.filter_vintage_rounded, // Alternative lotus-like icon
                      size: 160,
                      color: const Color(0xFFC05A18), // Brown/Dark Orange outline color 
                    ),
                    const SizedBox(height: 10),
                    // Lower scroll/mandala placeholder
                    Icon(
                      Icons.all_inclusive_rounded,
                      size: 60,
                      color: const Color(0xFFC05A18),
                    )
                  ],
                ),
              ),
              
              // RENKAI Text overlapping the circle at the bottom
              Positioned(
                bottom: 40,
                child: Text(
                  'RENKAI',
                  style: TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.w900, // Very heavy weight
                    fontFamily: 'Arial Black', // Using strong fallback slab/sans
                    letterSpacing: 2.5,
                    color: const Color(0xFF1B1B2F), // Very dark navy/black
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 4),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'signup_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Top Curved Orange Banner with Logo
          Container(
            width: double.infinity,
            height: 250,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const Icon(
                          Icons.spa_rounded,
                          size: 60,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'RENKAI',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          const Spacer(),

          // Illustration Placeholder
          Container(
            height: 250,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Icon(
              Icons.psychology_alt_rounded,
              size: 200,
              color: Colors.green, // matching some green from the screenshot illustration
            ),
          ),

          const Spacer(),

          // Texts
          const Text(
            'Embark On Your Journey Towards',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'MENTAL WELLNESS',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
              letterSpacing: 1.0,
            ),
          ),

          const SizedBox(height: 40),

          // Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SignupScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Create An Account'),
            ),
          ),
          const SizedBox(height: 20),
          
          Text(
            'Already a member?',
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
          const SizedBox(height: 5),
          GestureDetector(
            onTap: () {
              // for now navigate to signup as login
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SignupScreen()),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black87),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Text(
                'Log in',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

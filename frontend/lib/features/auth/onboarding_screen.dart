import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'signup_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // ─── TOP ORANGE HEADER ───────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 30),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  // Logo circle
                  Container(
                    width: 90,
                    height: 90,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: _RenkaiLogoIcon(size: 55),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // RENKAI text
                  const Text(
                    'RENKAI',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2.0,
                      color: Color(0xFF1B1B2F),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ─── BODY ───────────────────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.03),

                  // Illustration
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Image.asset(
                      'assets/images/onboarding_illustration.png',
                      height: screenHeight * 0.32,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => Container(
                        height: screenHeight * 0.32,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.psychology_alt_rounded,
                          size: 160,
                          color: Color(0xFF4CAF50),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  // Body text
                  const Text(
                    'Embark On Your Journey Towards',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'MENTAL WELLNESS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.0,
                      color: AppColors.primary,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.05),

                  // CREATE AN ACCOUNT Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const SignupScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Create An Account',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Already a member text
                  const Text(
                    'Already a member?',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Log in button (outlined)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const SignupScreen()),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black,
                          side: const BorderSide(color: Colors.black87, width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Log in',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom Lotus/Renkai Logo SVG drawn with CustomPainter
class _RenkaiLogoIcon extends StatelessWidget {
  final double size;
  const _RenkaiLogoIcon({this.size = 50});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _LotusPainter(),
      ),
    );
  }
}

class _LotusPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFF7941D)
      ..style = PaintingStyle.fill;

    final cx = size.width / 2;
    final cy = size.height / 2;

    // Draw petals - simplified lotus
    for (int i = 0; i < 8; i++) {
      final angle = (i * 45) * 3.14159 / 180;
      final petalPath = Path();
      final petalX = cx + (size.width * 0.28) * _cos(angle);
      final petalY = cy + (size.height * 0.28) * _sin(angle);
      petalPath.moveTo(cx, cy);
      petalPath.quadraticBezierTo(
        cx + (size.width * 0.4) * _cos(angle - 0.4),
        cy + (size.height * 0.4) * _sin(angle - 0.4),
        petalX,
        petalY,
      );
      petalPath.quadraticBezierTo(
        cx + (size.width * 0.4) * _cos(angle + 0.4),
        cy + (size.height * 0.4) * _sin(angle + 0.4),
        cx,
        cy,
      );
      canvas.drawPath(petalPath, paint);
    }

    // Center circle
    canvas.drawCircle(Offset(cx, cy), size.width * 0.18, paint);

    // Stem / unalome squiggle lines
    final stemPaint = Paint()
      ..color = const Color(0xFFF7941D)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.06
      ..strokeCap = StrokeCap.round;

    final stemPath = Path();
    stemPath.moveTo(cx, cy + size.height * 0.3);
    stemPath.cubicTo(
      cx - size.width * 0.2, cy + size.height * 0.4,
      cx + size.width * 0.2, cy + size.height * 0.5,
      cx, cy + size.height * 0.6,
    );
    canvas.drawPath(stemPath, stemPaint);
  }

  double _cos(double rad) => (rad == 0) ? 1.0 : (rad == 3.14159 / 2) ? 0.0 : (rad == 3.14159) ? -1.0 : _computeCos(rad);
  double _sin(double rad) => (rad == 0) ? 0.0 : (rad == 3.14159 / 2) ? 1.0 : _computeSin(rad);

  double _computeCos(double rad) {
    double result = 1;
    double term = 1;
    for (int i = 1; i <= 10; i++) {
      term *= -rad * rad / ((2 * i - 1) * (2 * i));
      result += term;
    }
    return result;
  }

  double _computeSin(double rad) {
    double result = rad;
    double term = rad;
    for (int i = 1; i <= 10; i++) {
      term *= -rad * rad / ((2 * i) * (2 * i + 1));
      result += term;
    }
    return result;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

import 'package:flutter/material.dart';

/// Custom Lotus/Renkai Logo SVG drawn with CustomPainter
class RenkaiLogoIcon extends StatelessWidget {
  final double size;
  final Color color;

  const RenkaiLogoIcon({
    super.key, 
    this.size = 50, 
    this.color = const Color(0xFFF7941D),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _LotusPainter(color: color),
      ),
    );
  }
}

class _LotusPainter extends CustomPainter {
  final Color color;

  _LotusPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
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
      ..color = color
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
  bool shouldRepaint(covariant _LotusPainter oldDelegate) => oldDelegate.color != color;
}

import 'package:flutter/material.dart';

class AppColors {
  // ── Primary Palette ──
  static const primary = Color(0xFF8B9FFF);
  static const primaryLight = Color(0xFFA0B0FF);
  static const primaryDark = Color(0xFF6B7FDF);

  // ── Secondary (Peach/Coral) ──
  static const secondary = Color(0xFFFFB088);
  static const secondaryLight = Color(0xFFFFBB99);

  // ── Accent (Soft Teal) ──
  static const accent = Color(0xFF7DD3C2);
  static const accentLight = Color(0xFF8DE0D0);

  // ── Danger (SOS) ──
  static const danger = Color(0xFFFF6B6B);
  static const dangerLight = Color(0xFFFF7B7B);

  // ── Backgrounds ──
  static const bgLight = Color(0xFFF7F8FC);
  static const bgDark = Color(0xFF0F0F1A);

  // ── Surfaces / Cards ──
  static const surfaceLight = Color(0xB3FFFFFF); // white @ 70%
  static const surfaceDark = Color(0xCC1A1A2E);  // #1A1A2E @ 80%

  // ── Glass effects ──
  static const glassBorderLight = Color(0x4DFFFFFF); // white 30%
  static const glassBorderDark = Color(0x33FFFFFF);   // white 20%
  static const glassFillLight = Color(0x3DFFFFFF);    // white 24%
  static const glassFillDark = Color(0x1AFFFFFF);     // white 10%

  // ── Text ──
  static const textPrimaryLight = Color(0xFF1A1A2E);
  static const textSecondaryLight = Color(0xFF6B7280);
  static const textPrimaryDark = Color(0xFFF0F0F5);
  static const textSecondaryDark = Color(0xFF9CA3AF);

  // ── Mood Colors ──
  static const moodTerrible = Color(0xFF7C8CF5);
  static const moodBad = Color(0xFF9B8FE8);
  static const moodOkay = Color(0xFFFFCB6B);
  static const moodGood = Color(0xFF7DD3C2);
  static const moodGreat = Color(0xFF6BCB77);

  // ── Screen Gradients ──
  static const homeGradient = [Color(0xFFE8D5FF), Color(0xFFD5E8FF)];
  static const chatGradient = [Color(0xFFFFE8D5), Color(0xFFFFD5E8)];
  static const journalGradient = [Color(0xFFD5FFE8), Color(0xFFD5F0FF)];
  static const profileGradient = [Color(0xFFFFD5E8), Color(0xFFE8D5FF)];

  static const homeGradientDark = [Color(0xFF1A0F2E), Color(0xFF0F1A2E)];
  static const chatGradientDark = [Color(0xFF2E1A0F), Color(0xFF2E0F1A)];
  static const journalGradientDark = [Color(0xFF0F2E1A), Color(0xFF0F1E2E)];
  static const profileGradientDark = [Color(0xFF2E0F1A), Color(0xFF1A0F2E)];

  static Color moodColor(double score) {
    if (score <= 2) return moodTerrible;
    if (score <= 4) return moodBad;
    if (score <= 6) return moodOkay;
    if (score <= 8) return moodGood;
    return moodGreat;
  }
}

import 'package:flutter/material.dart';

class AppColors {
  // ── Primary Palette ──
  static const primary = Color(0xFFFF9800); // UI Vibrant Orange
  static const primaryLight = Color(0xFFFFB74D);
  static const primaryDark = Color(0xFFF57C00);

  // ── Secondary ──
  static const secondary = Color(0xFF2C3140); // Dark text color on logo / accents
  static const secondaryLight = Color(0xFF4C5160);

  // ── Accent (Green for charts) ──
  static const accent = Color(0xFF00C853);
  static const accentLight = Color(0xFF5EFB83);

  // ── Danger ──
  static const danger = Color(0xFFFF6B6B);
  static const dangerLight = Color(0xFFFF7B7B);

  // ── Backgrounds ──
  static const bgLight = Color(0xFFFFFFFF); // White background
  static const bgDark = Color(0xFF121212);

  // ── Surfaces / Cards ──
  static const surfaceLight = Color(0xFFFFFFFF);
  static const surfaceDark = Color(0xFF1E1E1E);

  // ── Glass effects ──
  static const glassBorderLight = Color(0x4DFFFFFF);
  static const glassBorderDark = Color(0x33FFFFFF);
  static const glassFillLight = Color(0x3DFFFFFF);
  static const glassFillDark = Color(0x1AFFFFFF);

  // ── Text ──
  static const textPrimaryLight = Color(0xFF000000); // Black text typical for Figma
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
  static const homeGradient = [Color(0xFFFFFFFF), Color(0xFFFFFFFF)];
  static const chatGradient = [Color(0xFFFFFFFF), Color(0xFFFFFFFF)];
  static const journalGradient = [Color(0xFFFFFFFF), Color(0xFFFFFFFF)];
  static const profileGradient = [Color(0xFFFFFFFF), Color(0xFFFFFFFF)];

  static const homeGradientDark = [Color(0xFF121212), Color(0xFF121212)];
  static const chatGradientDark = [Color(0xFF121212), Color(0xFF121212)];
  static const journalGradientDark = [Color(0xFF121212), Color(0xFF121212)];
  static const profileGradientDark = [Color(0xFF121212), Color(0xFF121212)];

  static Color moodColor(double score) {
    if (score <= 2) return moodTerrible;
    if (score <= 4) return moodBad;
    if (score <= 6) return moodOkay;
    if (score <= 8) return moodGood;
    return moodGreat;
  }
}

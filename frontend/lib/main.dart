import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'features/home/home_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: RenkaiApp(),
    ),
  );
}

class RenkaiApp extends StatelessWidget {
  const RenkaiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Renkai Mental Health',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8C9EFF), // Soft Lavender/Indigo
          brightness: Brightness.light,
          background: const Color(0xFFF7F8FC),
          primary: const Color(0xFF8C9EFF), // Pastel primary
        ),
        textTheme: GoogleFonts.outfitTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8C9EFF),
          brightness: Brightness.dark,
          background: const Color(0xFF121212),
        ),
        textTheme: GoogleFonts.outfitTextTheme(
          ThemeData.dark().textTheme,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

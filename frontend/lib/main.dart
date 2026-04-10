import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'app_shell.dart';

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
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system, // Respect system settings
      home: const AppShell(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app_shell.dart';
import '../data/mock_providers.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/glass_container.dart';

class JournalEntryEditor extends ConsumerStatefulWidget {
  const JournalEntryEditor({super.key});

  @override
  ConsumerState<JournalEntryEditor> createState() => _JournalEntryEditorState();
}

class _JournalEntryEditorState extends ConsumerState<JournalEntryEditor> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  int? _selectedMood;
  final _moods = ['😢', '😕', '😐', '🙂', '😁'];
  bool _isSaving = false;

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void _safePop(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AppShell()));
    }
  }

  void _save() async {
    if (_titleController.text.isEmpty || _selectedMood == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please add a title and mood.')));
      return;
    }
    
    HapticFeedback.mediumImpact();
    setState(() => _isSaving = true);
    
    // Create new entry
    final entry = JournalEntry(
      title: _titleController.text,
      preview: _bodyController.text.isEmpty ? 'No text content...' : _bodyController.text.substring(0, _bodyController.text.length > 50 ? 50 : _bodyController.text.length) + '...',
      emoji: _moods[_selectedMood!],
      date: 'Just now',
      score: (_selectedMood! + 1) * 2.0, // Scale mood to roughly match 0-10 
    );
    
    ref.read(journalProvider.notifier).addEntry(entry);
    
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) {
      _safePop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      appBar: AppBar(
        title: const Text('New Entry'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _isSaving
                  ? const SizedBox(
                      width: 28,
                      height: 28,
                      child: CircularProgressIndicator(strokeWidth: 2.5),
                    )
                  : TextButton(
                      onPressed: _save,
                      child: Text(
                        'Save',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mood selection
            Text('How are you feeling?', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_moods.length, (i) {
                final isSelected = _selectedMood == i;
                return GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    setState(() => _selectedMood = i);
                  },
                  child: AnimatedScale(
                    scale: isSelected ? 1.2 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary.withOpacity(0.15)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(_moods[i], style: const TextStyle(fontSize: 32)),
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 28),

            // Title
            TextField(
              controller: _titleController,
              style: Theme.of(context).textTheme.displaySmall,
              decoration: InputDecoration(
                hintText: 'Entry title...',
                hintStyle: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    ),
                border: InputBorder.none,
                filled: false,
              ),
            ),

            const Divider(height: 32),

            // Body
            TextField(
              controller: _bodyController,
              maxLines: null,
              minLines: 12,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.7),
              decoration: InputDecoration(
                hintText: 'Write your thoughts here...\n\nThis is a safe space. Express freely.',
                hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                      height: 1.7,
                    ),
                border: InputBorder.none,
                filled: false,
              ),
            ),

            const SizedBox(height: 24),

            // AI Summary button
            GlassContainer(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.primary, AppColors.accent],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(child: Text('✨', style: TextStyle(fontSize: 18))),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('AI Summary', style: Theme.of(context).textTheme.titleLarge),
                        Text(
                          'Tap to generate insights from your entry',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.auto_awesome_rounded, color: AppColors.primary),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

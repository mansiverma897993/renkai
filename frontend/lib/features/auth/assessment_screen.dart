import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../app_shell.dart';
import '../data/mock_providers.dart';

class AssessmentScreen extends ConsumerStatefulWidget {
  const AssessmentScreen({super.key});

  @override
  ConsumerState<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends ConsumerState<AssessmentScreen> {
  int _currentStep = 0;
  final Map<String, dynamic> _answers = {};

  final List<Map<String, dynamic>> _questions = [
    {
      'title': 'How are you feeling mentally right now?',
      'options': [
        {'emoji': '😊', 'label': 'Great', 'value': 'great'},
        {'emoji': '😐', 'label': 'Okay', 'value': 'okay'},
        {'emoji': '😔', 'label': 'Down', 'value': 'down'},
        {'emoji': '😫', 'label': 'Stressed', 'value': 'stressed'},
      ],
      'key': 'mood',
    },
    {
      'title': 'How was your sleep quality last night?',
      'options': [
        {'emoji': '😴', 'label': 'Deep & Restful', 'value': 'good'},
        {'emoji': '🥱', 'label': 'Interrupted', 'value': 'fair'},
        {'emoji': '😵', 'label': 'Poor', 'value': 'poor'},
      ],
      'key': 'sleep',
    },
    {
      'title': 'What are your core goals with Renkai?',
      'options': [
        {'emoji': '🧘', 'label': 'Reduce Stress', 'value': 'stress'},
        {'emoji': '📝', 'label': 'Better Journaling', 'value': 'journal'},
        {'emoji': '🤝', 'label': 'Find Therapy', 'value': 'therapy'},
        {'emoji': '🏃', 'label': 'Physical Health', 'value': 'health'},
      ],
      'key': 'goals',
      'multiSelect': true,
    },
  ];

  void _nextStep() {
    if (_currentStep < _questions.length - 1) {
      setState(() => _currentStep++);
    } else {
      // Save state and route to Home
      ref.read(assessmentProvider.notifier).state = AssessmentData(answers: _answers);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const AppShell()),
        (route) => false,
      );
    }
  }

  void _selectOption(String key, String value, bool isMulti) {
    setState(() {
      if (isMulti) {
        final current = List<String>.from(_answers[key] ?? []);
        if (current.contains(value)) {
          current.remove(value);
        } else {
          current.add(value);
        }
        _answers[key] = current;
      } else {
        _answers[key] = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentStep];
    final isMulti = question['multiSelect'] == true;
    final key = question['key'] as String;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: _currentStep > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => setState(() => _currentStep--),
              )
            : null,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Progress Indicator
              Row(
                children: List.generate(_questions.length, (index) {
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      decoration: BoxDecoration(
                        color: index <= _currentStep ? AppColors.primary : Colors.grey[200],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 40),
              
              Text(
                question['title'] as String,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                isMulti ? 'Select all that apply' : 'Select one option',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 40),
              
              ...((question['options'] as List).map((opt) {
                final isSelected = isMulti
                    ? (_answers[key] ?? []).contains(opt['value'])
                    : _answers[key] == opt['value'];
                    
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: InkWell(
                    onTap: () => _selectOption(key, opt['value'] as String, isMulti),
                    borderRadius: BorderRadius.circular(16),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.white,
                        border: Border.all(
                          color: isSelected ? AppColors.primary : Colors.grey[300]!,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Text(opt['emoji'] as String, style: const TextStyle(fontSize: 32)),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              opt['label'] as String,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                color: isSelected ? Colors.black : Colors.black87,
                              ),
                            ),
                          ),
                          if (isSelected) 
                            const Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 28)
                          else 
                            Icon(Icons.circle_outlined, color: Colors.grey[300], size: 28),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList()),
              
              const Spacer(),
              ElevatedButton(
                onPressed: (_answers[key] != null && (_answers[key] is List ? (_answers[key] as List).isNotEmpty : true))
                    ? _nextStep
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  disabledBackgroundColor: Colors.grey[300],
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  elevation: 0,
                ),
                child: Text(
                  _currentStep == _questions.length - 1 ? 'COMPLETE' : 'CONTINUE',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: (_answers[key] != null && (_answers[key] is List ? (_answers[key] as List).isNotEmpty : true))
                        ? Colors.black87
                        : Colors.grey[500],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

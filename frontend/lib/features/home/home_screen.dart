import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../wellbeing/presentation/wellbeing_screen.dart';
import '../therapy/presentation/therapy_screen.dart';
import '../support/support_screen.dart';
import '../data/mock_providers.dart';
import '../../shared/widgets/renkai_logo.dart';
import '../journal/journal_screen.dart';
import '../../shared/widgets/placeholder_screen.dart';
import '../mindfulness/presentation/mindfulness_hub_screen.dart';
import '../profile/profile_drawer.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  void _showAddTaskSheet() {
    final titleCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final timeCtrl = TextEditingController(text: '12:00 PM');
    final freqCtrl = TextEditingController(text: 'Daily');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
            left: 20, right: 20, top: 20
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child: Container(width: 40, height: 5, decoration: const BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))))),
              const SizedBox(height: 20),
              const Text('Add New Task', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.black)),
              const SizedBox(height: 20),
              TextField(
                controller: titleCtrl, 
                decoration: InputDecoration(
                  labelText: 'Task Title',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                )
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descCtrl, 
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                )
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: timeCtrl, 
                      decoration: InputDecoration(
                        labelText: 'Time (e.g. 10:00 AM)',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      )
                    )
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: freqCtrl, 
                      decoration: InputDecoration(
                        labelText: 'Frequency',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      )
                    )
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (titleCtrl.text.isNotEmpty) {
                    ref.read(taskProvider.notifier).addTask(TaskItem(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      title: titleCtrl.text,
                      description: descCtrl.text,
                      time: timeCtrl.text,
                      frequency: freqCtrl.text,
                      type: 'custom',
                    ));
                    Navigator.pop(ctx);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary, 
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  elevation: 0,
                ),
                child: const Text('Add Task', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              const SizedBox(height: 30),
            ],
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final tasks = ref.watch(taskProvider);
    final wellbeing = ref.watch(wellbeingProvider);
    
    final completedTasks = tasks.where((t) => t.isCompleted).length;
    final totalTasks = tasks.length;
    final completionPct = totalTasks > 0 ? completedTasks / totalTasks : 0.0;

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const ProfileDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Curved Header Background
                Positioned(
                  top: -150,
                  left: -100,
                  right: -100,
                  child: Container(
                    height: 480,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFC107), // Yellow curve
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  top: -180,
                  left: -120,
                  right: -50,
                  child: Container(
                    height: 480,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.9), // Orange accent
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top Nav Array
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Builder(
                              builder: (context) => IconButton(
                                icon: const Icon(Icons.menu, size: 30, color: Colors.black),
                                onPressed: () => Scaffold.of(context).openDrawer(),
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.add_circle, size: 38, color: Colors.black87),
                                  onPressed: _showAddTaskSheet,
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  width: 50, height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: AppColors.primary, width: 2),
                                    image: DecorationImage(image: NetworkImage(user.avatarUrl), fit: BoxFit.cover),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Welcome Text
                        Text(
                          'Welcome\n${user.name}',
                          style: const TextStyle(fontSize: 38, fontWeight: FontWeight.w900, color: Colors.black, height: 1.1),
                        ),
                        
                        const SizedBox(height: 30),
                        
                        // NEW Beautiful User Dashboard Component
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 10)),
                            ],
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Daily Pulse', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black)),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                                    child: Text('${(completionPct * 100).toInt()}% Done', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 12)),
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildDashMetric(
                                      icon: Icons.mood, color: Colors.orange, title: 'Mood',
                                      value: '${(wellbeing.moodTracker * 10).toInt()}/10',
                                    ),
                                  ),
                                  Expanded(
                                    child: _buildDashMetric(
                                      icon: Icons.task_alt, color: Colors.green, title: 'Tasks',
                                      value: '$completedTasks/$totalTasks',
                                    ),
                                  ),
                                  Expanded(
                                    child: _buildDashMetric(
                                      icon: Icons.water_drop, color: Colors.blue, title: 'Water',
                                      value: '${wellbeing.waterIntake}L',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
          
          // Tasks Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Your Tasks', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                      TextButton(
                        onPressed: _showAddTaskSheet, 
                        child: const Text('+ Add', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold))
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  ...tasks.map((task) => _buildTaskTile(task)).toList(),
                  if (tasks.isEmpty) const Text("No tasks for today. Add some!", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),
          
          const SliverToBoxAdapter(child: SizedBox(height: 40)),

          // Shifted Progress Section
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text('Performance Analytics', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              decoration: BoxDecoration(
                color: const Color(0xFFFFC107).withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFFFC107).withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 100, height: 100,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          value: completionPct, 
                          strokeWidth: 12, 
                          color: const Color(0xFF00C853),
                          backgroundColor: Colors.grey[200],
                        ),
                        Text('${(completionPct * 100).toInt()}%', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: Colors.black)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildProgressBar('Stress Levels', wellbeing.stressLevels),
                        const SizedBox(height: 12),
                        _buildProgressBar('Quality Sleep', wellbeing.qualitySleep),
                        const SizedBox(height: 12),
                        _buildProgressBar('Mood Tracker', wellbeing.moodTracker),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 20)),

          // Self Help Tools Section
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text('Self Help Tools', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(20)),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(color: const Color(0xFFFFCA28), borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildToolItem(context, Icons.menu_book, 'Journaling', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const JournalScreen()))),
                      _buildToolItem(context, Icons.checklist_rtl_rounded, 'To-Do List', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderScreen(title: 'To-Do list')))),
                      _buildToolItem(context, Icons.psychology, 'Mindfulness Hub', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MindfulnessHubScreen()))),
                      _buildToolItem(context, Icons.medical_services, 'Therapy', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TherapyScreen()))),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SupportScreen())),
        backgroundColor: Colors.white,
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: const Icon(Icons.support_agent_rounded, color: Colors.blueAccent, size: 30),
      ),
    );
  }

  Widget _buildDashMetric({required IconData icon, required Color color, required String title, required String value}) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 8),
        Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.black)),
      ],
    );
  }

  Widget _buildTaskTile(TaskItem task) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: GestureDetector(
          onTap: () => ref.read(taskProvider.notifier).toggleTask(task.id),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 28, height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: task.isCompleted ? const Color(0xFF00C853) : Colors.transparent,
              border: Border.all(color: task.isCompleted ? const Color(0xFF00C853) : Colors.grey[400]!, width: 2),
            ),
            child: task.isCompleted ? const Icon(Icons.check, size: 18, color: Colors.white) : null,
          ),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold,
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            color: task.isCompleted ? Colors.grey : Colors.black87,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(task.description, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.access_time, size: 12, color: Colors.grey[500]),
                const SizedBox(width: 4),
                Text(task.time, style: TextStyle(fontSize: 11, color: Colors.grey[500], fontWeight: FontWeight.w500)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar(String title, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87)),
        const SizedBox(height: 6),
        Container(
          height: 10,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF00C853),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildToolItem(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), shape: BoxShape.circle),
            child: Icon(icon, size: 30, color: Colors.blue[900]),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Colors.black87)),
        ],
      ),
    );
  }
}

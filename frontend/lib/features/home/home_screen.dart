import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../wellbeing/presentation/wellbeing_screen.dart';
import '../therapy/presentation/therapy_screen.dart';
import '../support/support_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Section with curved yellow shape & logo
            SizedBox(
              height: 280,
              child: Stack(
                children: [
                  // Circular decoration for yellow shape
                  Positioned(
                    top: -100,
                    left: -100,
                    child: Container(
                      width: 450,
                      height: 450,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFC107), // Yellow curve
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    top: -120,
                    left: -120,
                    child: Container(
                      width: 450,
                      height: 450,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.9), // Orange shape behind
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    top: -100,
                    left: -100,
                    child: Container(
                      width: 420,
                      height: 420,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFCA28), // Golden Yellow curve
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.menu, size: 35, color: Colors.black),
                              // Top Right Logo
                              Column(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: const BoxDecoration(
                                      color: AppColors.primary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.spa_rounded, color: Colors.white, size: 35),
                                  ),
                                  const Text('RENKAI', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black)),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Welcome\nSage',
                            style: TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                              height: 1.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  // Reminders Card
                  Positioned(
                    right: 20,
                    bottom: 0,
                    child: Container(
                      width: 200,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primary, // Orange remidners card
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Reminders',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
                          ),
                          const SizedBox(height: 8),
                          _buildReminderItem('Take Medicine @ 2:00pm'),
                          const SizedBox(height: 8),
                          _buildReminderItem('Evening Walk @ 5:00pm'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Today's Progress Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Today\'s Progress',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            
            const SizedBox(height: 10),
            
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              color: const Color(0xFFFFC107), // Yellow background banner
              child: Row(
                children: [
                  // Donut chart text left
                  const Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        FittedBox(fit: BoxFit.scaleDown, child: Text('Remaining', style: TextStyle(fontSize: 10, color: Colors.black))),
                        Text('33%', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black)),
                        SizedBox(height: 25), // spacer for pie
                      ],
                    ),
                  ),
                  
                  // Donut Chart Placeholder
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF00C853), // Green pie part
                      border: Border.all(color: Colors.white, width: 12),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFFC107), // yellow center punch
                      ),
                    ),
                  ),
                  
                  // Right sides text
                  const Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 40), // spacer for pie
                          FittedBox(fit: BoxFit.scaleDown, child: Text('Completed', style: TextStyle(fontSize: 10, color: Colors.black))),
                          Text('67%', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                  
                  // Progress Bars
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildProgressBar('Stress Levels', 0.5),
                        const SizedBox(height: 10),
                        _buildProgressBar('Task Completion', 0.8),
                        const SizedBox(height: 10),
                        _buildProgressBar('Mood Tracker', 0.9),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Self Help Tools Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Self Help Tools',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            const SizedBox(height: 15),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFCA28), // Golden Yellow
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildToolItem(context, Icons.menu_book, 'Journaling', () {}),
                          _buildToolItem(context, Icons.checklist_rtl_rounded, 'To-Do List', () {}),
                          _buildToolItem(context, Icons.psychology, 'Wellbeing', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WellbeingScreen()))),
                          _buildToolItem(context, Icons.medical_services, 'Therapy', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TherapyScreen()))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text('See more>>>', style: TextStyle(fontSize: 12, decoration: TextDecoration.underline, color: Colors.black)),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SupportScreen())),
        backgroundColor: Colors.white, // Chatbot floating button
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        child: const Icon(Icons.support_agent_rounded, color: Colors.blueAccent, size: 30),
      ),
    );
  }

  Widget _buildReminderItem(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFFCA28),
        border: Border.all(color: Colors.black, width: 0.5),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(text, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.black)),
    );
  }

  Widget _buildProgressBar(String title, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black)),
        const SizedBox(height: 2),
        Container(
          height: 8,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF00C853),
                borderRadius: BorderRadius.circular(3),
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
          Icon(icon, size: 35, color: Colors.blue[800]),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black)),
        ],
      ),
    );
  }
}

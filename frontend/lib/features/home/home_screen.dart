import 'package:flutter/material.dart';
import '../../shared/glass_container.dart';
import '../mood/mood_entry_screen.dart';
import '../companion/ai_chat_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE8F0FE), Color(0xFFF3E5F5)], // Soft blue to soft peach/purple
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Good Morning, Garv",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "How are you feeling today?",
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
                const SizedBox(height: 30),
                // Mood Widget
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (ctx) => const MoodEntryScreen()));
                  },
                  child: GlassContainer(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Log your mood",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.4),
                              shape: BoxShape.circle,
                            ),
                            child: const Text("😊", style: TextStyle(fontSize: 24)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Quick Actions",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      _buildActionCard(context, "AI Companion", "🤖", const AiChatScreen()),
                      _buildActionCard(context, "Journal", "✍️", null),
                      _buildActionCard(context, "Breathing", "🌬️", null),
                      _buildActionCard(context, "SOS", "🚨", null, isSos: true),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, String title, String emoji, Widget? destination, {bool isSos = false}) {
    return GestureDetector(
      onTap: () {
        if (destination != null) {
          Navigator.push(context, MaterialPageRoute(builder: (ctx) => destination));
        }
      },
      child: GlassContainer(
        color: isSos ? Colors.redAccent.withOpacity(0.15) : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 40)),
            const SizedBox(height: 12),
            Text(title, style: TextStyle(
              fontSize: 16, 
              fontWeight: FontWeight.w600,
              color: isSos ? Colors.redAccent : Colors.black87,
            )),
          ],
        ),
      ),
    );
  }
}

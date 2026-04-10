import 'package:flutter/material.dart';

class BottomAssistButtons extends StatelessWidget {
  const BottomAssistButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Left chat icon group
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.chat_bubble, color: Color(0xFFFF9800), size: 50),
                Positioned(
                  top: -10,
                  right: -15,
                  child: Icon(Icons.chat_bubble, color: Colors.pink[400], size: 40),
                ),
                Positioned(
                  bottom: -5,
                  left: -10,
                  child: Icon(Icons.chat_bubble_outline, color: Colors.blue[400], size: 30),
                ),
              ],
            ),
          ),
          // Right robot icon
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.blue[100],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Stack(
                children: [
                  const Icon(Icons.support_agent_rounded, size: 50, color: Colors.black87),
                  Positioned(
                    top: -5,
                    left: -5,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.blue[400],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text('...', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

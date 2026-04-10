import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../mood/mood_selector_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Orange Banner
            Container(
              width: double.infinity,
              height: 180,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const Icon(
                            Icons.spa_rounded,
                            size: 45,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'RENKAI',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                          color: AppColors.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            const Text(
              'Start Your Journey',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Take the first step towards your',
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 4),
            const Text(
              'MENTAL WELLBEING',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                letterSpacing: 1.0,
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Google Button placeholder
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.g_mobiledata, size: 28, color: Colors.blue[600]), // G icon placeholder
                  const SizedBox(width: 8),
                  const Text('Continue with Google', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // OR divider
            Row(
              children: [
                const Expanded(child: Divider(color: Colors.grey, indent: 40, endIndent: 10)),
                Text('OR', style: TextStyle(color: Colors.grey.shade500)),
                const Expanded(child: Divider(color: Colors.grey, indent: 10, endIndent: 40)),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Form Fields
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  _buildTextField('Sage', false),
                  const SizedBox(height: 15),
                  _buildTextField('965757669', false),
                  const SizedBox(height: 15),
                  _buildTextField('sage@gmail.com', false),
                  const SizedBox(height: 15),
                  _buildTextField('...........', true),
                  const SizedBox(height: 15),
                  _buildTextField('...........', true),
                  
                  const SizedBox(height: 25),
                  
                  const Text(
                    'By signing up, you confirm that you have read and agreed to',
                    style: TextStyle(fontSize: 10, color: Colors.black87),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Renkai's ", style: TextStyle(fontSize: 10, color: Colors.black87)),
                      Text("Privacy Policy", style: TextStyle(fontSize: 10, decoration: TextDecoration.underline, fontWeight: FontWeight.bold, color: Colors.black)),
                      Text(" & ", style: TextStyle(fontSize: 10, color: Colors.black87)),
                      Text("Terms", style: TextStyle(fontSize: 10, decoration: TextDecoration.underline, fontWeight: FontWeight.bold, color: Colors.black)),
                    ],
                  ),
                  
                  const SizedBox(height: 15),
                  
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const MoodSelectorScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text('CONTINUE'),
                  ),
                  
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already a member? ', style: TextStyle(color: Colors.black87)),
                      GestureDetector(
                        onTap: () {
                          // Handle login
                        },
                        child: const Text('Log in', style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline, color: Colors.black)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, bool isPassword) {
    return TextFormField(
      obscureText: isPassword,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black87),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        suffixIcon: isPassword ? const Icon(Icons.remove_red_eye_outlined, color: Colors.grey) : null,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }
}

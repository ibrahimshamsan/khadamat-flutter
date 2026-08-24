import 'package:flutter/material.dart';
import 'login_screen.dart';

// ==================== الألوان الموحدة للتطبيق ====================
class AppColors {
  static const Color bgTop = Color(0xFF0F172A);
  static const Color bgMid = Color(0xFF17104A);
  static const Color bgBottom = Color(0xFF2B176B);

  static const Color subtitleGrey = Color(0xFFD7D9E5);

  static const Color gradStart = Color(0xFF5B6CFF);
  static const Color gradMid = Color(0xFF8B5CF6);
  static const Color gradEnd = Color(0xFFD946EF);

  static const LinearGradient bgGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [bgTop, bgMid, bgBottom],
  );

  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [gradStart, gradMid, gradEnd],
  );
}

// ==================== شاشة الترحيب (Splash) ====================
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(gradient: AppColors.bgGradient),
          child: SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 2),

                Image.asset(
                  'assets/images/icon1.png',
                  width: 190,
                  height: 190,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 25),

                const Text(
                  'خدمات',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  'تسويق ذكي | حلول مبتكرة | نمو مستدام',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.subtitleGrey,
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const Spacer(flex: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:souqna_app/app/shell/app_shell.dart';
import 'package:souqna_app/features/auth/presentation/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    // بننتظر ثانيتين عشان السبلاش سكرين تفضل ظاهرة شوية
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // بنفتح الذاكرة المحلية
    final prefs = await SharedPreferences.getInstance();
    // بنشوف هل المستخدم شاف الشاشات قبل كده؟ القيمة الافتراضية هي false
    final bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;

    if (hasSeenOnboarding) {
      // لو شافها، وديه على الرئيسية
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AppShell()),
      );
    } else {
      // لو أول مرة، وديه على شاشات الترحيب
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.storefront_outlined, color: Colors.white, size: 80),
            SizedBox(height: 20),
            Text(
              'سوقنا',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
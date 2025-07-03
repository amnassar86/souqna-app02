import 'dart:async';
import 'package:flutter/material.dart';
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
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          // ٢. الانتقال إلى شاشة الترحيب بدلاً من الشاشة الوهمية
          builder: (context) => const OnboardingScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // تصميم الشاشة
    return const Scaffold(
      backgroundColor: Colors.teal, // يمكنك تغيير اللون لاحقاً ليناسب هوية التطبيق
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // سنضع هنا صورة الشعار لاحقاً
            Icon(Icons.storefront_outlined, color: Colors.white, size: 80),
            SizedBox(height: 20),
            Text(
              'سوقنا',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                // fontFamily: 'Cairo', // سنفعل الخطوط في خطوة لاحقة
              ),
            ),
          ],
        ),
      ),
    );
  }
}
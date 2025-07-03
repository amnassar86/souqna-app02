import 'package:flutter/material.dart';
// 1. استيراد حزمة الترجمة
import 'package:flutter_localizations/flutter_localizations.dart'; 
import 'package:souqna_app/features/splash/presentation/screens/splash_screen.dart';

void main() {
  runApp(const SouqnaApp());
}

class SouqnaApp extends StatelessWidget {
  const SouqnaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Souqna',
      
      // --- بداية الإضافات الخاصة باللغة العربية ---
      locale: const Locale('ar'), // 2. تحديد اللغة العربية
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', ''), // دعم اللغة العربية
      ],
      // --- نهاية الإضافات ---

      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Cairo',
      ),
      home: const SplashScreen(),
    );
  }
}
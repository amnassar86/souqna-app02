import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart'; // 1. استيراد المكتبة
import 'package:souqna_app/features/cart/data/cart_provider.dart'; // 2. استيراد مخزن السلة
import 'package:souqna_app/features/splash/presentation/screens/splash_screen.dart';

void main() {
  runApp(
    // 3. تغليف التطبيق بالـ Provider
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: const SouqnaApp(),
    ),
  );
}

class SouqnaApp extends StatelessWidget {
  const SouqnaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Souqna',
      locale: const Locale('ar'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', ''),
      ],
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Cairo',
      ),
      home: const SplashScreen(),
    );
  }
}
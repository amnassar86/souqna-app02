import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:souqna_app/features/cart/data/cart_provider.dart';
import 'package:souqna_app/features/splash/presentation/screens/splash_screen.dart';
// 1. استيراد مكتبة Supabase
import 'package:supabase_flutter/supabase_flutter.dart';

// 2. تحويل الدالة لـ async عشان ننتظر الربط
Future<void> main() async {
  // السطر ده مهم عشان نضمن إن كل حاجة جاهزة قبل تشغيل التطبيق
  WidgetsFlutterBinding.ensureInitialized();

  // 3. تهيئة الاتصال مع Supabase باستخدام بياناتك
  await Supabase.initialize(
    url: 'https://mzamlvdbzntliviiglea.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im16YW1sdmRiem50bGl2aWlnbGVhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTEyOTM5NjcsImV4cCI6MjA2Njg2OTk2N30.QHnjyIOGhcNslExMKcLupW7igtA8QW1qEHVQVnFVZVc',
  );
  
  runApp(
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
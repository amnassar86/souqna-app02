import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:souqna_app/app/shell/app_shell.dart';
import 'package:souqna_app/features/auth/presentation/screens/login_screen.dart';
import 'package:souqna_app/features/auth/presentation/screens/signup_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _isGoogleLoading = false;

  Future<void> _googleSignIn() async {
    setState(() {
      _isGoogleLoading = true;
    });

    try {
      // 1. ابدأ عملية تسجيل الدخول مع جوجل
      //  *** مهم جداً: استبدل الكلام ده بالـ Web Client ID بتاعك ***
      const webClientId = '1088115363771-kr91tolho4kvgl9611r5ni3jrpoj0et4.apps.googleusercontent.com';
      
      final googleSignIn = GoogleSignIn(serverClientId: webClientId);
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        // لو المستخدم كنسل عملية الدخول
        setState(() { _isGoogleLoading = false; });
        return;
      }
      final googleAuth = await googleUser.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null) {
        throw 'No Access Token found.';
      }
      if (idToken == null) {
        throw 'No ID Token found.';
      }

      // 2. ابعت التوكن لـ Supabase عشان يسجل المستخدم
      final supabase = Supabase.instance.client;
      await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
      
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const AppShell()),
          (route) => false,
        );
      }

    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ أثناء تسجيل الدخول بجوجل'), backgroundColor: Theme.of(context).colorScheme.error),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isGoogleLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const Icon(Icons.storefront_outlined, size: 100, color: Colors.teal),
              const SizedBox(height: 20),
              const Text('أهلاً بك في سوقنا', textAlign: TextAlign.center, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text('بوابتك الرقمية للسوق المحلي', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.grey)),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignupScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('إنشاء حساب جديد', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16),
              // --- زر الدخول بجوجل الجديد ---
              ElevatedButton.icon(
                onPressed: _isGoogleLoading ? null : _googleSignIn,
                icon: _isGoogleLoading
                    ? const SizedBox.shrink() // إخفاء الأيقونة عند التحميل
                    : Image.asset('assets/google_logo.png', height: 24.0), // سنضيف هذه الصورة
                label: _isGoogleLoading 
                    ? const CircularProgressIndicator(color: Colors.teal)
                    : const Text('المتابعة باستخدام جوجل'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {
                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
                  },
                  child: const Text('لدي حساب بالفعل', style: TextStyle(fontSize: 16, color: Colors.teal, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:souqna_app/features/auth/presentation/screens/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();
  bool _isLoading = false;

  Future<void> _signUp() async {
    final isValid = _formKey.currentState?.validate();
    if (isValid != true) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final supabase = Supabase.instance.client;
      // الكود المبسط الذي يعتمد على الـ Trigger في قاعدة البيانات
      await supabase.auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        // بنبعت الاسم هنا عشان الـ Trigger يستخدمه في جدول profiles
        data: {'full_name': _fullNameController.text.trim()},
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم إنشاء الحساب بنجاح! يرجى تأكيد بريدك الإلكتروني.')),
        );
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    } on AuthException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message), backgroundColor: Theme.of(context).colorScheme.error),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: const Text('حدث خطأ غير متوقع'), backgroundColor: Theme.of(context).colorScheme.error),
        );
      }
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                const Text('إنشاء حساب جديد', textAlign: TextAlign.center, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text('أهلاً بك! يرجى ملء الحقول التالية', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.grey)),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(labelText: 'الاسم الكامل', prefixIcon: Icon(Icons.person_outline), border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'الرجاء إدخال الاسم الكامل';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'البريد الإلكتروني', prefixIcon: Icon(Icons.email_outlined), border: OutlineInputBorder()),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty || !value.contains('@')) {
                      return 'الرجاء إدخال بريد إلكتروني صحيح';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'كلمة المرور', prefixIcon: Icon(Icons.lock_outline), border: OutlineInputBorder()),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'كلمة المرور يجب أن لا تقل عن 6 أحرف';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _isLoading ? null : _signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('إنشاء الحساب', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('لديك حساب بالفعل؟'),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()));
                      },
                      child: const Text('تسجيل الدخول', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal)),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
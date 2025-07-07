import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:souqna_app/features/cart/data/cart_provider.dart';
import 'package:souqna_app/features/auth/presentation/screens/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // استيراد Supabase

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  // 1. إضافة Controllers للتحكم في حقول الإدخال
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();
  bool _isLoading = false; // لإظهار مؤشر التحميل

  // دالة لتسجيل المستخدم
  Future<void> _signUp() async {
    // التحقق من صحة البيانات المدخلة
    final isValid = _formKey.currentState?.validate();
    if (isValid != true) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // 2. التواصل مع Supabase لإنشاء حساب جديد
      final supabase = Supabase.instance.client;
      await supabase.auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        data: {
          'full_name': _fullNameController.text.trim()
        }, // هنا بنبعت البيانات الإضافية اللي هتتخزن في profiles
      );

      // 3. إظهار رسالة نجاح وتوجيه المستخدم
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم إنشاء الحساب بنجاح! يرجى تأكيد بريدك الإلكتروني.')),
        );
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    } on AuthException catch (error) {
      // 4. التعامل مع الأخطاء
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message), backgroundColor: Colors.red),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('حدث خطأ غير متوقع'), backgroundColor: Colors.red),
        );
      }
    }

    setState(() {
      _isLoading = false;
    });
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
        // ... (بقية الـ AppBar كما هو)
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ... (العناوين ومساحات فارغة كما هي)
                const SizedBox(height: 40),

                // حقول الإدخال مع ربطها بالـ Controllers
                TextFormField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(labelText: 'الاسم الكامل', /* ... */),
                  validator: (value) {
                    return null;
                   /* ... */ },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'البريد الإلكتروني', /* ... */),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    return null;
                   /* ... */ },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'كلمة المرور', /* ... */),
                  obscureText: true,
                  validator: (value) {
                    return null;
                   /* ... */ },
                ),
                const SizedBox(height: 40),

                // زر إنشاء الحساب
                ElevatedButton(
                  onPressed: _isLoading ? null : _signUp, // تفعيل الزر أو تعطيله
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('إنشاء الحساب'),
                  // ... (بقية الستايل كما هو)
                ),
                // ... (بقية الكود كما هو)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
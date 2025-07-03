import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. أضفنا شريطاً علوياً لعنوان الصفحة
      appBar: AppBar(
        title: const Text('حسابي'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          // 2. أنشأنا ويدجت قابلة لإعادة الاستخدام لكل عنصر في القائمة
          ProfileMenuItem(
            title: 'ملفي الشخصي',
            icon: Icons.person_outline,
            onTap: () {
              // سيتم الانتقال لصفحة الملف الشخصي هنا
            },
          ),
          ProfileMenuItem(
            title: 'دعوة صديق',
            icon: Icons.group_add_outlined,
            onTap: () {
              // سيتم فتح نافذة المشاركة هنا
            },
          ),
          ProfileMenuItem(
            title: 'خدمة العملاء',
            icon: Icons.support_agent_outlined,
            onTap: () {
              // سيتم الانتقال لصفحة خدمة العملاء هنا
            },
          ),
          const Divider(height: 20, thickness: 1), // فاصل بصري
          ProfileMenuItem(
            title: 'الإعدادات',
            icon: Icons.settings_outlined,
            onTap: () {
              // سيتم الانتقال لصفحة الإعدادات هنا
            },
          ),
          const Divider(height: 20, thickness: 1),
          // 3. أضفنا زر تسجيل الخروج كخيار مهم في هذه الصفحة
          ProfileMenuItem(
            title: 'تسجيل الخروج',
            icon: Icons.logout,
            textColor: Colors.red, // لتمييزه عن بقية الخيارات
            onTap: () {
              // سيتم تنفيذ عملية تسجيل الخروج هنا
            },
          ),
        ],
      ),
    );
  }
}

/// ويدجت مخصصة وقابلة لإعادة الاستخدام لعرض عناصر القائمة
/// هذا يجعل الكود الرئيسي أنظف وأسهل في القراءة
class ProfileMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color? textColor;

  const ProfileMenuItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: textColor ?? Colors.teal),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
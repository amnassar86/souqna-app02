import 'package:flutter/material.dart';
import 'package:souqna_app/features/settings/presentation/screens/settings_screen.dart';
import 'package:souqna_app/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:souqna_app/features/customer_service/presentation/screens/customer_service_screen.dart';
import 'package:souqna_app/features/invite_friend/presentation/screens/invite_friend_screen.dart';






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
                Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                );
            },
          ),
          ProfileMenuItem(
            title: 'دعوة صديق',
            icon: Icons.group_add_outlined,
            onTap: () {
                Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const InviteFriendScreen()),
              );
            },
          ),
          ProfileMenuItem(
            title: 'خدمة العملاء',
            icon: Icons.support_agent_outlined,
            onTap: () {
                Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CustomerServiceScreen()),
              );
            },
          ),
          const Divider(height: 20, thickness: 1), // فاصل بصري
          ProfileMenuItem(
            title: 'الإعدادات',
            icon: Icons.settings_outlined,
            onTap: () {
                  // الانتقال إلى شاشة الإعدادات
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
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
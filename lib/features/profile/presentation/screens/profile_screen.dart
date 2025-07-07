import 'package:flutter/material.dart';
import 'package:souqna_app/features/settings/presentation/screens/settings_screen.dart';
import 'package:souqna_app/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:souqna_app/features/customer_service/presentation/screens/customer_service_screen.dart';
import 'package:souqna_app/features/invite_friend/presentation/screens/invite_friend_screen.dart';
import 'package:souqna_app/features/profile/presentation/screens/my_addresses_screen.dart'; // 1. استيراد الشاشة الجديدة

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('حسابي'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          ProfileMenuItem(
            title: 'ملفي الشخصي',
            icon: Icons.person_outline,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const EditProfileScreen()),
              );
            },
          ),
          // --- 2. هذا هو الخيار الجديد الذي تمت إضافته ---
          ProfileMenuItem(
            title: 'عناويني',
            icon: Icons.location_on_outlined,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const MyAddressesScreen()),
              );
            },
          ),
          const Divider(height: 20, thickness: 1, indent: 16, endIndent: 16), // فاصل إضافي
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
          const Divider(height: 20, thickness: 1),
          ProfileMenuItem(
            title: 'الإعدادات',
            icon: Icons.settings_outlined,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
          const Divider(height: 20, thickness: 1),
          ProfileMenuItem(
            title: 'تسجيل الخروج',
            icon: Icons.logout,
            textColor: Colors.red,
            onTap: () {
              // سيتم تنفيذ عملية تسجيل الخروج هنا
            },
          ),
        ],
      ),
    );
  }
}

// ويدجت مخصصة وقابلة لإعادة الاستخدام لعرض عناصر القائمة
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
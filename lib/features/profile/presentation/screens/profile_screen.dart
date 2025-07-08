import 'package:flutter/material.dart';
import 'package:souqna_app/app/shell/app_shell.dart';
import 'package:souqna_app/features/auth/presentation/screens/welcome_screen.dart';
import 'package:souqna_app/features/settings/presentation/screens/settings_screen.dart';
import 'package:souqna_app/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:souqna_app/features/customer_service/presentation/screens/customer_service_screen.dart';
import 'package:souqna_app/features/invite_friend/presentation/screens/invite_friend_screen.dart';
import 'package:souqna_app/features/profile/presentation/screens/my_addresses_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Supabase.instance.client.auth.currentSession;

    return Scaffold(
      appBar: AppBar(
        title: const Text('حسابي'),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        centerTitle: true,
      ),
      body: session == null
          ? const _GuestProfileView()
          : const _UserProfileView(),
    );
  }
}

class _UserProfileView extends StatelessWidget {
  const _UserProfileView();

  @override
  Widget build(BuildContext context) {
    return ListView(
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
        ProfileMenuItem(
          title: 'عناويني',
          icon: Icons.location_on_outlined,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const MyAddressesScreen()),
            );
          },
        ),
        const Divider(height: 20, thickness: 1, indent: 16, endIndent: 16),
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
          onTap: () async {
            await Supabase.instance.client.auth.signOut();
            if (context.mounted) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const AppShell(initialIndex: 0)),
                (route) => false,
              );
            }
          },
        ),
      ],
    );
  }
}

class _GuestProfileView extends StatelessWidget {
  const _GuestProfileView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(Icons.person_pin_circle_outlined, size: 80, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'لم تقم بتسجيل الدخول',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'سجل الآن لتدير طلباتك وملفك الشخصي.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const WelcomeScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('تسجيل الدخول أو إنشاء حساب', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}

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
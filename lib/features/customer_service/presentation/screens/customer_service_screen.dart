import 'package:flutter/material.dart';

class CustomerServiceScreen extends StatelessWidget {
  const CustomerServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('خدمة العملاء'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        children: [
          const _SectionTitle(title: 'الأسئلة الشائعة'),

          // 1. قسم الأسئلة الشائعة باستخدام ExpansionTile
          ExpansionTile(
            leading: const Icon(Icons.chat_bubble_outline),
            title: const Text('كيف يمكنني تتبع طلبي؟'),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Text(
                  'يمكنك تتبع طلبك بسهولة من خلال الذهاب إلى شاشة "طلباتي" من شريط التنقل السفلي، ثم اختيار الطلب الذي تريد متابعته.',
                  style: TextStyle(color: Colors.grey[700], height: 1.5),
                ),
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.payment_outlined),
            title: const Text('ما هي طرق الدفع المتاحة؟'),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Text(
                  'حالياً، الطريقة المتاحة هي "الدفع عند الاستلام". نعمل على إضافة خيارات دفع إلكترونية قريباً.',
                  style: TextStyle(color: Colors.grey[700], height: 1.5),
                ),
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.cancel_outlined),
            title: const Text('كيف يمكنني إلغاء الطلب؟'),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Text(
                  'يمكنك إلغاء الطلب طالما حالته "قيد المراجعة". بعد أن يصبح "قيد التجهيز"، يرجى التواصل معنا مباشرة عبر الواتساب لإلغائه.',
                  style: TextStyle(color: Colors.grey[700], height: 1.5),
                ),
              ),
            ],
          ),

          const Divider(height: 30, thickness: 1, indent: 16, endIndent: 16),
          const _SectionTitle(title: 'تواصل معنا'),

          // 2. قسم تواصل معنا
          ListTile(
            leading: const Icon(Icons.call_outlined),
            title: const Text('اتصل بنا'),
            subtitle: const Text('+966 12 345 6789'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.email_outlined),
            title: const Text('البريد الإلكتروني'),
            subtitle: const Text('support@souqna.app'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.wechat_outlined), // أيقونة شبيهة بالواتساب
            title: const Text('تواصل عبر الواتساب'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

// ويدجت مساعدة لعنوان القسم
class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade600,
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // نحتاجها لخاصية النسخ

class InviteFriendScreen extends StatelessWidget {
  const InviteFriendScreen({super.key});

  final String referralCode = 'SOUQNA123'; // كود دعوة وهمي

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ادعُ صديقاً'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            // 1. أيقونة أو رسمة كبيرة
            const Icon(Icons.card_giftcard_outlined, color: Colors.teal, size: 100),
            const SizedBox(height: 24),

            // 2. الرسالة التشجيعية
            const Text(
              'شارك التطبيق واكسب مكافأة!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'سيحصل صديقك على خصم 10% على أول طلب، وستحصل أنت على رصيد 20 ر.س في محفظتك بعد إتمامه أول طلب.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[700], height: 1.5),
            ),
            const SizedBox(height: 32),

            // 3. كود الدعوة
            const Text(
              'كود الدعوة الخاص بك',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.teal),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    referralCode,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy_all_outlined),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: referralCode));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('تم نسخ الكود!')),
                      );
                    },
                  ),
                ],
              ),
            ),

            const Spacer(),

            // 4. زر المشاركة
            ElevatedButton.icon(
              onPressed: () {
                // هنا سيتم فتح نافذة المشاركة لمشاركة الرابط
              },
              icon: const Icon(Icons.share_outlined),
              label: const Text('شارك رابط الدعوة'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
             const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
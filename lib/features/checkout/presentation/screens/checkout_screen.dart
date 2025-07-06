import 'package:flutter/material.dart';
import 'package:souqna_app/features/order_success/presentation/screens/order_success_screen.dart';


class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

enum PaymentMethod { cash, card }

class _CheckoutScreenState extends State<CheckoutScreen> {
  PaymentMethod _selectedMethod = PaymentMethod.cash;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إتمام الطلب'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. قسم عنوان التوصيل ---
            const _SectionHeader(title: 'عنوان التوصيل'),
            const SizedBox(height: 8),
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: const Icon(Icons.location_on_outlined, color: Colors.teal),
                title: const Text('شارع الأمير محمد بن سلمان، حي الياسمين'),
                subtitle: const Text('الرياض، المملكة العربية السعودية'),
                trailing: TextButton(
                  onPressed: () {},
                  child: const Text('تغيير'),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // --- 2. قسم طريقة الدفع ---
            const _SectionHeader(title: 'طريقة الدفع'),
            const SizedBox(height: 8),
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  RadioListTile<PaymentMethod>(
                    title: const Text('الدفع عند الاستلام'),
                    value: PaymentMethod.cash,
                    groupValue: _selectedMethod,
                    onChanged: (PaymentMethod? value) {
                      setState(() {
                        _selectedMethod = value!;
                      });
                    },
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  RadioListTile<PaymentMethod>(
                    title: const Text('البطاقة الإئتمانية'),
                    value: PaymentMethod.card,
                    groupValue: _selectedMethod,
                    onChanged: (PaymentMethod? value) {
                      setState(() {
                        _selectedMethod = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // --- 3. ملخص الطلب ---
            const _SectionHeader(title: 'ملخص الطلب'),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: const [
                   _SummaryRow(title: 'المجموع الفرعي', value: '450.00 ر.س'),
                   SizedBox(height: 8),
                   _SummaryRow(title: 'رسوم التوصيل', value: '25.00 ر.س'),
                   Divider(height: 24),
                  _SummaryRow(
                    title: 'المجموع الكلي',
                    value: '475.00 ر.س',
                    isTotal: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // --- 4. زر تأكيد الطلب ---
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // هنا يتم إرسال الطلب النهائي
            Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const OrderSuccessScreen()),
            (Route<dynamic> route) => false, // هذا السطر يمسح كل ما سبق
          );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text('تأكيد الطلب'),
        ),
      ),
    );
  }
}

// --- ويدجتس مساعدة ---

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String title;
  final String value;
  final bool isTotal;

  const _SummaryRow({
    required this.title,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: isTotal ? 18 : 16,
      fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: style),
        Text(value, style: style),
      ],
    );
  }
}
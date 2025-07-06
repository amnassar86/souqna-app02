import 'package:flutter/material.dart';
import 'package:souqna_app/features/checkout/presentation/screens/checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. الشريط العلوي
      appBar: AppBar(
        title: const Text('سلة التسوق'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 2. قائمة المنتجات
          Expanded(
            child: ListView.builder(
              itemCount: 3, // عدد المنتجات الوهمية في السلة
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              itemBuilder: (context, index) {
                return _CartItemCard(index: index);
              },
            ),
          ),

          // 3. ملخص الطلب
          const _OrderSummary(),
        ],
      ),
      // 4. زر إتمام الطلب
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          // --- هذا هو التعديل المطلوب ---
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CheckoutScreen()),
            );
          },
          // -----------------------------
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text('إتمام الطلب'),
        ),
      ),
    );
  }
}

// --- ويدجتس مساعدة لتنظيف الكود ---

// ويدجت لبطاقة المنتج في السلة
class _CartItemCard extends StatelessWidget {
  final int index;
  const _CartItemCard({required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          // صورة المنتج
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              'https://picsum.photos/200/200?random=${index + 300}',
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          // اسم المنتج والكمية
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'اسم المنتج يظهر هنا',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                // أداة التحكم بالكمية
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        constraints: const BoxConstraints(),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        onPressed: () {},
                        icon: const Icon(Icons.remove, size: 18),
                      ),
                      const Text('1', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      IconButton(
                        constraints: const BoxConstraints(),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        onPressed: () {},
                        icon: const Icon(Icons.add, size: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // السعر وزر الحذف
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                '150.00 ر.س',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete_outline, color: Colors.red),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// ويدجت لملخص الطلب
class _OrderSummary extends StatelessWidget {
  const _OrderSummary();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const _SummaryRow(title: 'المجموع الفرعي', value: '450.00 ر.س'),
          const SizedBox(height: 8),
          const _SummaryRow(title: 'رسوم التوصيل', value: '25.00 ر.س'),
          const Divider(height: 24),
          _SummaryRow(
            title: 'المجموع الكلي',
            value: '475.00 ر.س',
            isTotal: true,
          ),
        ],
      ),
    );
  }
}

// ويدجت لسطر في ملخص الطلب
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
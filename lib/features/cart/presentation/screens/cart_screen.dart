import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:souqna_app/features/cart/data/cart_provider.dart';
import 'package:souqna_app/features/checkout/presentation/screens/checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. نستخدم Consumer عشان الشاشة تتحدث تلقائياً مع أي تغيير في السلة
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('سلة التسوق'),
            centerTitle: true,
          ),
          // 2. نعرض رسالة لو السلة فاضية، أو نعرض المنتجات لو مش فاضية
          body: cart.items.isEmpty
              ? const _EmptyCart() // ويدجت للسلة الفارغة
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cart.itemCount, // بنستخدم العدد الحقيقي من الذاكرة
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        itemBuilder: (context, index) {
                          final item = cart.items[index]; // بنجيب المنتج الحقيقي
                          return _CartItemCard(
                            productName: item,
                            index: index,
                          );
                        },
                      ),
                    ),
                    _OrderSummary(itemCount: cart.itemCount), // بنمرر عدد المنتجات للملخص
                  ],
                ),
          // 3. بنعطل زر إتمام الطلب لو السلة فاضية
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: cart.items.isEmpty
                  ? null // تعطيل الزر
                  : () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const CheckoutScreen()),
                      );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.grey, // لون الزر وهو معطل
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
      },
    );
  }
}

// --- ويدجتس مساعدة ---

// ويدجت لبطاقة المنتج في السلة (تم تعديلها)
class _CartItemCard extends StatelessWidget {
  final String productName;
  final int index;
  const _CartItemCard({required this.productName, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName, // بنعرض اسم المنتج الحقيقي
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                '150.00 ر.س',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // تفعيل زر الحذف
              IconButton(
                onPressed: () {
                  // بنكلم الذاكرة ونقولها تمسح المنتج ده
                  Provider.of<CartProvider>(context, listen: false).removeItem(productName);
                },
                icon: const Icon(Icons.delete_outline, color: Colors.red),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// ويدجت لملخص الطلب (تم تعديلها)
class _OrderSummary extends StatelessWidget {
  final int itemCount;
  const _OrderSummary({required this.itemCount});

  @override
  Widget build(BuildContext context) {
    // حسابات وهمية بسيطة
    final subtotal = itemCount * 150.0;
    const deliveryFee = 25.0; // رسوم التوصيل ثابتة، فممكن تفضل const
    final total = subtotal + deliveryFee;

    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // --- هنا التعديل: شيلنا const من السطرين دول ---
          _SummaryRow(title: 'المجموع الفرعي', value: '${subtotal.toStringAsFixed(2)} ر.س'),
          const SizedBox(height: 8),
          _SummaryRow(title: 'رسوم التوصيل', value: '${deliveryFee.toStringAsFixed(2)} ر.س'),
          const Divider(height: 24),
          _SummaryRow(
            title: 'المجموع الكلي',
            value: '${total.toStringAsFixed(2)} ر.س',
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

  const _SummaryRow({required this.title, required this.value, this.isTotal = false});

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

// ويدجت جديدة للسلة الفارغة
class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
          const SizedBox(height: 20),
          const Text(
            'سلة التسوق فارغة!',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'أضف بعض المنتجات لتبدأ رحلة التسوق.',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
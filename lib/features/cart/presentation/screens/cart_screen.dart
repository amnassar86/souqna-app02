import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:souqna_app/features/cart/data/cart_provider.dart';
import 'package:souqna_app/features/checkout/presentation/screens/checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('سلة التسوق'),
            centerTitle: true,
          ),
          body: cart.items.isEmpty
              ? const _EmptyCart()
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cart.itemCount,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        itemBuilder: (context, index) {
                          final product = cart.items[index];
                          return _CartItemCard(
                            product: product,
                            index: index,
                          );
                        },
                      ),
                    ),
                    _OrderSummary(subtotal: cart.subtotal),
                  ],
                ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: cart.items.isEmpty
                  ? null
                  : () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const CheckoutScreen()),
                      );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.grey,
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

class _CartItemCard extends StatelessWidget {
  final Product product;
  final int index;
  const _CartItemCard({required this.product, required this.index});

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
                  product.name,
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
                      IconButton(constraints: const BoxConstraints(), padding: const EdgeInsets.symmetric(horizontal: 8), onPressed: () {}, icon: const Icon(Icons.remove, size: 18)),
                      const Text('1', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      IconButton(constraints: const BoxConstraints(), padding: const EdgeInsets.symmetric(horizontal: 8), onPressed: () {}, icon: const Icon(Icons.add, size: 18)),
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
              Text(
                '${product.price.toStringAsFixed(2)} ر.س',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              IconButton(
                onPressed: () {
                  Provider.of<CartProvider>(context, listen: false).removeItem(product);
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

class _OrderSummary extends StatelessWidget {
  final double subtotal;
  const _OrderSummary({required this.subtotal});

  @override
  Widget build(BuildContext context) {
    const deliveryFee = 25.0;
    final total = subtotal + deliveryFee;

    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _SummaryRow(title: 'المجموع الفرعي', value: '${subtotal.toStringAsFixed(2)} ر.س'),
          const SizedBox(height: 8),
          // --- هنا التعديل: شيلنا const من السطر ده ---
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

class _SummaryRow extends StatelessWidget {
  final String title;
  final String value;
  final bool isTotal;
  const _SummaryRow({required this.title, required this.value, this.isTotal = false});

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(fontSize: isTotal ? 18 : 16, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(title, style: style), Text(value, style: style)],
    );
  }
}

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
          const Text('سلة التسوق فارغة!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('أضف بعض المنتجات لتبدأ رحلة التسوق.', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
        ],
      ),
    );
  }
}
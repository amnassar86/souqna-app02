import 'package:flutter/material.dart';
import 'dart:math';
import 'package:souqna_app/features/product/presentation/screens/product_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:souqna_app/features/cart/data/cart_provider.dart';
import 'package:souqna_app/features/cart/presentation/screens/cart_screen.dart';

class StoreDetailsScreen extends StatelessWidget {
  const StoreDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            pinned: true,
            stretch: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: const Text('ماركوس للحلويات'),
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://picsum.photos/900/400?random=${Random().nextInt(50)}',
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.4),
                colorBlendMode: BlendMode.darken,
              ),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
            ],
          ),
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: const Offset(0, 0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _StoreInfoCard(),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: _SectionTitle(title: 'الأكثر طلباً')),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.7,
              ),
              itemCount: 4,
              itemBuilder: (context, index) => _ProductGridCard(index: index),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          const SliverToBoxAdapter(child: _SectionTitle(title: 'قائمة المنتجات')),
          SliverList.builder(
            itemCount: 8,
            itemBuilder: (context, index) => _ProductListItem(index: index),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),

          // --- هذا هو السطر الجديد الذي يحل المشكلة ---
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.itemCount == 0) {
            return const _MinOrderBottomBar();
          } else {
            return _ViewCartBottomBar(
              itemCount: cart.itemCount,
              totalAmount: cart.subtotal,
            );
          }
        },
      ),
    );
  }
}

// الكود النهائي والصحيح للشريط السفلي
class _ViewCartBottomBar extends StatelessWidget {
  final int itemCount;
  final double totalAmount;

  const _ViewCartBottomBar({required this.itemCount, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          // 1. الجزء الخاص بالنصوص
          children: [
            Column(
              mainAxisSize: MainAxisSize.min, // مهم: يجعل العمود يأخذ أقل ارتفاع ممكن
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'تم إضافة ($itemCount) منتج',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  'الإجمالي: ${totalAmount.toStringAsFixed(2)} ر.س',
                  style: const TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),

            // 2. الـ Spacer يأخذ كل المساحة الفارغة في المنتصف
            const Spacer(),

            // 3. الزر
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('عرض السلة'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductGridCard extends StatelessWidget {
  final int index;
  const _ProductGridCard({required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ProductDetailsScreen()));
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  'https://picsum.photos/300/400?random=${index + 50}',
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('اسم المنتج',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text('150.00 ر.س',
                          style: TextStyle(
                              color: Colors.teal, fontWeight: FontWeight.bold)),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 4,
              left: 4,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.teal,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.add_shopping_cart_outlined,
                      color: Colors.white, size: 20),
                  onPressed: () {
                    final cart =
                        Provider.of<CartProvider>(context, listen: false);
                    cart.addItem(Product(
                        name: 'منتج من الشبكة ${index + 1}', price: 150.0));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('تمت الإضافة إلى السلة!'),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ProductListItem extends StatelessWidget {
  final int index;
  const _ProductListItem({required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ProductDetailsScreen()));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('اسم منتج آخر مميز',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('وصف قصير للمنتج...',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('90.00 ر.س',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.teal,
                              fontWeight: FontWeight.bold)),
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.teal.withOpacity(0.1),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.add_shopping_cart_outlined,
                              color: Colors.teal, size: 20),
                          onPressed: () {
                            final cart =
                                Provider.of<CartProvider>(context, listen: false);
                            cart.addItem(Product(
                                name: 'منتج من القائمة ${index + 1}', price: 90.0));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('تمت الإضافة إلى السلة!'),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  'https://picsum.photos/300/300?random=${index + 200}',
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _StoreInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                      'https://picsum.photos/100/100?random=1',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('ماركوس للحلويات',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text('حلويات، مشروبات، قهوة',
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                _InfoChip(icon: Icons.star, text: '4.6'),
                _InfoChip(icon: Icons.timer_outlined, text: '25-40 د'),
                _InfoChip(icon: Icons.delivery_dining, text: '24.99 ج.م'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoChip({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600], size: 18),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class _MinOrderBottomBar extends StatelessWidget {
  const _MinOrderBottomBar();
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'أضف منتجات بقيمة 50.00 ر.س للوصول للحد الأدنى',
          textAlign: TextAlign.center,
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
        ),
      ),
    );
  }
}
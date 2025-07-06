import 'package:flutter/material.dart';
import 'dart:math';
// 1. استيراد صفحة المتجر للانتقال إليها
import 'package:souqna_app/features/store/presentation/screens/store_details_screen.dart';
import 'package:souqna_app/features/cart/presentation/screens/cart_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('سوقنا'),
        actions: [
          IconButton(
            // --- هذا هو التعديل الوحيد ---
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- شريط البحث ---
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'ابحث عن منتج أو متجر...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),

            // --- بانر العروض ---
            SizedBox(
              height: 150,
              child: PageView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        'https://picsum.photos/800/300?random=${index + 1}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // --- قسم الفئات ---
            const _SectionHeader(title: 'تصفح الفئات'),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  _CategoryIcon(title: 'أزياء', icon: Icons.checkroom),
                  _CategoryIcon(title: 'إلكترونيات', icon: Icons.electrical_services),
                  _CategoryIcon(title: 'سوبرماركت', icon: Icons.local_grocery_store),
                  _CategoryIcon(title: 'مطاعم', icon: Icons.restaurant),
                  _CategoryIcon(title: 'أخرى', icon: Icons.category),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // --- قسم "الأكثر شهرة" ---
            const _SectionHeader(title: 'المتاجر الأكثر شهرة'),
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) => _PopularStoreCard(index: index),
              ),
            ),
            const SizedBox(height: 24),

            // --- قسم "كل المتاجر" ---
            const _SectionHeader(title: 'كل المتاجر'),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) => _StoreListItem(index: index),
            ),
          ],
        ),
      ),
    );
  }
}

// --- ويدجتس مساعدة لتنظيف الكود ---

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _CategoryIcon extends StatelessWidget {
  final String title;
  final IconData icon;
  const _CategoryIcon({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.teal.withOpacity(0.1),
            child: Icon(icon, size: 30, color: Colors.teal),
          ),
          const SizedBox(height: 8),
          Text(title),
        ],
      ),
    );
  }
}

class _PopularStoreCard extends StatelessWidget {
  final int index;
  const _PopularStoreCard({required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const StoreDetailsScreen()),
        );
      },
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(left: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://picsum.photos/200/200?random=${index + 10}',
                height: 100,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            const Text('اسم المتجر', style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                Text((Random().nextDouble() * (5 - 3.5) + 3.5).toStringAsFixed(1)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// ويدجت لعنصر المتجر في القائمة العمودية (داخل بطاقة)
class _StoreListItem extends StatelessWidget {
  final int index;
  const _StoreListItem({required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const StoreDetailsScreen()),
        );
      },
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  'https://picsum.photos/200/200?random=${index + 20}',
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
                    const Text('اسم المتجر', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const Text('الفئة', style: TextStyle(color: Colors.grey)),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        Text((Random().nextDouble() * (5 - 3.5) + 3.5).toStringAsFixed(1)),
                        const SizedBox(width: 8),
                        const Icon(Icons.location_on, color: Colors.grey, size: 16),
                        Text('${(Random().nextDouble() * 10).toStringAsFixed(1)} كم'),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
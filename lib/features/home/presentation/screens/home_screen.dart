import 'package:flutter/material.dart';
import 'dart:math';
import 'package:souqna_app/features/store/presentation/screens/store_details_screen.dart';
import 'package:souqna_app/features/cart/presentation/screens/cart_screen.dart';
import 'package:provider/provider.dart';
import 'package:souqna_app/features/cart/data/cart_provider.dart';
import 'package:souqna_app/features/auth/presentation/screens/welcome_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// 1. حولنا الشاشة إلى StatefulWidget
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _userName;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // 2. نستدعي دالة جلب الاسم عند بدء الشاشة
    _fetchUserName();
  }

  // 3. دالة جديدة لجلب بيانات المستخدم من جدول profiles
  Future<void> _fetchUserName() async {
    // نتأكد أن الواجهة لا تزال موجودة قبل تحديث الحالة
    if (!mounted) return;

    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      try {
        final data = await Supabase.instance.client
            .from('profiles')
            .select('full_name')
            .eq('id', user.id)
            .single();
        if (mounted) {
          setState(() {
            _userName = data['full_name'];
            _isLoading = false;
          });
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } else {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final session = Supabase.instance.client.auth.currentSession;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // 4. عرض اسم المستخدم أو اسم التطبيق بناءً على حالة الدخول
        title: session == null
            ? const Text('سوقنا')
            : (_isLoading
                ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.0))
                : Text('أهلاً، ${_userName ?? ''}')),
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return Badge(
                isLabelVisible: cart.itemCount > 0,
                label: Text(cart.itemCount.toString()),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const CartScreen()),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart_outlined),
                ),
              );
            },
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
            // 5. عرض شريط الزائر لو المستخدم مش مسجل دخول
            if (session == null) const _GuestPrompt(),
            
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

// --- ويدجتس مساعدة ---

class _GuestPrompt extends StatelessWidget {
  const _GuestPrompt();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal.shade50,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const Icon(Icons.person_add_alt_1_outlined, color: Colors.teal),
          const SizedBox(width: 12),
          const Expanded(
            child: Text('سجل الآن واستمتع بكامل الميزات!', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const WelcomeScreen()));
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
            child: const Text('تسجيل'),
          )
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const StoreDetailsScreen()));
      },
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(left: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network('https://picsum.photos/200/200?random=${index + 10}', height: 100, width: 150, fit: BoxFit.cover),
            ),
            const SizedBox(height: 8),
            const Text('اسم المتجر', style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                Text((Random().nextDouble() * (5 - 3.5) + 3.5).toStringAsFixed(1)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StoreListItem extends StatelessWidget {
  final int index;
  const _StoreListItem({required this.index});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const StoreDetailsScreen()));
      },
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network('https://picsum.photos/200/200?random=${index + 20}', height: 80, width: 80, fit: BoxFit.cover),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
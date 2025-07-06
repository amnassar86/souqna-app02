import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. نستخدم DefaultTabController لإنشاء التبويبات
    return DefaultTabController(
      length: 2, // عدد التبويبات (حالية وسابقة)
      child: Scaffold(
        appBar: AppBar(
          // لإزالة زر الرجوع التلقائي
          automaticallyImplyLeading: false,
          title: const Text('طلباتي'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'طلبات حالية'),
              Tab(text: 'طلبات سابقة'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // 2. محتوى التبويب الأول: الطلبات الحالية
            _OrdersList(
              itemCount: 2, // عدد الطلبات الحالية الوهمية
              status: OrderStatus.processing,
            ),

            // 3. محتوى التبويب الثاني: الطلبات السابقة
            _OrdersList(
              itemCount: 5, // عدد الطلبات السابقة الوهمية
              status: OrderStatus.delivered,
            ),
          ],
        ),
      ),
    );
  }
}

// --- ويدجتس مساعدة ---

// enum لتحديد حالة الطلب
enum OrderStatus { processing, delivered, cancelled }

// ويدجت لعرض قائمة الطلبات
class _OrdersList extends StatelessWidget {
  final int itemCount;
  final OrderStatus status;

  const _OrdersList({required this.itemCount, required this.status});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, index) {
        // نغير حالة الطلب الأخير في القائمة السابقة ليكون "ملغي" للتنويع
        final currentStatus = (status == OrderStatus.delivered && index == itemCount - 1)
            ? OrderStatus.cancelled
            : status;
        return _OrderItemCard(status: currentStatus);
      },
    );
  }
}

// ويدجت لبطاقة الطلب
class _OrderItemCard extends StatelessWidget {
  final OrderStatus status;
  const _OrderItemCard({required this.status});

  // دالة لتحديد لون ونص حالة الطلب
  Map<String, dynamic> _getStatusInfo(OrderStatus status) {
    switch (status) {
      case OrderStatus.processing:
        return {'text': 'قيد التجهيز', 'color': Colors.orange};
      case OrderStatus.delivered:
        return {'text': 'تم التوصيل', 'color': Colors.green};
      case OrderStatus.cancelled:
        return {'text': 'ملغي', 'color': Colors.red};
      default:
        return {'text': '', 'color': Colors.grey};
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusInfo = _getStatusInfo(status);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'اسم المتجر',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                // حالة الطلب
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusInfo['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    statusInfo['text'],
                    style: TextStyle(color: statusInfo['color'], fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('رقم الطلب', style: TextStyle(color: Colors.grey)),
                Text('#123456', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('التاريخ', style: TextStyle(color: Colors.grey)),
                Text('05 يوليو 2024', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('الإجمالي', style: TextStyle(color: Colors.grey)),
                Text('475.00 ر.س', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class MyAddressesScreen extends StatelessWidget {
  const MyAddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // قائمة عناوين وهمية للتجربة
    final List<Map<String, String>> addresses = [
      {'label': 'المنزل', 'address': 'شارع الملك فهد، حي العليا، الرياض'},
      {'label': 'العمل', 'address': 'طريق الملك عبدالله، حي الواحة، الرياض'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('عناويني'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: addresses.length,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, index) {
          final item = addresses[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const Icon(Icons.location_on_outlined, color: Colors.teal),
              title: Text(item['label']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(item['address']!),
              trailing: IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  // لإظهار خيارات الحذف أو التعديل
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // لفتح شاشة إضافة عنوان جديد
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
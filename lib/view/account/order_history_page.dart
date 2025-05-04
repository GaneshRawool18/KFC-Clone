import 'package:flutter/material.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with the actual number of orders
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.fastfood),
            title: Text('Order #${index + 1}'),
            subtitle: const Text('Details of the order'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              // Handle order details navigation
            },
          );
        },
      ),
    );
  }
}
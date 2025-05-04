import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kfc_app/controller/cart_controller.dart';
import 'package:kfc_app/models/cart_item.dart';
import 'package:kfc_app/view/menu_page.dart';

class KfcCartScreen extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            children: [
              Icon(Icons.location_on, color: Colors.red),
              SizedBox(width: 5),
              Text('Giridhar Nag', style: TextStyle(color: Colors.black)),
              Icon(Icons.arrow_right, color: Colors.grey),
              SizedBox(width: 5),
              Text('ASAP', style: TextStyle(color: Colors.black54)),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined, color: Colors.black),
            onPressed: () {
              // You are already on the cart screen, so no need to navigate again.
              // You can add some other action here if needed.
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Already on Cart')),
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return _buildEmptyCart(height, width, context);
        } else {
          return _buildFilledCart(height, width, context);
        }
      }),
      bottomNavigationBar: Obx(() => cartController.cartItems.isEmpty
          ? SizedBox.shrink()
          : _buildCheckoutButton(height, width, context)),
    );
  }

  Widget _buildEmptyCart(double height, double width, BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          SizedBox(height: 20),
          Text(
            'Your cart is empty!',
            style: TextStyle(fontSize: 20, color: Colors.grey[600]),
          ),
          SizedBox(height: 10),
          Text(
            'Add some delicious items from the menu.',
            style: TextStyle(color: Colors.grey[500]),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              // Show a SnackBar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Going to Menu')),
              );

              // Navigate to the menu screen
              Get.to(() => KFCMenuScreen());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Text(
              'Browse Menu',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilledCart(double height, double width, BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: cartController.cartItems.length,
      itemBuilder: (context, index) {
        final CartItem item = cartController.cartItems[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(item.imageUrl),
                    ),
                  ),
                  child: item.imageUrl.isEmpty
                      ? Center(child: Text('No Image'))
                      : null,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text('₹${item.price.toStringAsFixed(2)}'),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () => cartController.decrement(index),
                          ),
                          Text('${item.quantity}'),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () => cartController.increment(index),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete_outline),
                  onPressed: () => cartController.removeItem(index),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCheckoutButton(
      double height, double width, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -1),
            blurRadius: 4,
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Obx(() => Text(
                    '₹${cartController.totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  )),
            ],
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement checkout functionality
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Proceeding to Checkout')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Text(
              'Proceed to Checkout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

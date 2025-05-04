import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kfc_app/controller/change_order_controller.dart';


class StartYourOrderPage extends StatelessWidget {
  final ChangeYourOrderController controller = Get.find<ChangeYourOrderController>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Start Your Order', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: screenHeight * 0.02),
                textStyle: TextStyle(fontSize: isSmallScreen ? 18 : 20),
              ),
              onPressed: () {
                controller.order.update((val) {
                  if (val != null) {
                    val.orderType = 'Delivery';
                  }
                });
                Get.back();
              },
              child: const Text('Delivery'),
            ),
            SizedBox(height: screenHeight * 0.03),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: screenHeight * 0.02),
                textStyle: TextStyle(fontSize: isSmallScreen ? 18 : 20),
              ),
              onPressed: () {
                controller.order.update((val) {
                  if (val != null) {
                    val.orderType = 'Pick Up';
                  }
                });
                Get.back();
              },
              child: const Text('Pick Up'),
            ),
            SizedBox(height: screenHeight * 0.03),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: screenHeight * 0.02),
                textStyle: TextStyle(fontSize: isSmallScreen ? 18 : 20),
              ),
              onPressed: () {
                controller.order.update((val) {
                  if (val != null) {
                    val.orderType = 'Dine In';
                  }
                });
                Get.back();
              },
              child: const Text('Dine In'),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kfc_app/controller/change_order_controller.dart';
import 'package:kfc_app/controller/order_provider.dart';

class ChangeYourOrderPage extends StatelessWidget {
  // Use Get.find() to get the controller that was already put in memory
  final OrderProvider orderProvider = Get.find<OrderProvider>();
  final ChangeYourOrderController controller = Get.find<ChangeYourOrderController>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'CHANGE YOUR ORDER',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ORDER TYPE',
              style: TextStyle(
                fontSize: isSmallScreen ? 16 : 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Obx(() => Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(controller.order.value.orderType),
                      TextButton(
                        onPressed: controller.changeOrderType,
                        child: const Text('Change'),
                      ),
                    ],
                  ),
                )),
            Divider(color: Colors.grey[300]),
            SizedBox(height: screenHeight * 0.02),
            Text(
              'DELIVERY ADDRESS',
              style: TextStyle(
                fontSize: isSmallScreen ? 16 : 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Obx(() => Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(controller.order.value.deliveryAddress)),
                      TextButton(
                        onPressed: () => controller.changeDeliveryAddress(context),
                        child: const Text('Change'),
                      ),
                    ],
                  ),
                )),
            Divider(color: Colors.grey[300]),
            SizedBox(height: screenHeight * 0.02),
            Text(
              'DELIVERY TIME',
              style: TextStyle(
                fontSize: isSmallScreen ? 16 : 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Date'),
                  Obx(() => Text(DateFormat('EEE, MMM d, y').format(controller.selectedDate.value))),
                  TextButton(
                    onPressed: () => controller.changeDeliveryDate(context),
                    child: const Text('Change'),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey[300]),
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Time'),
                  Obx(() => InkWell(
                        onTap: () {
                          Get.bottomSheet(
                            Container(
                              color: Colors.black,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller.deliveryTimeOptions.length,
                                itemBuilder: (context, index) {
                                  final time = controller.deliveryTimeOptions[index];
                                  return ListTile(
                                    title: Text(time, style: const TextStyle(color: Colors.white)),
                                    onTap: () {
                                      controller.changeDeliveryTime(time);
                                      Get.back();
                                    },
                                  );
                                },
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Text(controller.order.value.deliveryTime),
                            const Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      )),
                  const SizedBox(width: 80), // To align with 'Change' button
                ],
              ),
            ),
            Divider(color: Colors.grey[300]),
            SizedBox(height: screenHeight * 0.04),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.startOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black87,
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  textStyle: TextStyle(
                    fontSize: isSmallScreen ? 18 : 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Start Order'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

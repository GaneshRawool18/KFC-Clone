// change_your_order_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kfc_app/controller/address_provider.dart';
import 'package:kfc_app/controller/order_provider.dart';
import 'package:kfc_app/models/order_model.dart';
import 'package:kfc_app/view/more/find_kfc_page.dart';

class ChangeYourOrderController extends GetxController {
  final orderProvider = Get.find<OrderProvider>();
  final addressProvider = Get.find<AddressProvider>();

  // Define the order as an observable
  final order = Order(
    userId: '',
    items: [],
    totalPrice: 0.0,
    orderDate: DateTime.now(),
    deliveryAddress: '',
    orderStatus: 'Pending',
    orderType: 'Delivery',
    deliveryTime: 'As soon as possible',
  ).obs;

  final selectedDate = Rx<DateTime>(DateTime.now());
  final deliveryTimeOptions = ['As soon as possible', '7:00 PM', '7:30 PM', '8:00 PM'];

  @override
  void onInit() {
    super.onInit();
    if (addressProvider.selectedAddress != null) {
      order.update((val) {
        if (val != null) {
          val.deliveryAddress = addressProvider.selectedAddress!;
        }
      });
    }
  }

  void changeOrderType() {
    final newType = order.value.orderType == 'Delivery' ? 'Pick-up' : 'Delivery';
    order.update((val) {
      if (val != null) {
        val.orderType = newType;
        if (newType == 'Pick-up') {
          val.deliveryAddress = '';
          addressProvider.clearSelectedAddress();
        }
      }
    });
  }

  void changeDeliveryAddress(BuildContext context) async {
    await Get.to(() => FindAKfc());
  }

  void changeDeliveryDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
    }
  }

  void changeDeliveryTime(String time) {
    order.update((val) {
      if (val != null) {
        val.deliveryTime = time;
      }
    });
  }

  void startOrder() {
    print('Starting order: ${order.value.toMap()}');
    orderProvider.saveOrder(order.value);
  }
}

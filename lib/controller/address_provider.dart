// address_provider.dart

import 'package:get/get.dart';

class AddressProvider extends GetxController {
  String? selectedAddress;

  void setSelectedAddress(String address) {
    selectedAddress = address;
  }

  void clearSelectedAddress() {
    selectedAddress = null;
  }
}

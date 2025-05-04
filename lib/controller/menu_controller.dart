import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:kfc_app/models/menu_item.dart';

class FoodMenuController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  RxList<MenuItemModel> menuItems = <MenuItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMenuItems();
  }

  void fetchMenuItems() async {
    try {
      final snapshot = await _db.collection('menus').get();
      List<MenuItemModel> fetchedItems = [];

      for (var doc in snapshot.docs) {
        print('Fetched item: ${doc.data()}'); // Debugging log

        String imagePath = doc.data()['imageUrl'];
        String imageUrl = '';
        if (imagePath != null && imagePath.isNotEmpty) {
          imageUrl = await _getImageUrl(imagePath);
        }
        print('Image URL for $imagePath: $imageUrl'); // Debugging log

        var menuItem = MenuItemModel.fromMap(doc.data(), doc.id);
        menuItem.imageUrl = imageUrl; // Assign the fetched HTTP/HTTPS URL

        fetchedItems.add(menuItem);
      }

      menuItems.value = fetchedItems;
      menuItems.refresh(); // Trigger UI update
    } catch (e) {
      print('Error fetching menu items: $e');
    }
  }

  Future<String> _getImageUrl(String imagePath) async {
    try {
      String imageUrl = await _storage.ref(imagePath).getDownloadURL();
      print('Successfully fetched image URL for $imagePath: $imageUrl');
      return imageUrl;
    } catch (e) {
      print("Error getting image URL for path: $imagePath - Type: ${e.runtimeType}, Details: $e");
      return ''; // Or a placeholder URL
    }
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:kfc_app/models/cart_item.dart';
import '../models/menu_item.dart';

class CartController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var cartItems = <CartItem>[].obs;

  String? get userId => _auth.currentUser?.uid;

  @override
  void onInit() {
    super.onInit();
    if (userId != null) {
      loadCartFromFirebase(userId!);
    }

    _auth.authStateChanges().listen((User? user) {
      cartItems.clear();
      if (user != null) {
        loadCartFromFirebase(user.uid);
      }
    });
  }

  void addToCart(MenuItemModel item) {
    if (userId == null) {
      print('User not logged in. Cannot add to cart.');
      return;
    }

    int index = cartItems.indexWhere((i) => i.itemId == item.id);
    if (index != -1) {
      cartItems[index].quantity++;
    } else {
      cartItems.add(
        CartItem(
          itemId: item.id,
          name: item.title,
          price: item.price,
          imageUrl: item.imageUrl,
          quantity: 1,
        ),
      );
    }
    cartItems.refresh();
    saveCartToFirebase();
  }

  void increment(int index) {
    if (userId == null) return;
    cartItems[index].quantity++;
    cartItems.refresh();
    saveCartToFirebase();
  }

  void decrement(int index) {
    if (userId == null) return;
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
      cartItems.refresh();
      saveCartToFirebase();
    }
  }

  void removeItem(int index) {
    if (userId == null) return;
    cartItems.removeAt(index);
    saveCartToFirebase();
  }

  double get totalPrice =>
      cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));

  Future<void> saveCartToFirebase() async {
    if (userId != null) {
      try {
        final cartData = cartItems.map((item) => item.toJson()).toList();
        await _db.collection('carts').doc(userId).set({'items': cartData});
      } catch (e) {
        print('Error saving cart to Firebase: $e');
      }
    }
  }

  Future<void> loadCartFromFirebase(String userId) async {
    try {
      final doc = await _db.collection('carts').doc(userId).get();
      final data = doc.data();
      if (data != null && data['items'] is List) {
        final cartData = (data['items'] as List)
            .map((item) => CartItem.fromJson(Map<String, dynamic>.from(item)))
            .toList();
        cartItems.value = cartData;
      } else {
        cartItems.value = [];
      }
    } catch (e) {
      print('Error loading cart from Firebase: $e');
    }
  }
}

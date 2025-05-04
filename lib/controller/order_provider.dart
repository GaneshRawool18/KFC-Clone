import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/order_model.dart' as app_models; // Ensure this import path is correct

class OrderProvider extends GetConnect {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'orders';

  Future<void> saveOrder(app_models.Order order) async {
    try {
      await _firestore.collection(_collection).add(order.toMap());
      // Optionally return the document ID or handle success
    } catch (error) {
      // Handle error (e.g., log, throw custom exception)
      print('Error saving order: $error');
      rethrow;
    }
  }

  Future<app_models.Order?> getOrder(String orderId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection(_collection).doc(orderId).get();
      if (snapshot.exists && snapshot.data() != null) {
        return app_models.Order.fromMap(snapshot.data()!);
      }
      return null;
    } catch (error) {
      print('Error getting order: $error');
      return null;
    }
  }

  // Add other methods for fetching, updating, deleting orders as needed
}
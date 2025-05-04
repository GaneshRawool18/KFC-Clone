import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:kfc_app/models/user_account.dart';

class DatabaseService extends GetxService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get userId => _auth.currentUser?.uid;

  Future<UserAccount?> getUserAccount() async {
    if (userId == null) return null;
    try {
      DocumentSnapshot<Map<String, dynamic>> doc =
          await _db.collection('users').doc(userId).get();
      if (doc.exists && doc.data() != null) {
        return UserAccount.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      print('Error fetching user account: $e');
      return null;
    }
  }

  Future<void> saveUserAccount(UserAccount userAccount) async {
    if (userId == null) return;
    try {
      await _db.collection('users').doc(userId).set(userAccount.toJson(), SetOptions(merge: true));
      print('User account saved successfully for user: $userId');
    } catch (e) {
      print('Error saving user account: $e');
    }
  }

  // --- Admin Functions ---

  Future<List<UserAccount>> getAllUsers() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await _db.collection('users').get();
      return snapshot.docs.map((doc) => UserAccount.fromJson(doc.data()!)).toList();
    } catch (e) {
      print('Error fetching all users: $e');
      return [];
    }
  }

  Future<void> deleteUserAccountByAdmin(String uid) async {
    try {
      await _db.collection('users').doc(uid).delete();
      print('User account deleted successfully for UID: $uid');
      // You might also need to delete the associated Firebase Auth user
      // using Firebase Admin SDK from your backend.
    } catch (e) {
      print('Error deleting user account: $e');
    }
  }

  Future<void> updateUserAccountByAdmin(UserAccount updatedUser) async {
    try {
      await _db.collection('users').doc(updatedUser.uid).update(updatedUser.toJson());
      print('User account updated successfully for UID: ${updatedUser.uid}');
    } catch (e) {
      print('Error updating user account: $e');
    }
  }
}
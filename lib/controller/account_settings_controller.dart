import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kfc_app/controller/firestore_service.dart';
import 'package:kfc_app/models/user_account.dart';

class AccountSettingsController extends GetxController {
  final DatabaseService _databaseService = Get.find<DatabaseService>();
  final userAccount = Rx<UserAccount>(UserAccount(name: '', email: ''));

  var receiveKfcNews = false.obs;
  var receiveMarketingEmails = false.obs;
  var receiveSms = false.obs;

  // --- Admin Functionality ---
  var allUsers = <UserAccount>[].obs;
  var isLoadingUsers = false.obs;
  var isAdmin = false.obs; // Observable to track admin status

  @override
  void onInit() {
    super.onInit();
    loadAccountDetails();
    checkAdminStatus();
  }

  Future<void> loadAccountDetails() async {
    UserAccount? account = await _databaseService.getUserAccount();
    if (account != null) {
      userAccount.value = account;
      receiveKfcNews.value = account.receiveKfcNews ?? false;
      receiveMarketingEmails.value = account.receiveMarketingEmails ?? false;
      receiveSms.value = account.receiveSms ?? false;
    }
  }

  Future<void> saveChanges() async {
    userAccount.update((val) {
      if (val != null) {
        val.receiveKfcNews = receiveKfcNews.value;
        val.receiveMarketingEmails = receiveMarketingEmails.value;
        val.receiveSms = receiveSms.value;
      }
    });

    await _databaseService.saveUserAccount(userAccount.value);
    Get.snackbar("Success", "Account details updated successfully!",
        backgroundColor: Colors.green);
  }

  Future<void> deleteAccount() async {
    print("Deleting current user account (Firebase Auth and data deletion)");
    // Implement actual deletion logic for the current user.
  }

  void updateName(String name) {
    userAccount.update((val) {
      if (val != null) {
        val.name = name;
      }
    });
  }

  void updateEmail(String email) {
    userAccount.update((val) {
      if (val != null) {
        val.email = email;
      }
    });
  }

  void updateMobile(String? mobile) {
    userAccount.update((val) {
      if (val != null) {
        val.mobileNumber = mobile;
      }
    });
  }

  // --- Admin Functions ---

  Future<void> checkAdminStatus() async {
    // Implement your logic to determine if the current user is an admin.
    // This could involve checking a specific claim in their Firebase ID token,
    // or checking a field in their user document in Firestore.
    // Example (using email domain):
    isAdmin.value = _databaseService.userId?.endsWith("@kfcadmin.com") ?? false;
    if (isAdmin.value) {
      loadAllUsers();
    }
  }

  Future<void> loadAllUsers() async {
    if (!isAdmin.value) return;
    try {
      isLoadingUsers.value = true;
      List<UserAccount> users = await _databaseService.getAllUsers();
      allUsers.value = users;
    } catch (e) {
      print('Error loading all users: $e');
      Get.snackbar("Error", "Failed to load users.",
          backgroundColor: Colors.red);
    } finally {
      isLoadingUsers.value = false;
    }
  }

  Future<void> deleteUser(String uid) async {
    if (!isAdmin.value) return;
    try {
      await _databaseService.deleteUserAccountByAdmin(uid);
      allUsers.removeWhere((user) => user.uid == uid);
      Get.snackbar("Success", "User deleted successfully!",
          backgroundColor: Colors.green);
    } catch (e) {
      print('Error deleting user: $e');
      Get.snackbar("Error", "Failed to delete user.",
          backgroundColor: Colors.red);
    }
  }

  Future<void> editUser(UserAccount updatedUser) async {
    if (!isAdmin.value) return;
    try {
      await _databaseService.updateUserAccountByAdmin(updatedUser);
      final index = allUsers.indexWhere((user) => user.uid == updatedUser.uid);
      if (index != -1) {
        allUsers[index] = updatedUser;
        allUsers.refresh();
      }
      Get.snackbar("Success", "User details updated!",
          backgroundColor: Colors.green);
    } catch (e) {
      print('Error editing user: $e');
      Get.snackbar("Error", "Failed to update user details.",
          backgroundColor: Colors.red);
    }
  }
}

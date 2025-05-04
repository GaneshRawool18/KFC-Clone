import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kfc_app/controller/account_settings_controller.dart';

class AccountSettingsPage extends StatelessWidget {
  final AccountSettingsController controller = Get.put(AccountSettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, 
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), 
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "ACCOUNT SETTINGS",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold), 
        ),
        centerTitle: true, 
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "ACCOUNT SETTINGS",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "PERSONAL INFO",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                TextButton(
                  onPressed: () => _showEditBottomSheet(context),
                  style: TextButton.styleFrom(foregroundColor: Colors.black), // Black edit button text
                  child: const Text("Edit"),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            _buildInfoRow("Name", controller.userAccount.value.name),
            _buildInfoRow("Email Address", controller.userAccount.value.email),
            _buildInfoRow("Mobile Number", controller.userAccount.value.mobileNumber ?? 'N/A'),
            const SizedBox(height: 24.0),
            const Text(
              "COMMUNICATION PREFERENCES",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            Obx(
              () => CheckboxListTile(
                title: const Text("KFC news and announcements"),
                subtitle: const Text(
                  "Get occasional emails about site improvements or changes",
                  style: TextStyle(fontSize: 12.0, color: Colors.grey),
                ),
                value: controller.receiveKfcNews.value,
                onChanged: (bool? value) => controller.receiveKfcNews.value = value!,
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero, // Remove default padding
              ),
            ),
            Obx(
              () => CheckboxListTile(
                title: const Text("Keep me up to date with marketing emails from KFC"),
                value: controller.receiveMarketingEmails.value,
                onChanged: (bool? value) => controller.receiveMarketingEmails.value = value!,
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
            ),
            Obx(
              () => CheckboxListTile(
                title: const Text("Receive SMS"),
                value: controller.receiveSms.value,
                onChanged: (bool? value) => controller.receiveSms.value = value!,
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
            ),
            const SizedBox(height: 32.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Black save button
                  padding: const EdgeInsets.symmetric(vertical: 14.0), // Adjust padding
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // Slightly less rounded
                ),
                child: const Text("Save", style: TextStyle(color: Colors.white, fontSize: 16)), // White text
              ),
            ),
            const SizedBox(height: 12.0),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => _showDeleteDialog(context),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.black), // Black border
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  foregroundColor: Colors.black, // Black text
                ),
                child: const Text("Delete Account", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.grey, fontSize: 14.0), // Grey label text
          ),
          const SizedBox(height: 4.0),
          Text(
            value,
            style: const TextStyle(fontSize: 16.0, color: Colors.black), // Black value text
          ),
          const Divider(color: Colors.grey, height: 16), // Add a divider
        ],
      ),
    );
  }

  void _showEditBottomSheet(BuildContext context) {
    final nameController = TextEditingController(text: controller.userAccount.value.name);
    final emailController = TextEditingController(text: controller.userAccount.value.email);
    final mobileController = TextEditingController(text: controller.userAccount.value.mobileNumber);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Make it scrollable if content is large
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext bc) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Edit Personal Info", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 16),
              TextField(controller: nameController, decoration: const InputDecoration(labelText: "Name")),
              TextField(controller: emailController, decoration: const InputDecoration(labelText: "Email Address")),
              TextField(controller: mobileController, decoration: const InputDecoration(labelText: "Mobile Number")),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.updateName(nameController.text);
                    controller.updateEmail(emailController.text);
                    controller.updateMobile(mobileController.text);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: const Text("Save", style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirm Deletion"),
        content: const Text("Are you sure you want to delete your account?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("No", style: TextStyle(color: Colors.black))),
          TextButton(
            onPressed: () {
              controller.deleteAccount();
              Get.offAllNamed("/login"); // Adjust route as needed
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }
}
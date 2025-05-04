import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kfc_app/controller/auth_controller.dart';
import 'package:kfc_app/view/more/CautionNoticePage.dart';
import 'package:kfc_app/view/more/DisclaimerPage.dart';
import 'package:kfc_app/view/more/NutritionAllergenPage.dart';
import 'package:kfc_app/view/more/PrivacyPolicyPage.dart';
import 'package:kfc_app/view/more/TermsAndConditionsPage.dart';
import 'package:kfc_app/view/more/find_kfc_page.dart';
import 'package:kfc_app/view/more/offer_page.dart';
import 'get_help_page.dart'; // Import your GetHelpPage
import 'order_lookup_page.dart'; // Import your OrderLookupPage
import 'gift_card_page.dart'; // Import your GiftCardPage

class MorePage extends StatelessWidget {
  final List<Map<String, dynamic>> menuItems = [
    {'title': 'GET HELP', 'route': (context) => GetHelpPage()},
    {'title': 'OFFERS & DEALS', 'route': (context) => OffersPage()},
    {'title': 'ORDER LOOKUP', 'route': (context) => OrderLookupPage()},
    {'title': 'GIFT CARDS', 'route': (context) => GiftCardPage()},
    {'title': 'FIND A KFC', 'route': (context) => FindAKfc()},
    {
      'title': 'NUTRITION & ALLERGEN',
      'route': (context) =>
          const NutritionAllergenPage(), // Use the page you've created
    },
    {
      'title': 'KFC INDIA',
      'route': null, // No direct navigation, it's a dropdown menu
    },
    {
      'title': 'Terms and Conditions',
      'route': (context) => const TermsAndConditionsPage()
    },
    {
      'title': 'Privacy Policy',
      'route': (context) => const PrivacyPolicyPage()
    },
    {'title': 'Disclaimer', 'route': (context) => const DisclaimerPage()},
    {
      'title': 'Caution Notice',
      'route': (context) => const CautionNoticePage()
    },
  ];

  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OutlinedButton(
              onPressed: () {
                authController.logout();
                log('Sign Out');
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.black),
              ),
              child:
                  const Text('Sign Out', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
      body: ListView.separated(
        itemCount: menuItems.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return ListTile(
            title: Text(
              item['title'],
              style: TextStyle(
                fontWeight: index < 7 ? FontWeight.bold : FontWeight.normal,
                fontSize: width > 600 ? 22 : 16,
              ),
            ),
            trailing: item['hasDropdown'] == true
                ? const Icon(Icons.arrow_drop_down)
                : null,
            onTap: () {
              if (item['route'] != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: item['route']),
                );
              } else if (item['title'] == 'KFC INDIA') {
                // TODO: Implement dropdown or further navigation for KFC India
                log('KFC India tapped - implement dropdown or navigation');
                // You might want to show a modal sheet or expand this list item.
              } else {
                // Handle taps for items without a defined route (placeholders)
                log('${item['title']} tapped - no navigation defined yet');
              }
            },
          );
        },
      ),
    );
  }
}

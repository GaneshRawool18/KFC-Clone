import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kfc_app/view/account/fav_menu_page.dart';
import 'package:kfc_app/view/account/restaurant_address.dart';

// Import the placeholder pages (adjust import paths as needed)
import 'messages_page.dart';
import 'order_history_page.dart';

import 'account_settings_page.dart';

class AccountApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AccountPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AccountPage extends StatelessWidget {
  final List<Map<String, dynamic>> menuItems = [
    {
      'title': 'Messages',
      'icon': Icons.message,
      'notification': true,
      'route': (context) => MessagesPage()
    },
    {
      'title': 'Order History',
      'icon': Icons.history,
      'route': (context) => OrderHistoryPage()
    },
    {
      'title': 'My Favorite Menu',
      'icon': Icons.favorite_border,
      'route': (context) => MyFavoriteMenuPage()
    },
    {
      'title': 'My Restaurants & Addresses',
      'icon': Icons.location_on,
      'route': (context) => MyRestaurantsAddressesPage()
    },
    {
      'title': 'Account Settings',
      'icon': Icons.settings,
      'route': (context) => AccountSettingsPage()
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Container(
            padding: EdgeInsets.all(16),
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("DELIVERY", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.location_pin, color: Colors.red),
                    Text("Giridhar Nag_",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    Icon(Icons.arrow_right),
                    Text("ASAP"),
                    Spacer(),
                    TextButton(
                      onPressed: () {},
                      child:
                          Text("Change", style: TextStyle(color: Colors.black)),
                      style: TextButton.styleFrom(
                        side: BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  child:
                      Text("Sign Out", style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: ListView.separated(
              itemCount: menuItems.length,
              separatorBuilder: (_, __) => Divider(),
              itemBuilder: (context, index) {
                var item = menuItems[index];
                return ListTile(
                  leading: Icon(item['icon']),
                  title: Row(
                    children: [
                      Text(item['title']),
                      if (item['notification'] == true)
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          padding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text('0',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12)),
                        ),
                    ],
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: item['route']),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

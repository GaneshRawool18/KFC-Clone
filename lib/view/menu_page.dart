import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kfc_app/controller/cart_controller.dart';
import 'package:kfc_app/controller/menu_controller.dart';
import 'package:kfc_app/view/order/change_your_order_page.dart';

class KFCMenuScreen extends StatefulWidget {
  @override
  State<KFCMenuScreen> createState() => _KFCMenuScreenState();
}

class _KFCMenuScreenState extends State<KFCMenuScreen> {
  final List<String> categories = [
    "New Chicken Rolls",
    "Match Day Combos",
    // "Box Meals",
    // "Chicken Buckets",
    // "Burgers",
    // "Peri Peri Chicken",
    // "Snacks",
    // "Double Down Burger",
    // "Rice Bowl",
    // "Beverages"
  ];

  int selectedIndex = 0;

  final FoodMenuController _menuController = Get.find();
  final CartController _cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.location_on, color: Colors.red),
            SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('DELIVERY',
                    style: TextStyle(fontSize: 12, color: Colors.black)),
                Text('Giridhar Nag_',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            Spacer(),
            TextButton(
                onPressed: () {
                  Get.to(() => ChangeYourOrderPage());
                },
                child: Text('Change'))
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Horizontal Category Tabs
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length + 1,
              padding: EdgeInsets.symmetric(horizontal: 10),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.search, color: Colors.black),
                    ),
                  );
                }

                final actualIndex = index - 1;
                final isSelected = selectedIndex == actualIndex;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = actualIndex;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          categories[actualIndex],
                          style: TextStyle(
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isSelected ? Colors.black : Colors.grey,
                          ),
                        ),
                        SizedBox(height: 5),
                        if (isSelected)
                          Container(
                            width: 30,
                            height: 3,
                            color: Colors.black,
                          )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Category Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Text(
              categories[selectedIndex].toUpperCase(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),

          // Product List
          Expanded(
            child: Obx(() {
              final filteredItems = _menuController.menuItems
                  .where((item) => item.category == categories[selectedIndex])
                  .toList();
              if (filteredItems.isEmpty) {
                return Center(child: Text("No items found"));
              }

              return ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Top Row: Title & Image
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  item.title,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              // ... other imports

                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  item.imageUrl.isNotEmpty
                                      ? item.imageUrl
                                      : 'https://via.placeholder.com/100x80?Text=No+Image', // Placeholder if URL is empty
                                  width: 100,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    print(
                                        "Error loading image for ${item.title}: $error");
                                    return SizedBox(
                                      width: 100,
                                      height: 80,
                                      child:
                                          Center(child: Text('Image\nFailed')),
                                    );
                                  },
                                ),
                              ),

// ... rest of your KFCMenuScreen code
                            ],
                          ),
                          SizedBox(height: 10),

                          // Description & Favorite Icon
                          Text(
                            item.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 10),

                          // Price & Veg/Non-Veg
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '₹${item.price.toStringAsFixed(2)}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(Icons.circle,
                                      size: 14,
                                      color: item.isVeg
                                          ? Colors.green
                                          : Colors.red),
                                  Text(item.isVeg ? " Veg" : " Non-Veg"),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),

                          // Add to cart
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              _cartController
                                  .addToCart(item); // Add to cart here
                            },
                            icon: Icon(Icons.add, size: 16),
                            label: Text('Add to cart'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

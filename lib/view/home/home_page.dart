import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kfc_app/controller/storage_service.dart';
import 'package:kfc_app/view/menu_page.dart';
import 'package:kfc_app/view/order/change_your_order_page.dart';

class HomePage extends StatelessWidget {
  final StorageService _storageService = StorageService();

  Widget _buildOfferCard(
    BuildContext context,
    String title,
    String imageName,
    String offerDescription,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.7;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: SizedBox(
        width: cardWidth,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: FutureBuilder<String?>(
                  future: _storageService.getOfferImageUrl(imageName),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox(
                        height: 160,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    if (snapshot.hasError || snapshot.data == null) {
                      return const SizedBox(
                        height: 160,
                        child: Center(child: Text('Failed to load image')),
                      );
                    }
                    return Image.network(
                      snapshot.data!,
                      width: double.infinity,
                      height: 160,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.045,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      offerDescription,
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        color: Colors.grey[700],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 80),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Get.to(() => KFCMenuScreen());
                      },
                      child: const Text('Apply Offer'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String title, String imageName) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: FutureBuilder<String?>(
              future: _storageService.getCategoryImageUrl(imageName),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    width: 80,
                    height: 80,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (snapshot.hasError || snapshot.data == null) {
                  return const SizedBox(
                    width: 80,
                    height: 80,
                    child: Center(child: Icon(Icons.image_not_supported)),
                  );
                }
                return Image.network(
                  snapshot.data!,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          const SizedBox(height: 4),
          Text(title),
        ],
      ),
    );
  }

  Widget _buildPopularItemCard(String imageName) {
    return GestureDetector(
      onTap: () {
        Get.to(() => KFCMenuScreen()); // Navigate to MenuPage on tap
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: FutureBuilder<String?>(
            future: _storageService.getImageUrl(imageName),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  width: double.infinity,
                  height: 120,
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (snapshot.hasError || snapshot.data == null) {
                return const SizedBox(
                  width: double.infinity,
                  height: 120,
                  child: Center(child: Text('Failed to load image')),
                );
              }
              return Image.network(
                snapshot.data!,
                width: double.infinity,
                height: 120,
                fit: BoxFit.cover,
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.height * 0.03),
                child: Row(
                  children: [
                    Icon(Icons.location_pin, color: Colors.red),
                    Text("Giridhar Nag_",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    Icon(Icons.arrow_right),
                    Text("ASAP"),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        Get.to(() => ChangeYourOrderPage());
                      },
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
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Exclusive Offers for You',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Row(
                          children: [
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.05),
                            Text(
                              'View Offer',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.red,
                              size: MediaQuery.of(context).size.width * 0.05,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10),

              // Horizontal Offers List
              SizedBox(
                width: double.infinity,
                height: 400,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return _buildOfferCard(
                      context,
                      'Offer ${index + 1}',
                      'item_${index + 1}.jpg',
                      'Save ${(index + 1) * 10}% on your next purchase!',
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCategoryCard('Chicken', 'item_2.jpg'),
                    _buildCategoryCard('Burgers', 'item_1.jpg'),
                    _buildCategoryCard('Peri-peri', 'item_3.jpg'),
                    _buildCategoryCard('Drinks', 'item_4.jpg'),
                  ],
                ),
              ),

              SizedBox(height: 16),

              // Popular Items
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Popular Items',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),

              // GridView inside a fixed container
              LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;

                  return GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 1 / 1,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return _buildPopularItemCard('item${index + 1}.jpg');
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

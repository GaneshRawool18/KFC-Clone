import 'package:flutter/material.dart';

class OffersPage extends StatelessWidget {
  final List<Map<String, String>> offerData = [
    {
      'title': 'Offer 1',
      'imagePath': 'assets/images/item_1.jpg',
      'offerDescription': 'Save 10% on your next purchase!',
    },
    {
      'title': 'Offer 2',
      'imagePath': 'assets/images/item_2.jpg',
      'offerDescription': 'Save 20% on selected items!',
    },
    {
      'title': 'Offer 3',
      'imagePath': 'assets/images/item_3.jpg',
      'offerDescription': 'Get a free drink with your order!',
    },
    {
      'title': 'Offer 4',
      'imagePath': 'assets/images/item_4.jpg',
      'offerDescription': 'Save 40% on family meals!',
    },
    {
      'title': 'Offer 5',
      'imagePath': 'assets/images/item_5.jpg',
      'offerDescription': 'Save 50% on your first order!',
    },
    {
      'title': 'Offer 6',
      'imagePath': 'assets/images/item_6.jpg',
      'offerDescription': 'Save 60% on desserts!',
    },
    // Add more offer data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offers'),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.982,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: offerData.length,
            itemBuilder: (context, index) {
              final offer = offerData[index];
              return _buildOfferCard(
                context,
                offer['title']!,
                offer['imagePath']!,
                offer['offerDescription']!,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildOfferCard(
    BuildContext context,
    String title,
    String imagePath,
    String offerDescription,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.9; // 90% of screen width for vertical

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0), // Add spacing between cards
      child: SizedBox(
        width: cardWidth,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4, // Reduced elevation for vertical scrolling
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch, // Make children take full width
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: 200, // Adjusted height for vertical
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.05,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      offerDescription,
                      style: TextStyle(
                        fontSize: screenWidth * 0.038,
                        color: Colors.grey[700],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        // TODO: Handle Apply Offer
                        print('Apply Offer for $title');
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
}

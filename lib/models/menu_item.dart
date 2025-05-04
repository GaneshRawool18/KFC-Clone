class MenuItemModel {
  final String id;
  final String title;
  final String description;
  final double price;
  String imageUrl; // Changed to non-final to allow updating
  final String category;
  final bool isVeg;
  final bool isBestseller;

  MenuItemModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.isVeg,
    required this.isBestseller,
  });

  factory MenuItemModel.fromMap(Map<String, dynamic> data, String docId) {
    return MenuItemModel(
      id: docId,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] is num
          ? (data['price'] as num).toDouble()
          : 0.0), // Default to 0.0 if not a number or null
      imageUrl: data['imageUrl'] ?? '',
      category: data['category'] ?? '',
      isVeg: data['isVeg'] ?? false,
      isBestseller: data['isBestseller'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'isVeg': isVeg,
      'isBestseller': isBestseller,
    };
  }
}

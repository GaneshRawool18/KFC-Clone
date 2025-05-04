// cart_item.dart

class CartItem {
  final String itemId;
  final String name;
  final double price;
  final String imageUrl;
  int quantity;

  CartItem({
    required this.itemId,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.quantity,
  });

  // Rename to match service file usage
  Map<String, dynamic> toJson() {
    return {
      'itemId': itemId,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      itemId: json['itemId'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      imageUrl: json['imageUrl'] ?? '',
      quantity: json['quantity'] ?? 1,
    );
  }
}

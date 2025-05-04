class Order {
  final String userId;
  final List<String> items;
  final double totalPrice;
  DateTime orderDate;
  String deliveryAddress;
  String orderStatus;
  String orderType;
  String deliveryTime;

  Order({
    required this.userId,
    required this.items,
    required this.totalPrice,
    required this.orderDate,
    required this.deliveryAddress,
    required this.orderStatus,
    required this.orderType,
    required this.deliveryTime,
  });

  // Convert Order to Map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'items': items,
      'totalPrice': totalPrice,
      'orderDate': orderDate.toIso8601String(),
      'deliveryAddress': deliveryAddress,
      'orderStatus': orderStatus,
      'orderType': orderType,
      'deliveryTime': deliveryTime,
    };
  }

  // Convert Map to Order
  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      userId: map['userId'],
      items: List<String>.from(map['items']),
      totalPrice: map['totalPrice'],
      orderDate: DateTime.parse(map['orderDate']),
      deliveryAddress: map['deliveryAddress'],
      orderStatus: map['orderStatus'],
      orderType: map['orderType'],
      deliveryTime: map['deliveryTime'],
    );
  }
}

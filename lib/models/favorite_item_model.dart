class FavoriteItem {
  String itemId;
  String name;
  String imageUrl;

  FavoriteItem({required this.itemId, required this.name, required this.imageUrl});

  factory FavoriteItem.fromJson(Map<String, dynamic> json) {
    return FavoriteItem(
      itemId: json['itemId'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemId': itemId,
      'name': name,
      'imageUrl': imageUrl,
    };
  }
}
// product.dart
class Product {
  String id;
  String name;
  double price;
  String category;
  bool inStock;
  double rating;
  DateTime dateAdded;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.inStock,
    required this.rating,
    required this.dateAdded,
  });
}

// this is lib/models/product_model.dart
class ProductModel {
  final String id;
  final String name;
  final double price;
  final String? description;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    this.description,
  });

  // Factory method to create a ProductModel from a Map
  factory ProductModel.fromMap(Map<String, dynamic> data) {
    return ProductModel(
      id: data['id'],
      name: data['name'],
      price: (data['price'] as num).toDouble(), // Ensure price is a double
      description: data['description'],
    );
  }

  // Optionally, add a toMap method for converting back to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
    };
  }
}

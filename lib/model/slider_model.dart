import 'package:test_zybo/model/product.dart';

class SliderModel {
  int id;
  Product product;
  String name;
  String image;
  int showingOrder;
  bool isActive;

  SliderModel({
    required this.id,
    required this.product,
    required this.name,
    required this.image,
    required this.showingOrder,
    required this.isActive,
  });

  // From JSON
  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      id: json['id'] ?? 0, // Provide default value if null
      product: Product.fromJson(json['product'] ?? {}), // Handle null product
      name: json['name'] ?? '', // Provide default value if null
      image: json['image'] ?? '', // Provide default value if null
      showingOrder: json['showing_order'] ?? 0, // Provide default value if null
      isActive: json['is_active'] ?? false, // Provide default value if null
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product.toJson(),
      'name': name,
      'image': image,
      'showing_order': showingOrder,
      'is_active': isActive,
    };
  }
}


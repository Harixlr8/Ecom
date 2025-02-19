class Product {
  final int id;
  final List<dynamic> variations;
  final bool inWishlist;
  final double avgRating;
  final List<String> images;
  final bool variationExists;
  final double salePrice;
  final List<Addon> addons;
  final bool available;
  final String availableFrom;
  final String availableTo;
  final String name;
  final String description;
  final String caption;
  final String featuredImage;
  final double mrp;
  final int stock;
  final bool isActive;
  final String discount;
  final String createdDate;
  final String productType;
  final int? showingOrder;
  final String variationName;
  final int category;
  final double taxRate;

  Product({
    required this.id,
    required this.variations,
    required this.inWishlist,
    required this.avgRating,
    required this.images,
    required this.variationExists,
    required this.salePrice,
    required this.addons,
    required this.available,
    required this.availableFrom,
    required this.availableTo,
    required this.name,
    required this.description,
    required this.caption,
    required this.featuredImage,
    required this.mrp,
    required this.stock,
    required this.isActive,
    required this.discount,
    required this.createdDate,
    required this.productType,
    this.showingOrder,
    required this.variationName,
    required this.category,
    required this.taxRate,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      variations: json['variations'] ?? [],
      inWishlist: json['in_wishlist'] ?? false,
      avgRating: (json['avg_rating'] ?? 0).toDouble(),
      images: List<String>.from(json['images'] ?? []),
      variationExists: json['variation_exists'] ?? false,
      salePrice: (json['sale_price'] ?? 0).toDouble(),
      addons: (json['addons'] as List<dynamic>?)
              ?.map((e) => Addon.fromJson(e))
              .toList() ??
          [],
      available: json['available'] ?? false,
      availableFrom: json['available_from'] ?? '',
      availableTo: json['available_to'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      caption: json['caption'] ?? '',
      featuredImage: json['featured_image'] ?? '',
      mrp: (json['mrp'] ?? 0).toDouble(),
      stock: json['stock'] ?? 0,
      isActive: json['is_active'] ?? false,
      discount: json['discount']?.toString() ?? '0',
      createdDate: json['created_date'] ?? '',
      productType: json['product_type'] ?? '',
      showingOrder: json['showing_order'],
      variationName: json['variation_name'] ?? '',
      category: json['category'] ?? 0,
      taxRate: (json['tax_rate'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'variations': variations,
      'in_wishlist': inWishlist,
      'avg_rating': avgRating,
      'images': images,
      'variation_exists': variationExists,
      'sale_price': salePrice,
      'addons': addons.map((e) => e.toJson()).toList(),
      'available': available,
      'available_from': availableFrom,
      'available_to': availableTo,
      'name': name,
      'description': description,
      'caption': caption,
      'featured_image': featuredImage,
      'mrp': mrp,
      'stock': stock,
      'is_active': isActive,
      'discount': discount,
      'created_date': createdDate,
      'product_type': productType,
      'showing_order': showingOrder,
      'variation_name': variationName,
      'category': category,
      'tax_rate': taxRate,
    };
  }
}
class Addon {
  final int id;
  final double price;
  final String name;
  final String description;
  final String featuredImage;
  final int stock;
  final bool isActive;
  final double taxRate;

  Addon({
    required this.id,
    required this.price,
    required this.name,
    required this.description,
    required this.featuredImage,
    required this.stock,
    required this.isActive,
    required this.taxRate,
  });

  factory Addon.fromJson(Map<String, dynamic> json) {
    return Addon(
      id: json['id'],
      price: (json['price'] ?? 0).toDouble(),
      name: json['name'],
      description: json['description'],
      featuredImage: json['featured_image'],
      stock: json['stock'],
      isActive: json['is_active'],
      taxRate: (json['tax_rate'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'name': name,
      'description': description,
      'featured_image': featuredImage,
      'stock': stock,
      'is_active': isActive,
      'tax_rate': taxRate,
    };
  }
}

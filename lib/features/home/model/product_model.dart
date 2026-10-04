/// A product the partner has put on discount.
class ProductModel {
  const ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.discount,
    this.imagePath,
    this.tags = const [],
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'].toString(),
      name: json['name'] as String,
      category: json['category'] as String? ?? '',
      price: (json['price'] as num).toDouble(),
      discount: (json['discount'] as num).toInt(),
      imagePath: json['image'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.cast<String>() ?? const [],
    );
  }

  final String id;
  final String name;

  /// Empty when the partner didn't set one.
  final String category;

  /// Price before the discount.
  final double price;

  /// Discount in percent, e.g. 30.
  final int discount;

  /// Local photo file; null shows an icon instead.
  final String? imagePath;

  /// Translation keys (e.g. 'tag_new') or plain text.
  final List<String> tags;

  double get discountedPrice => price * (100 - discount) / 100;
}

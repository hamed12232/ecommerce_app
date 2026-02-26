import 'dart:convert';

class CartItemModel {
  int quantity;
  String productId;
  String variationId;
  double? price;
  String? image;
  String? title;
  String? brandName;
  Map<String, String>? selectedVariation;

  CartItemModel({
    required this.quantity,
    required this.productId,
    this.variationId = '',
    this.image,
    this.price,
    this.title,
    this.brandName,
    this.selectedVariation,
  });

  static CartItemModel empty() =>
      CartItemModel(productId: '', variationId: '', quantity: 0);

  CartItemModel copyWith({
    int? quantity,
    String? productId,
    String? variationId,
    double? price,
    String? image,
    String? title,
    String? brandName,
    Map<String, String>? selectedVariation,
  }) {
    return CartItemModel(
      quantity: quantity ?? this.quantity,
      productId: productId ?? this.productId,
      variationId: variationId ?? this.variationId,
      price: price ?? this.price,
      image: image ?? this.image,
      title: title ?? this.title,
      brandName: brandName ?? this.brandName,
      selectedVariation: selectedVariation ?? this.selectedVariation,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'quantity': quantity,
      'productId': productId,
      'variationId': variationId,
      'price': price,
      'image': image,
      'title': title,
      'brandName': brandName,
      'selectedVariation': selectedVariation,
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      quantity: map['quantity']?.toInt() ?? 0,
      productId: map['productId'] ?? '',
      variationId: map['variationId'] ?? '',
      price: map['price']?.toDouble(),
      image: map['image'],
      title: map['title'],
      brandName: map['brandName'],
      selectedVariation: map['selectedVariation'] != null
          ? Map<String, String>.from(map['selectedVariation'] as Map)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItemModel.fromJson(String source) =>
      CartItemModel.fromMap(json.decode(source));
}

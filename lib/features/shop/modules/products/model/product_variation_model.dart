class ProductVariationModel {
  final String id;
  String sku;
  String image;
  String? description;
  double price;
  double? salePrice;
  int stock;
  Map<String, String> attributeValues;

  ProductVariationModel({
    required this.id,
    this.sku = '',
    this.image = '',
    this.description = '',
    this.price = 0.0,
    this.salePrice,
    this.stock = 0,
    required this.attributeValues,
  });

  /// Create Empty func for clean code
  static ProductVariationModel empty() => ProductVariationModel(
    id: '',
    sku: '',
    image: '',
    description: '',
    price: 0.0,
    salePrice: 0.0,
    stock: 0,
    attributeValues: {},
  );

  /// Map Json oriented document snapshot from Firebase to Model
  factory ProductVariationModel.fromJson(Map<String, dynamic> document) {
    if (document.isEmpty) return ProductVariationModel.empty();
    return ProductVariationModel(
      id: document['id'],
      sku: document['sku'],
      image: document['image'],
      description: document['description'],
      price: document['price'],
      salePrice: document['salePrice'],
      stock: document['stock'],
      attributeValues: Map<String, String>.from(document['attributeValues']),
    );
  }

  /// Map Model to Json oriented document snapshot for Firebase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sku': sku,
      'image': image,
      'description': description,
      'price': price,
      'salePrice': salePrice,
      'stock': stock,
      'attributeValues': attributeValues,
    };
  }
}

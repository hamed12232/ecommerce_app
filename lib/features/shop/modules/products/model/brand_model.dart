class BrandModel {
  String id;
  String name;
  String image;
  bool? isFeatured;
  int? productsCount;

  BrandModel({
    required this.id,
    required this.image,
    required this.name,
    this.isFeatured,
    this.productsCount,
  });

  static BrandModel empty() => BrandModel(id: '', image: '', name: '');

  /// Map Json oriented document snapshot from Firebase to Model
  factory BrandModel.fromJson(Map<String, dynamic> document) {
    if (document.isEmpty) return BrandModel.empty();
    return BrandModel(
      id: document['id'],
      image: document['image'],
      name: document['name'],
      isFeatured: document['isFeatured'],
      productsCount: document['productsCount'],
    );
  }

  /// Map Model to Json oriented document snapshot for Firebase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'isFeatured': isFeatured,
      'productsCount': productsCount,
    };
  }
}

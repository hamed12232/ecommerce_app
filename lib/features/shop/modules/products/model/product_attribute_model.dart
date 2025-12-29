class ProductAttributeModel {
  String? name;
  final List<String>? values;

  ProductAttributeModel({this.name, this.values});

  static ProductAttributeModel empty() =>
      ProductAttributeModel(name: '', values: []);

  /// Map Json oriented document snapshot from Firebase to Model
  factory ProductAttributeModel.fromJson(Map<String, dynamic> document) {
    if (document.isEmpty) return ProductAttributeModel.empty();
    return ProductAttributeModel(
      name: document.containsKey('name') ? document['name'] : '',
      values: document.containsKey('values')
          ? List<String>.from(document['values'])
          : [],
    );
  }

  /// Map Model to Json oriented document snapshot for Firebase
  Map<String, dynamic> toJson() {
    return {'name': name, 'values': values};
  }
}

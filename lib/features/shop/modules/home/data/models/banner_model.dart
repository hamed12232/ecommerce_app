import 'package:ecommerce_app/features/shop/modules/home/domain/entities/banner_entity.dart';

class BannerModel extends BannerEntity {
  BannerModel({
    required super.id,
    required super.imageUrl,
    required super.targetScreen,
    required super.active,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['Id'] ?? '',
      imageUrl: json['ImageUrl'] ?? '',
      targetScreen: json['TargetScreen'] ?? '',
      active: json['Active'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'ImageUrl': imageUrl,
      'TargetScreen': targetScreen,
      'Active': active,
    };
  }
}

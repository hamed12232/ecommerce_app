import 'package:ecommerce_app/features/shop/modules/home/data/models/banner_model.dart';

abstract class BaseBannerDataSource {
  Future<List<BannerModel>> getBanners();
  Future<void> uploadBanners(List<BannerModel> banners);
  Future<String> uploadImage(String path, dynamic image);
}

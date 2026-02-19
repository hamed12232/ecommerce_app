import 'package:ecommerce_app/core/utils/helper/network_manager.dart';
import 'package:ecommerce_app/core/utils/services/dummy_data_uploader.dart';
import 'package:ecommerce_app/features/shop/modules/brand/domain/entities/brand_entity.dart';
import 'package:ecommerce_app/features/shop/modules/brand/domain/usecases/get_brand_products_usecase.dart';
import 'package:ecommerce_app/features/shop/modules/brand/domain/usecases/get_brands_usecase.dart';
import 'package:ecommerce_app/features/shop/modules/brand/domain/usecases/upload_brand_image_usecase.dart';
import 'package:ecommerce_app/features/shop/modules/brand/domain/usecases/upload_brands_usecase.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/entities/product_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'brand_state.dart';

class BrandCubit extends Cubit<BrandState> {
  final GetBrandsUseCase getBrandsUseCase;
  final GetBrandProductsUseCase getBrandProductsUseCase;
  final UploadBrandsUseCase uploadBrandsUseCase;
  final UploadBrandImageUseCase uploadBrandImageUseCase;

  late final DummyDataUploader<BrandEntity> _dummyDataUploader;

  BrandCubit(
    this.getBrandsUseCase,
    this.getBrandProductsUseCase,
    this.uploadBrandsUseCase,
    this.uploadBrandImageUseCase,
  ) : super(const BrandState()) {
    _dummyDataUploader = DummyDataUploader<BrandEntity>(
      uploadImage: (path, file) => uploadBrandImageUseCase.call(path, file),
      uploadEntities: (entities) => uploadBrandsUseCase.call(entities),
      config: const DummyDataUploaderConfig(storageFolderName: 'brands'),
    );
  }

  Future<void> uploadDummyData(List<BrandEntity> brands) async {
    emit(state.copyWith(status: BrandStatus.loading));

    final result = await _dummyDataUploader.uploadDummyData(brands);

    if (result.success) {
      emit(state.copyWith(status: BrandStatus.success));
      fetchBrands(); // Refresh brands after upload
    } else {
      emit(
        state.copyWith(
          status: BrandStatus.error,
          error: result.errorMessage ?? 'Unknown error',
        ),
      );
    }
  }

  Future<void> fetchBrands() async {
    final isInternetConnected = await NetworkManager.instance.isConnected();
    if (!isInternetConnected) {
      emit(
        state.copyWith(
          status: BrandStatus.error,
          error: 'No Internet Connection',
        ),
      );
      return;
    }

    emit(state.copyWith(status: BrandStatus.loading));

    final result = await getBrandsUseCase.call();

    result.fold(
      (failure) => emit(
        state.copyWith(status: BrandStatus.error, error: failure.message),
      ),
      (brands) => emit(
        state.copyWith(
          status: BrandStatus.success,
          brands: brands,
          featuredBrands: brands.where((brand) => brand.isFeatured!).toList(),
        ),
      ),
    );
  }

  Future<void> fetchBrandProducts(String brandId) async {
    final isInternetConnected = await NetworkManager.instance.isConnected();
    if (!isInternetConnected) {
      emit(
        state.copyWith(
          status: BrandStatus.error,
          error: 'No Internet Connection',
        ),
      );
      return;
    }

    emit(state.copyWith(status: BrandStatus.loading));

    final result = await getBrandProductsUseCase.call(brandId);

    result.fold(
      (failure) => emit(
        state.copyWith(status: BrandStatus.error, error: failure.message),
      ),
      (products) => emit(
        state.copyWith(status: BrandStatus.success, brandProducts: products),
      ),
    );
  }
}

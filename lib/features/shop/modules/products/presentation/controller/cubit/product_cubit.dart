import 'package:ecommerce_app/core/utils/helper/network_manager.dart';
import 'package:ecommerce_app/core/utils/services/dummy_data_uploader.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/entities/product_entity.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/usecases/fetch_featured_products_usecase.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/usecases/upload_product_image_usecase.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/usecases/upload_products_usecase.dart';
import 'package:ecommerce_app/features/shop/modules/products/presentation/controller/cubit/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductState> {
  final FetchFeaturedProductsUseCase fetchFeaturedProductsUseCase;
  final UploadProductsUseCase uploadProductsUseCase;
  final UploadProductImageUseCase uploadProductImageUseCase;

  late final DummyDataUploader<ProductEntity> _dummyDataUploader;

  ProductCubit(
    this.fetchFeaturedProductsUseCase,
    this.uploadProductsUseCase,
    this.uploadProductImageUseCase,
  ) : super(const ProductState()) {
    _dummyDataUploader = DummyDataUploader<ProductEntity>(
      uploadImage: (path, file) => uploadProductImageUseCase.call(path, file),
      uploadEntities: (entities) => uploadProductsUseCase.call(entities),
      config: const DummyDataUploaderConfig(storageFolderName: 'products'),
    );
  }

  Future<void> fetchFeaturedProducts() async {
    final isInternetConnected = await NetworkManager.instance.isConnected();
    if (!isInternetConnected) {
      emit(
        state.copyWith(
          status: ProductStatus.error,
          error: 'No Internet Connection',
        ),
      );
      return;
    }

    emit(state.copyWith(status: ProductStatus.loading));

    final result = await fetchFeaturedProductsUseCase.call();

    result.fold(
      (failure) => emit(
        state.copyWith(status: ProductStatus.error, error: failure.message),
      ),
      (products) => emit(
        state.copyWith(
          status: ProductStatus.success,
          featuredProducts: products,
        ),
      ),
    );
  }

  Future<void> uploadDummyData(List<ProductEntity> products) async {
    emit(state.copyWith(status: ProductStatus.loading));

    final result = await _dummyDataUploader.uploadDummyData(products);

    if (result.success) {
      emit(state.copyWith(status: ProductStatus.success));
      fetchFeaturedProducts(); // Refresh products after upload
    } else {
      emit(
        state.copyWith(
          status: ProductStatus.error,
          error: result.errorMessage ?? 'Unknown error',
        ),
      );
    }
  }
}

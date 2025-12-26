import 'package:ecommerce_app/core/utils/helper/network_manager.dart';
import 'package:ecommerce_app/core/utils/services/dummy_data_uploader.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/entities/category_entity.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/usecases/get_categories_usecase.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/usecases/upload_categories_usecase.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/usecases/upload_category_image_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final UploadCategoriesUseCase uploadCategoriesUseCase;
  final UploadCategoryImageUseCase uploadCategoryImageUseCase;

  late final DummyDataUploader<CategoryEntity> _dummyDataUploader;

  CategoryCubit(
    this.getCategoriesUseCase,
    this.uploadCategoriesUseCase,
    this.uploadCategoryImageUseCase,
  ) : super(const CategoryState()) {
    _dummyDataUploader = DummyDataUploader<CategoryEntity>(
      uploadImage: (path, file) => uploadCategoryImageUseCase.call(path, file),
      uploadEntities: (entities) => uploadCategoriesUseCase.call(entities),
      config: const DummyDataUploaderConfig(storageFolderName: 'categories'),
    );
  }

  Future<void> uploadDummyData(List<CategoryEntity> categories) async {
    emit(state.copyWith(status: CategoryStatus.loading));

    final result = await _dummyDataUploader.uploadDummyData(categories);

    if (result.success) {
      emit(state.copyWith(status: CategoryStatus.success));
      fetchCategories(); // Refresh categories after upload
    } else {
      emit(
        state.copyWith(
          status: CategoryStatus.error,
          error: result.errorMessage ?? 'Unknown error',
        ),
      );
    }
  }

  Future<void> fetchCategories() async {
    final isInternetConnected = await NetworkManager.instance.isConnected();
    if (!isInternetConnected) {
      emit(
        state.copyWith(
          status: CategoryStatus.error,
          error: 'No Internet Connection',
        ),
      );
      return;
    }

    emit(state.copyWith(status: CategoryStatus.loading));

    final result = await getCategoriesUseCase.call();

    result.fold(
      (failure) => emit(
        state.copyWith(status: CategoryStatus.error, error: failure.message),
      ),
      (categories) => emit(
        state.copyWith(
          status: CategoryStatus.success,
          categories: categories,
          featuredCategories: categories
              .where(
                (category) => category.isFeatured && category.parentId.isEmpty,
              )
              .toList(),
        ),
      ),
    );
  }
}

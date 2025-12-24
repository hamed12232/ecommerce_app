import 'dart:io';

import 'package:ecommerce_app/core/utils/helper/network_manager.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/entities/category_entity.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/usecases/get_categories_usecase.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/usecases/upload_categories_usecase.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/usecases/upload_category_image_usecase.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final UploadCategoriesUseCase uploadCategoriesUseCase;
  final UploadCategoryImageUseCase uploadCategoryImageUseCase;

  CategoryCubit(
    this.getCategoriesUseCase,
    this.uploadCategoriesUseCase,
    this.uploadCategoryImageUseCase,
  ) : super(const CategoryState());

  Future<void> uploadDummyData(List<CategoryEntity> categories) async {
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

    try {
      final List<CategoryEntity> updatedCategories = [];

      for (var category in categories) {
        String imageUrl = category.image;

        // If image is a local asset, upload it to Supabase
        if (imageUrl.startsWith('assets/')) {
          // Assets are logical paths within the app bundle, not physical file system paths.
          // To use the File API, we must copy the asset bytes to a temporary location on disk.
          final byteData = await rootBundle.load(imageUrl);
          final bytes = byteData.buffer.asUint8List();

          // Create a temporary file
          final tempDir = await getTemporaryDirectory();
          final file = await File(
            '${tempDir.path}/${category.name.toLowerCase().replaceAll(' ', '_')}.png',
          ).create();
          await file.writeAsBytes(bytes);

          final uploadResult = await uploadCategoryImageUseCase.call(
            'categories/${category.name.toLowerCase().replaceAll(' ', '_')}.png',
            file,
          );

          imageUrl = uploadResult.fold(
            (failure) => throw Exception(failure.message),
            (url) => url,
          );

          // Clean up the temporary file
          if (await file.exists()) {
            await file.delete();
          }
        }

        updatedCategories.add(
          CategoryEntity(
            id: category.id,
            name: category.name,
            image: imageUrl,
            parentId: category.parentId,
            isFeatured: category.isFeatured,
          ),
        );
      }

      final result = await uploadCategoriesUseCase.call(updatedCategories);

      result.fold(
        (failure) => emit(
          state.copyWith(status: CategoryStatus.error, error: failure.message),
        ),
        (_) {
          emit(state.copyWith(status: CategoryStatus.success));
          fetchCategories(); // Refresh categories after upload
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CategoryStatus.error,
          error: 'Failed to upload images: ${e.toString()}',
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

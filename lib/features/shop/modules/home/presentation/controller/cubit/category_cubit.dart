import 'package:ecommerce_app/core/utils/helper/network_manager.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/entities/category_entity.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/usecases/get_categories_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final GetCategoriesUseCase getCategoriesUseCase;

  CategoryCubit(this.getCategoriesUseCase) : super(const CategoryState());

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
          featuredCategories: categories.where((category) => category.isFeatured && category.parentId.isEmpty).toList(),
        ),
      ),
    );
  }
}

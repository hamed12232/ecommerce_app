part of 'category_cubit.dart';

enum CategoryStatus { initial, loading, success, error }

class CategoryState {
  final CategoryStatus status;
  final List<CategoryEntity> categories;
  final List<CategoryEntity> featuredCategories;
  final String? error;

  const CategoryState({
    this.status = CategoryStatus.initial,
    this.categories = const [],
    this.featuredCategories = const [],
    this.error,
  });

  CategoryState copyWith({
    CategoryStatus? status,
    List<CategoryEntity>? categories,
    List<CategoryEntity>? featuredCategories,
    String? error,
  }) {
    return CategoryState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      featuredCategories: featuredCategories ?? this.featuredCategories,
      error: error ?? this.error,
    );
  }
}

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/core/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_app/core/utils/exceptions/platform_exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/home/data/datasources/base_category_data_source.dart';
import 'package:ecommerce_app/features/shop/modules/home/data/models/category_model.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/entities/category_entity.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/repositories/base_category_repository.dart';

class CategoryRepositoryImpl implements BaseCategoryRepository {
  final BaseCategoryDataSource baseCategoryDataSource;

  CategoryRepositoryImpl({required this.baseCategoryDataSource});

  @override
  Future<Either<Exceptions, List<CategoryEntity>>> getCategories() async {
    try {
      final categories = await baseCategoryDataSource.getCategories();
      return Right(categories);
    } on AppFirebaseException catch (e) {
      return Left(Exceptions(e.message));
    } on AppPlatformException catch (e) {
      return Left(Exceptions(e.message));
    } catch (e) {
      return Left(Exceptions(e.toString()));
    }
  }

  @override
  Future<Either<Exceptions, void>> uploadCategories(
    List<CategoryEntity> categories,
  ) async {
    try {
      final categoryModels = categories
          .map(
            (e) => CategoryModel(
              id: e.id,
              name: e.name,
              image: e.image,
              parentId: e.parentId,
              isFeatured: e.isFeatured,
            ),
          )
          .toList();
      await baseCategoryDataSource.uploadCategories(categoryModels);
      return const Right(null);
    } on AppFirebaseException catch (e) {
      return Left(Exceptions(e.message));
    } on AppPlatformException catch (e) {
      return Left(Exceptions(e.message));
    } catch (e) {
      return Left(Exceptions(e.toString()));
    }
  }

  @override
  Future<Either<Exceptions, String>> uploadImage(
    String path,
    dynamic image,
  ) async {
    try {
      final url = await baseCategoryDataSource.uploadImage(path, image);
      return Right(url);
    } on AppFirebaseException catch (e) {
      return Left(Exceptions(e.message));
    } on AppPlatformException catch (e) {
      return Left(Exceptions(e.message));
    } catch (e) {
      return Left(Exceptions(e.toString()));
    }
  }
}

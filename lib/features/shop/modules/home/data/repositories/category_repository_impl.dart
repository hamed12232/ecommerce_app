import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/core/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_app/core/utils/exceptions/platform_exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/home/data/datasources/base_category_data_source.dart';
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
}

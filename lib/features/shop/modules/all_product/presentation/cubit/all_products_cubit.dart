import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/all_product/domain/use_cases/get_all_products.dart';
import 'package:ecommerce_app/features/shop/modules/all_product/domain/use_cases/get_products_by_query_use_case.dart';
import 'package:ecommerce_app/features/shop/modules/all_product/presentation/cubit/all_products_state.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/entities/product_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllProductsCubit extends Cubit<AllProductsState> {
  final GetProductsByQueryUseCase getProductsByQueryUseCase;
  final GetAllFeaturedProductsUseCase getAllFeaturedProductsUseCase;

  AllProductsCubit({
    required this.getProductsByQueryUseCase,
    required this.getAllFeaturedProductsUseCase,
  }) : super(AllProductsInitial());

  List<ProductEntity> _allProducts = [];

  Future<void> getProductsByQuery(Query query) async {
    await _executeWithLoading(
      operation: () => getProductsByQueryUseCase(query),
      onSuccess: (products) {
        _allProducts = products;
        emit(AllProductsLoaded(products));
      },
    );
  }

  Future<void> getAllFeaturedProducts() async {
    await _executeWithLoading(
      operation: () => getAllFeaturedProductsUseCase(),
      onSuccess: (products) {
        _allProducts = products;
        emit(AllProductsLoaded(products));
      },
    );
  }

  void sortProducts(String sortOption) {
    if (_allProducts.isEmpty) return;

    final sortedProducts = List<ProductEntity>.from(_allProducts);
    final comparator = _getSortComparator(sortOption);
    sortedProducts.sort(comparator);
    emit(AllProductsLoaded(sortedProducts));
  }

  int Function(ProductEntity, ProductEntity) _getSortComparator(
    String sortOption,
  ) {
    switch (sortOption) {
      case 'Name':
        return (a, b) => a.title.compareTo(b.title);
      case 'Higher Price':
        return (a, b) => b.price.compareTo(a.price);
      case 'Lower Price':
        return (a, b) => a.price.compareTo(b.price);
      case 'Newest':
        return (a, b) {
          if (a.date == null && b.date == null) return 0;
          if (a.date == null) return 1;
          if (b.date == null) return -1;
          return b.date!.compareTo(a.date!);
        };
      case 'Sale':
        return (a, b) {
          final aSalePrice = a.salePrice ?? 0;
          final bSalePrice = b.salePrice ?? 0;
          if (bSalePrice > 0 && aSalePrice > 0) {
            return bSalePrice.compareTo(aSalePrice);
          }
          if (bSalePrice > 0) return 1;
          if (aSalePrice > 0) return -1;
          return 0;
        };
      default:
        return (a, b) => a.title.compareTo(b.title);
    }
  }

  Future<void> _executeWithLoading<T>({
    required Future<Either<Exceptions, List<ProductEntity>>> Function()
    operation,
    required void Function(List<ProductEntity> products) onSuccess,
  }) async {
    emit(AllProductsLoading());
    final result = await operation();
    result.fold((error) => emit(AllProductsError(error.message)), onSuccess);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
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
    emit(AllProductsLoading());
    final result = await getProductsByQueryUseCase(query);
    result.fold((error) => emit(AllProductsError(error.message)), (products) {
      _allProducts = products;
      emit(AllProductsLoaded(products));
    });
  }

  Future<void> getAllFeaturedProducts() async {
    emit(AllProductsLoading());
    final result = await getAllFeaturedProductsUseCase();
    result.fold((error) => emit(AllProductsError(error.message)), (products) {
      _allProducts = products;
      emit(AllProductsLoaded(products));
    });
  }

  void sortProducts(String sortOption) {
    List<ProductEntity> products = List.from(_allProducts);

    switch (sortOption) {
      case 'Name':
        products.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'Higher Price':
        products.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Lower Price':
        products.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Newest':
        products.sort((a, b) {
          if (a.date == null) return 1;
          if (b.date == null) return -1;
          return b.date!.compareTo(a.date!);
        });
        break;
      case 'Sale':
        products.sort((a, b) {
          if (b.salePrice! > 0) {
            return b.salePrice!.compareTo(a.salePrice!);
          } else if (a.salePrice! > 0) {
            return -1;
          } else {
            return 1;
          }
        });
        break;
      default:
        products.sort((a, b) => a.title.compareTo(b.title));
    }
    emit(AllProductsLoaded(products));
  }
}

import 'package:ecommerce_app/features/shop/modules/favourites/domain/usecases/favourite_usecases.dart';
import 'package:ecommerce_app/features/shop/modules/favourites/presentation/controller/cubit/favourite_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  final ToggleFavouriteUseCase toggleFavouriteUseCase;
  final IsFavouriteUseCase isFavouriteUseCase;
  final GetFavouriteProductsUseCase getFavouriteProductsUseCase;

  FavouriteCubit({
    required this.toggleFavouriteUseCase,
    required this.isFavouriteUseCase,
    required this.getFavouriteProductsUseCase,
  }) : super(const FavouriteInitial()) {
    _init();
  }

  Future<void> _init() async {
    // 1. Initially load from local storage for fast UI feedback
    final initialIds = isFavouriteUseCase.repository.getFavouriteIds();
    emit(FavouriteUpdated(initialIds));

    // 2. Sync with Firestore in the background
    try {
      await isFavouriteUseCase.repository.syncFavourites();
      // 3. Reload after sync to show changes from other devices
      final syncedIds = isFavouriteUseCase.repository.getFavouriteIds();
      emit(FavouriteUpdated(syncedIds));
    } catch (_) {
      // If sync fails (e.g. no internet), we keep the local state.
    }
  }

  Future<void> toggleFavourite(String productId) async {
    final currentIds = List<String>.from(state.favouriteIds);
    if (currentIds.contains(productId)) {
      currentIds.remove(productId);
    } else {
      currentIds.add(productId);
    }
    emit(FavouriteUpdated(currentIds));

    // Persist changes (this now handles offline internally)
    try {
      await toggleFavouriteUseCase(productId);
    } catch (_) {
      // If something critically failed (not just offline),
      // you might want to revert the UI state here.
      // For now, the repository handles remote failures, so this is safe.
    }
  }

  bool isFavourite(String productId) {
    return state.favouriteIds.contains(productId);
  }

  Future<void> fetchFavouriteProducts() async {
    emit(FavouriteLoading(state.favouriteIds));
    try {
      final products = await getFavouriteProductsUseCase();
      emit(FavouriteLoaded(state.favouriteIds, products));
    } catch (e) {
      emit(FavouriteError(state.favouriteIds, e.toString()));
    }
  }
}

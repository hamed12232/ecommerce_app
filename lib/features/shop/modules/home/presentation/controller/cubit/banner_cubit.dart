import 'package:ecommerce_app/core/utils/helper/network_manager.dart';
import 'package:ecommerce_app/core/utils/services/dummy_data_uploader.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/entities/banner_entity.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/usecases/get_banners_usecase.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/usecases/upload_banner_image_usecase.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/usecases/upload_banners_usecase.dart';
import 'package:ecommerce_app/features/shop/modules/home/presentation/controller/cubit/banner_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BannerCubit extends Cubit<BannerState> {
  final GetBannersUseCase getBannersUseCase;
  final UploadBannersUseCase uploadBannersUseCase;
  final UploadBannerImageUseCase uploadBannerImageUseCase;

  late final DummyDataUploader<BannerEntity> _dummyDataUploader;

  BannerCubit(
    this.getBannersUseCase,
    this.uploadBannersUseCase,
    this.uploadBannerImageUseCase,
  ) : super(const BannerState()) {
    _dummyDataUploader = DummyDataUploader<BannerEntity>(
      uploadImage: (path, file) => uploadBannerImageUseCase.call(path, file),
      uploadEntities: (entities) => uploadBannersUseCase.call(entities),
      config: const DummyDataUploaderConfig(storageFolderName: 'banners'),
    );
  }

  Future<void> fetchBanners() async {
    final isInternetConnected = await NetworkManager.instance.isConnected();
    if (!isInternetConnected) {
      emit(
        state.copyWith(
          status: BannerStatus.error,
          error: 'No Internet Connection',
        ),
      );
      return;
    }

    emit(state.copyWith(status: BannerStatus.loading));

    final result = await getBannersUseCase.call();

    result.fold(
      (failure) => emit(
        state.copyWith(status: BannerStatus.error, error: failure.message),
      ),
      (banners) =>
          emit(state.copyWith(status: BannerStatus.success, banners: banners)),
    );
  }

  Future<void> uploadDummyData(List<BannerEntity> banners) async {
    emit(state.copyWith(status: BannerStatus.loading));

    final result = await _dummyDataUploader.uploadDummyData(banners);

    if (result.success) {
      emit(state.copyWith(status: BannerStatus.success));
      fetchBanners(); // Refresh banners after upload
    } else {
      emit(
        state.copyWith(
          status: BannerStatus.error,
          error: result.errorMessage ?? 'Unknown error',
        ),
      );
    }
  }
}

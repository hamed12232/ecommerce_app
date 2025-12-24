import 'dart:io';

import 'package:ecommerce_app/core/utils/helper/network_manager.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/entities/banner_entity.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/usecases/get_banners_usecase.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/usecases/upload_banner_image_usecase.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/usecases/upload_banners_usecase.dart';
import 'package:ecommerce_app/features/shop/modules/home/presentation/controller/cubit/banner_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

class BannerCubit extends Cubit<BannerState> {
  final GetBannersUseCase getBannersUseCase;
  final UploadBannersUseCase uploadBannersUseCase;
  final UploadBannerImageUseCase uploadBannerImageUseCase;

  BannerCubit(
    this.getBannersUseCase,
    this.uploadBannersUseCase,
    this.uploadBannerImageUseCase,
  ) : super(const BannerState());

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

    try {
      final List<BannerEntity> updatedBanners = [];

      for (var banner in banners) {
        String imageUrl = banner.imageUrl;

        // If image is a local asset, upload it to Supabase
        if (imageUrl.startsWith('assets/')) {
          final byteData = await rootBundle.load(imageUrl);
          final bytes = byteData.buffer.asUint8List();

          // Create a temporary file
          final tempDir = await getTemporaryDirectory();
          final file = await File('${tempDir.path}/${banner.id}.png').create();
          await file.writeAsBytes(bytes);

          final uploadResult = await uploadBannerImageUseCase.call(
            'banners/${banner.id}.png',
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

        updatedBanners.add(
          BannerEntity(
            id: banner.id,
            imageUrl: imageUrl,
            targetScreen: banner.targetScreen,
            active: banner.active,
          ),
        );
      }

      final result = await uploadBannersUseCase.call(updatedBanners);

      result.fold(
        (failure) => emit(
          state.copyWith(status: BannerStatus.error, error: failure.message),
        ),
        (_) {
          emit(state.copyWith(status: BannerStatus.success));
          fetchBanners(); // Refresh banners after upload
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: BannerStatus.error,
          error: 'Failed to upload images: ${e.toString()}',
        ),
      );
    }
  }
}

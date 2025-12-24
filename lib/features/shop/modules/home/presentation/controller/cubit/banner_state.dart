import 'package:ecommerce_app/features/shop/modules/home/domain/entities/banner_entity.dart';
import 'package:equatable/equatable.dart';

enum BannerStatus { initial, loading, success, error }

class BannerState extends Equatable {
  final List<BannerEntity> banners;
  final BannerStatus status;
  final String error;

  const BannerState({
    this.banners = const [],
    this.status = BannerStatus.initial,
    this.error = '',
  });

  BannerState copyWith({
    List<BannerEntity>? banners,
    BannerStatus? status,
    String? error,
  }) {
    return BannerState(
      banners: banners ?? this.banners,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [banners, status, error];
}

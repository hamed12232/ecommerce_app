import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/personlization/domain/repositories/base_address_repository.dart';

class SetPrimaryAddressUseCase {
  SetPrimaryAddressUseCase({required this.repository});

  final BaseAddressRepository repository;

  Future<Either<Exceptions, void>> call(String addressId) {
    return repository.setPrimaryAddress(addressId);
  }
}

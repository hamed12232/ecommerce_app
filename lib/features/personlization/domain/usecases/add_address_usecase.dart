import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/personlization/data/models/address_model.dart';
import 'package:ecommerce_app/features/personlization/domain/repositories/base_address_repository.dart';
class AddAddressUseCase {
  AddAddressUseCase({required this.repository});

  final BaseAddressRepository repository;

  Future<Either<Exceptions, void>> call(AddressModel address) {
    return repository.addAddress(address);
  }
}


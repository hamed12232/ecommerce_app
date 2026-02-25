import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/personlization/data/models/address_model.dart';

abstract class BaseAddressRepository {
  Future<Either<Exceptions, List<AddressModel>>> fetchUserAddresses();
  Future<Either<Exceptions, void>> addAddress(AddressModel address);
  Future<Either<Exceptions, void>> setPrimaryAddress(String addressId);
}


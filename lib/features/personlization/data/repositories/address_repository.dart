import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/core/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_app/core/utils/exceptions/platform_exceptions.dart';
import 'package:ecommerce_app/features/personlization/data/datasources/base_address_data_source.dart';
import 'package:ecommerce_app/features/personlization/data/models/address_model.dart';
import 'package:ecommerce_app/features/personlization/domain/repositories/base_address_repository.dart';

class AddressRepository implements BaseAddressRepository {
  AddressRepository({required this.dataSource});

  final BaseAddressDataSource dataSource;

  @override
  Future<Either<Exceptions, List<AddressModel>>> fetchUserAddresses() async {
    try {
      final addresses = await dataSource.fetchUserAddresses();
      return Right(addresses);
    } on AppFirebaseException catch (e) {
      return Left(Exceptions(e.message));
    } on AppPlatformException catch (e) {
      return Left(Exceptions(e.message));
    } catch (e) {
      return Left(Exceptions(e.toString()));
    }
  }

  @override
  Future<Either<Exceptions, void>> addAddress(AddressModel address) async {
    try {
      await dataSource.addAddress(address);
      return const Right(null);
    } on AppFirebaseException catch (e) {
      return Left(Exceptions(e.message));
    } on AppPlatformException catch (e) {
      return Left(Exceptions(e.message));
    } catch (e) {
      return Left(Exceptions(e.toString()));
    }
  }

  @override
  Future<Either<Exceptions, void>> setPrimaryAddress(String addressId) async {
    try {
      await dataSource.setPrimaryAddress(addressId);
      return const Right(null);
    } on AppFirebaseException catch (e) {
      return Left(Exceptions(e.message));
    } on AppPlatformException catch (e) {
      return Left(Exceptions(e.message));
    } catch (e) {
      return Left(Exceptions(e.toString()));
    }
  }
}

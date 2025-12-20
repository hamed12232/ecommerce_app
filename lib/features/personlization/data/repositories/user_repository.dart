import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/core/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_app/core/utils/exceptions/platform_exceptions.dart';
import 'package:ecommerce_app/features/personlization/data/datasources/base_user_data_source.dart';
import 'package:ecommerce_app/features/personlization/data/models/user_model.dart';
import 'package:ecommerce_app/features/personlization/domain/repositories/base_user_repository.dart';

class UserRepository implements BaseUserRepository {
  final BaseUserDataSource baseUserDataSource;
  UserRepository({required this.baseUserDataSource});

  @override
  Future<Either<Exceptions, void>> saveUserRecord(UserModel userModel) async {
    try {
      await baseUserDataSource.saveUserRecord(userModel);
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
  Future<Either<Exceptions, UserModel>> fetchUserDetails() async {
    try {
      final userDetails = await baseUserDataSource.fetchUserDetails();
      return Right(userDetails);
    } on AppFirebaseException catch (e) {
      return Left(Exceptions(e.message));
    } on AppPlatformException catch (e) {
      return Left(Exceptions(e.message));
    } catch (e) {
      return Left(Exceptions(e.toString()));
    }
  }

  @override
  Future<Either<Exceptions, void>> updateUserDetails(
    UserModel userModel,
  ) async {
    try {
      await baseUserDataSource.updateUserDetails(userModel);
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
  Future<Either<Exceptions, void>> updateSingleField(
    Map<String, dynamic> json,
  ) async {
    try {
      await baseUserDataSource.updateSingleField(json);
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
  Future<Either<Exceptions, void>> removeUserRecord(String userId) async {
    try {
      await baseUserDataSource.removeUserRecord(userId);
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

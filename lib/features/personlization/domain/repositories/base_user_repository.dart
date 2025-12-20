import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/personlization/data/models/user_model.dart';

abstract class BaseUserRepository {
  Future<Either<Exceptions, void>> saveUserRecord(UserModel userModel);
  Future<Either<Exceptions, UserModel>> fetchUserDetails();
  Future<Either<Exceptions, void>> updateUserDetails(UserModel userModel);
  Future<Either<Exceptions, void>> updateSingleField(Map<String, dynamic> json);
  Future<Either<Exceptions, void>> removeUserRecord(String userId);
}

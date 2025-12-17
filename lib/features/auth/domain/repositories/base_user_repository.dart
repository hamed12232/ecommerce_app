import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/auth/data/models/user_model.dart';

abstract class BaseUserRepository {
  Future<Either<Exceptions, void>> saveUserRecord(UserModel userModel);
}
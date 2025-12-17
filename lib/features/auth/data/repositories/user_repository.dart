import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/core/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_app/core/utils/exceptions/platform_exceptions.dart';
import 'package:ecommerce_app/features/auth/data/datasources/base_user_data_source.dart';
import 'package:ecommerce_app/features/auth/data/models/user_model.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/base_user_repository.dart';

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
}

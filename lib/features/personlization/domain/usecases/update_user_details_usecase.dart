import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/personlization/data/models/user_model.dart';
import 'package:ecommerce_app/features/personlization/domain/repositories/base_user_repository.dart';

class UpdateUserDetailsUseCase {
  final BaseUserRepository repository;

  UpdateUserDetailsUseCase({required this.repository});

  Future<Either<Exceptions, void>> call(UserModel userModel) async {
    return await repository.updateUserDetails(userModel);
  }
}

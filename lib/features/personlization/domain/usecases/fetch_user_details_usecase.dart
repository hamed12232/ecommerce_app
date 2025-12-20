import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/personlization/data/models/user_model.dart';
import 'package:ecommerce_app/features/personlization/domain/repositories/base_user_repository.dart';

class FetchUserDetailsUseCase {
  final BaseUserRepository repository;

  FetchUserDetailsUseCase({required this.repository});

  Future<Either<Exceptions, UserModel>> call() async {
    return await repository.fetchUserDetails();
  }
}

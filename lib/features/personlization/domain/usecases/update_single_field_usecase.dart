import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/personlization/domain/repositories/base_user_repository.dart';

class UpdateSingleFieldUseCase {
  final BaseUserRepository repository;

  UpdateSingleFieldUseCase({required this.repository});

  Future<Either<Exceptions, void>> call(Map<String, dynamic> json) async {
    return await repository.updateSingleField(json);
  }
}

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/personlization/domain/repositories/base_user_repository.dart';

class UploadImageUseCase {
  final BaseUserRepository baseUserRepository;

  UploadImageUseCase({required this.baseUserRepository});

  Future<Either<Exceptions, String>> call(
    String path,
    dynamic imageFile,
  ) async {
    return await baseUserRepository.uploadImage(path, imageFile);
  }
}

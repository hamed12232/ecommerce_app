import 'package:ecommerce_app/features/auth/data/datasources/auth_data_source.dart';
import 'package:ecommerce_app/features/auth/data/datasources/base_auth_data_source.dart';
import 'package:ecommerce_app/features/auth/data/datasources/base_user_data_source.dart';
import 'package:ecommerce_app/features/auth/data/datasources/user_data_source.dart';
import 'package:ecommerce_app/features/auth/data/repositories/auth_repository.dart';
import 'package:ecommerce_app/features/auth/data/repositories/user_repository.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/base_auth_repository.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/base_user_repository.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/save_user_record_usecase.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:ecommerce_app/features/auth/modules/features/signUp/presentation/controller/cubit/sign_up_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // ========== Data Sources ==========
  getIt.registerLazySingleton<BaseAuthDataSource>(() => AuthDataSource());

  getIt.registerLazySingleton<BaseUserDataSource>(() => UserDataSource());

  // ========== Repositories ==========
  getIt.registerLazySingleton<BaseAuthRepository>(
    () => AuthRepository(baseAuthDataSource: getIt<BaseAuthDataSource>()),
  );

  getIt.registerLazySingleton<BaseUserRepository>(
    () => UserRepository(baseUserDataSource: getIt<BaseUserDataSource>()),
  );

  // ========== Use Cases ==========
  getIt.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(repository: getIt<BaseAuthRepository>()),
  );

  getIt.registerLazySingleton<SaveUserRecordUseCase>(
    () => SaveUserRecordUseCase(repository: getIt<BaseUserRepository>()),
  );

  // ========== Blocs/Cubits ==========
  getIt.registerFactory<SignUpCubit>(
    () => SignUpCubit(getIt<SignUpUseCase>(), getIt<SaveUserRecordUseCase>()),
  );
}

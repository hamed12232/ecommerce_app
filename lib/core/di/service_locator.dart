import 'package:ecommerce_app/features/auth/data/datasources/auth_data_source.dart';
import 'package:ecommerce_app/features/auth/data/datasources/base_auth_data_source.dart';
import 'package:ecommerce_app/features/auth/data/repositories/auth_repository.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/base_auth_repository.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/login_with_google_usecase.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/send_email_verification_usecase.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/send_password_reset_email_usecase.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:ecommerce_app/features/auth/modules/features/forget_password/presentation/controller/cubit/forget_password_cubit.dart';
import 'package:ecommerce_app/features/auth/modules/features/login/presentation/controller/cubit/login_cubit.dart';
import 'package:ecommerce_app/features/auth/modules/features/signUp/presentation/controller/cubit/sign_up_cubit.dart';
import 'package:ecommerce_app/features/auth/modules/features/verify_email/presentation/controller/cubit/verify_email_cubit.dart';
import 'package:ecommerce_app/features/personlization/data/datasources/base_user_data_source.dart';
import 'package:ecommerce_app/features/personlization/data/datasources/user_data_source.dart';
import 'package:ecommerce_app/features/personlization/data/repositories/user_repository.dart';
import 'package:ecommerce_app/features/personlization/domain/repositories/base_user_repository.dart';
import 'package:ecommerce_app/features/personlization/domain/usecases/fetch_user_details_usecase.dart';
import 'package:ecommerce_app/features/personlization/domain/usecases/remove_user_record_usecase.dart';
import 'package:ecommerce_app/features/personlization/domain/usecases/save_user_record_usecase.dart';
import 'package:ecommerce_app/features/personlization/domain/usecases/update_single_field_usecase.dart';
import 'package:ecommerce_app/features/personlization/domain/usecases/update_user_details_usecase.dart';
import 'package:ecommerce_app/features/personlization/presentation/controller/cubit/settings_cubit.dart';
import 'package:ecommerce_app/features/personlization/presentation/controller/cubit/user_cubit.dart';
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

  getIt.registerLazySingleton<SendEmailVerificationUseCase>(
    () => SendEmailVerificationUseCase(
      baseAuthRepository: getIt<BaseAuthRepository>(),
    ),
  );

  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(getIt<BaseAuthRepository>()),
  );

  getIt.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(getIt<BaseAuthRepository>()),
  );

  getIt.registerLazySingleton<LoginWithGoogleUseCase>(
    () => LoginWithGoogleUseCase(getIt<BaseAuthRepository>()),
  );

  getIt.registerLazySingleton<SendPasswordResetEmailUseCase>(
    () => SendPasswordResetEmailUseCase(getIt<BaseAuthRepository>()),
  );

  getIt.registerLazySingleton<FetchUserDetailsUseCase>(
    () => FetchUserDetailsUseCase(repository: getIt<BaseUserRepository>()),
  );

  getIt.registerLazySingleton<UpdateUserDetailsUseCase>(
    () => UpdateUserDetailsUseCase(repository: getIt<BaseUserRepository>()),
  );

  getIt.registerLazySingleton<UpdateSingleFieldUseCase>(
    () => UpdateSingleFieldUseCase(repository: getIt<BaseUserRepository>()),
  );

  getIt.registerLazySingleton<RemoveUserRecordUseCase>(
    () => RemoveUserRecordUseCase(repository: getIt<BaseUserRepository>()),
  );

  // ========== Blocs/Cubits ==========
  getIt.registerFactory<SignUpCubit>(
    () => SignUpCubit(getIt<SignUpUseCase>(), getIt<SaveUserRecordUseCase>()),
  );

  getIt.registerFactory<VerifyEmailCubit>(
    () => VerifyEmailCubit(getIt<SendEmailVerificationUseCase>()),
  );

  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(
      getIt<LoginUseCase>(),
      getIt<LoginWithGoogleUseCase>(),
      getIt<SaveUserRecordUseCase>(),
    ),
  );

  getIt.registerFactory<SettingsCubit>(
    () => SettingsCubit(getIt<LogoutUseCase>()),
  );

  getIt.registerFactory<ForgetPasswordCubit>(
    () => ForgetPasswordCubit(getIt<SendPasswordResetEmailUseCase>()),
  );

  getIt.registerFactory<UserCubit>(
    () => UserCubit(
      saveUserRecordUseCase: getIt<SaveUserRecordUseCase>(),
      fetchUserDetailsUseCase: getIt<FetchUserDetailsUseCase>(),
      updateUserDetailsUseCase: getIt<UpdateUserDetailsUseCase>(),
      updateSingleFieldUseCase: getIt<UpdateSingleFieldUseCase>(),
      removeUserRecordUseCase: getIt<RemoveUserRecordUseCase>(),
    ),
  );
}

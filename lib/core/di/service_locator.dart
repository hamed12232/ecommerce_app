import 'package:ecommerce_app/features/auth/data/datasources/auth_data_source.dart';
import 'package:ecommerce_app/features/auth/data/datasources/base_auth_data_source.dart';
import 'package:ecommerce_app/features/auth/data/repositories/auth_repository.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/base_auth_repository.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/delete_account_usecase.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/login_with_google_usecase.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/re_authenticate_usecase.dart';
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
import 'package:ecommerce_app/features/personlization/domain/usecases/upload_image_usecase.dart';
import 'package:ecommerce_app/features/personlization/presentation/controller/cubit/settings_cubit.dart';
import 'package:ecommerce_app/features/personlization/presentation/controller/cubit/user_cubit.dart';
import 'package:ecommerce_app/features/shop/modules/all_product/data/data_sources/all_product_data_source.dart';
import 'package:ecommerce_app/features/shop/modules/all_product/data/repositories/all_product_repository.dart';
import 'package:ecommerce_app/features/shop/modules/all_product/domain/repositories/base_all_product_repository.dart';
import 'package:ecommerce_app/features/shop/modules/all_product/domain/use_cases/get_all_products.dart';
import 'package:ecommerce_app/features/shop/modules/all_product/domain/use_cases/get_products_by_query_use_case.dart';
import 'package:ecommerce_app/features/shop/modules/all_product/presentation/cubit/all_products_cubit.dart';
import 'package:ecommerce_app/features/shop/modules/brand/data/datasources/base_brand_data_source.dart';
import 'package:ecommerce_app/features/shop/modules/brand/data/datasources/brand_data_source.dart';
import 'package:ecommerce_app/features/shop/modules/brand/data/repositories/brand_repository_impl.dart';
import 'package:ecommerce_app/features/shop/modules/brand/domain/repositories/base_brand_repository.dart';
import 'package:ecommerce_app/features/shop/modules/brand/domain/usecases/get_brand_products_usecase.dart';
import 'package:ecommerce_app/features/shop/modules/brand/domain/usecases/get_brands_for_category_usecase.dart';
import 'package:ecommerce_app/features/shop/modules/brand/domain/usecases/get_brands_usecase.dart';
import 'package:ecommerce_app/features/shop/modules/brand/domain/usecases/upload_brand_categories_usecase.dart';
import 'package:ecommerce_app/features/shop/modules/brand/domain/usecases/upload_brand_image_usecase.dart';
import 'package:ecommerce_app/features/shop/modules/brand/domain/usecases/upload_brands_usecase.dart';
import 'package:ecommerce_app/features/shop/modules/brand/presentation/controller/cubit/brand_cubit.dart';
import 'package:ecommerce_app/features/shop/modules/home/data/datasources/banner_data_source.dart';
import 'package:ecommerce_app/features/shop/modules/home/data/datasources/base_banner_data_source.dart';
import 'package:ecommerce_app/features/shop/modules/home/data/datasources/base_category_data_source.dart';
import 'package:ecommerce_app/features/shop/modules/home/data/datasources/category_data_source.dart';
import 'package:ecommerce_app/features/shop/modules/home/data/repositories/banner_repository_impl.dart';
import 'package:ecommerce_app/features/shop/modules/home/data/repositories/category_repository_impl.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/repositories/base_banner_repository.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/repositories/base_category_repository.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/usecases/get_banners_usecase.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/usecases/get_categories_usecase.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/usecases/upload_banner_image_usecase.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/usecases/upload_banners_usecase.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/usecases/upload_categories_usecase.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/usecases/upload_category_image_usecase.dart';
import 'package:ecommerce_app/features/shop/modules/home/presentation/controller/cubit/banner_cubit.dart';
import 'package:ecommerce_app/features/shop/modules/home/presentation/controller/cubit/category_cubit.dart';
import 'package:ecommerce_app/features/shop/modules/products/data/data_sources/product_data_source.dart';
import 'package:ecommerce_app/features/shop/modules/products/data/repositories/product_repo_impl.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/repositories/product_repo.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/usecases/fetch_featured_products_usecase.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/usecases/get_products_for_category_usecase.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/usecases/upload_product_categories_usecase.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/usecases/upload_product_image_usecase.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/usecases/upload_products_usecase.dart';
import 'package:ecommerce_app/features/shop/modules/products/presentation/controller/cubit/product_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // ========== Data Sources ==========
  getIt.registerLazySingleton<BaseAuthDataSource>(() => AuthDataSource());

  getIt.registerLazySingleton<BaseUserDataSource>(() => UserDataSource());

  getIt.registerLazySingleton<BaseCategoryDataSource>(
    () => CategoryDataSource(),
  );
  getIt.registerLazySingleton<BaseBannerDataSource>(() => BannerDataSource());

  // ========== Repositories ==========
  getIt.registerLazySingleton<BaseAuthRepository>(
    () => AuthRepository(baseAuthDataSource: getIt<BaseAuthDataSource>()),
  );

  getIt.registerLazySingleton<BaseUserRepository>(
    () => UserRepository(baseUserDataSource: getIt<BaseUserDataSource>()),
  );

  getIt.registerLazySingleton<BaseCategoryRepository>(
    () => CategoryRepositoryImpl(
      baseCategoryDataSource: getIt<BaseCategoryDataSource>(),
    ),
  );
  getIt.registerLazySingleton<BaseBannerRepository>(
    () => BannerRepositoryImpl(
      baseBannerDataSource: getIt<BaseBannerDataSource>(),
    ),
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

  getIt.registerLazySingleton<DeleteAccountUseCase>(
    () => DeleteAccountUseCase(repository: getIt<BaseAuthRepository>()),
  );

  getIt.registerLazySingleton<ReAuthenticateUseCase>(
    () => ReAuthenticateUseCase(repository: getIt<BaseAuthRepository>()),
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
  getIt.registerLazySingleton<UploadImageUseCase>(
    () => UploadImageUseCase(baseUserRepository: getIt<BaseUserRepository>()),
  );

  getIt.registerLazySingleton<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(getIt<BaseCategoryRepository>()),
  );

  getIt.registerLazySingleton<UploadCategoriesUseCase>(
    () => UploadCategoriesUseCase(repository: getIt<BaseCategoryRepository>()),
  );

  getIt.registerLazySingleton<UploadCategoryImageUseCase>(
    () =>
        UploadCategoryImageUseCase(repository: getIt<BaseCategoryRepository>()),
  );

  getIt.registerLazySingleton<GetBannersUseCase>(
    () => GetBannersUseCase(repository: getIt<BaseBannerRepository>()),
  );

  getIt.registerLazySingleton<UploadBannersUseCase>(
    () => UploadBannersUseCase(repository: getIt<BaseBannerRepository>()),
  );

  getIt.registerLazySingleton<UploadBannerImageUseCase>(
    () => UploadBannerImageUseCase(repository: getIt<BaseBannerRepository>()),
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
      deleteAccountUseCase: getIt<DeleteAccountUseCase>(),
      reAuthenticateUseCase: getIt<ReAuthenticateUseCase>(),
      loginWithGoogleUseCase: getIt<LoginWithGoogleUseCase>(),
      uploadImageUseCase: getIt<UploadImageUseCase>(),
    ),
  );

  getIt.registerFactory<CategoryCubit>(
    () => CategoryCubit(
      getIt<GetCategoriesUseCase>(),
      getIt<UploadCategoriesUseCase>(),
      getIt<UploadCategoryImageUseCase>(),
    ),
  );

  getIt.registerFactory<BannerCubit>(
    () => BannerCubit(
      getIt<GetBannersUseCase>(),
      getIt<UploadBannersUseCase>(),
      getIt<UploadBannerImageUseCase>(),
    ),
  );

  // Product
  getIt.registerLazySingleton<BaseProductDataSource>(() => ProductDataSource());
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(dataSource: getIt()),
  );

  getIt.registerLazySingleton(
    () => FetchFeaturedProductsUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton(
    () => GetProductsForCategoryUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton(() => UploadProductsUseCase(repository: getIt()));
  getIt.registerLazySingleton(
    () => UploadProductImageUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton(
    () => UploadProductCategoriesUseCase(repository: getIt()),
  );

  getIt.registerFactory(
    () => ProductCubit(getIt(), getIt(), getIt(), getIt(), getIt()),
  );

  // All Products
  getIt.registerLazySingleton<BaseAllProductsDataSource>(
    () => AllProductsDataSource(),
  );
  getIt.registerLazySingleton<BaseAllProductRepository>(
    () => AllProductRepository(dataSource: getIt()),
  );

  getIt.registerLazySingleton(
    () => GetProductsByQueryUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton(
    () => GetAllFeaturedProductsUseCase(repository: getIt()),
  );

  getIt.registerFactory(
    () => AllProductsCubit(
      getProductsByQueryUseCase: getIt(),
      getAllFeaturedProductsUseCase: getIt(),
    ),
  );

  // Brand
  getIt.registerLazySingleton<BaseBrandDataSource>(() => BrandDataSource());
  getIt.registerLazySingleton<BaseBrandRepository>(
    () => BrandRepositoryImpl(baseBrandDataSource: getIt()),
  );
  getIt.registerLazySingleton(() => GetBrandsUseCase(getIt()));
  getIt.registerLazySingleton(
    () => GetBrandProductsUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton(
    () => GetBrandsForCategoryUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton(() => UploadBrandsUseCase(repository: getIt()));
  getIt.registerLazySingleton(
    () => UploadBrandImageUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton(
    () => UploadBrandCategoriesUseCase(repository: getIt()),
  );
  getIt.registerFactory(
    () => BrandCubit(getIt(), getIt(), getIt(), getIt(), getIt(), getIt()),
  );
}

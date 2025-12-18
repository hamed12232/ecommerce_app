import 'package:ecommerce_app/core/utils/helper/network_manager.dart';
import 'package:ecommerce_app/core/utils/services/shared_pref.dart';
import 'package:ecommerce_app/features/auth/data/models/user_model.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/login_with_google_usecase.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/save_user_record_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  final LoginWithGoogleUseCase loginWithGoogleUseCase;
  final SaveUserRecordUseCase saveUserRecordUseCase;

  LoginCubit(
    this.loginUseCase,
    this.loginWithGoogleUseCase,
    this.saveUserRecordUseCase,
  ) : super(const LoginState()) {
    _loadSavedCredentials();
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void _loadSavedCredentials() {
    if (SharedPrefServices.isRememberMe()) {
      final email = SharedPrefServices.getEmail();
      final password = SharedPrefServices.getPassword();
      emailController.text = email;
      passwordController.text = password;
      emit(
        state.copyWith(isRememberMe: true, email: email, password: password),
      );
    }
  }

  void toggleRememberMe() {
    emit(state.copyWith(isRememberMe: !state.isRememberMe));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  Future<void> login() async {
    final isInternetConnected = await NetworkManager.instance.isConnected();
    if (!isInternetConnected) {
      emit(
        state.copyWith(
          status: LoginStatus.error,
          error: 'No Internet Connection',
        ),
      );
      return;
    }
    if (!formKey.currentState!.validate()) return;
    emit(state.copyWith(status: LoginStatus.loading));

    final result = await loginUseCase.call(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(status: LoginStatus.error, error: failure.message),
      ),
      (userCredential) {
        if (state.isRememberMe) {
          SharedPrefServices.saveRemeberMe(
            emailController.text.trim(),
            passwordController.text.trim(),
          );
        } else {
          SharedPrefServices.removeRememberMe();
        }
        emit(state.copyWith(status: LoginStatus.success));
      },
    );
  }

  Future<void> loginWithGoogle() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        emit(
          state.copyWith(
            status: LoginStatus.error,
            error: 'No Internet Connection',
          ),
        );
        return;
      }

      emit(state.copyWith(status: LoginStatus.loading));

      final result = await loginWithGoogleUseCase();

      result.fold(
        (failure) => emit(
          state.copyWith(status: LoginStatus.error, error: failure.message),
        ),
        (userCredential) async {
          if (userCredential.user != null) {
            await _saveUserRecord(userCredential);
          }
          emit(state.copyWith(status: LoginStatus.success));
        },
      );
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.error, error: e.toString()));
    }
  }

  Future<void> _saveUserRecord(dynamic userCredential) async {
    try {
      final user = userCredential.user;
      if (user != null) {
        final nameParts = UserModel.nameParts(user.displayName ?? '');
        final username = UserModel.generateUsername(user.displayName ?? '');

        final userModel = UserModel(
          id: user.uid,
          firstName: nameParts[0],
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
          username: username,
          email: user.email ?? '',
          phone: user.phoneNumber ?? '',
          profileImage: user.photoURL ?? '',
          password: '', // Password is not available for Google Sign-In
        );

        await saveUserRecordUseCase(userModel);
      }
    } catch (e) {
      // Log error or handle silently as login shouldn't fail if saving record fails
      print('Error saving user record: $e');
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}

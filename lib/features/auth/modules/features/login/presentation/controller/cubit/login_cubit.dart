import 'package:ecommerce_app/core/utils/helper/network_manager.dart';
import 'package:ecommerce_app/core/utils/services/shared_pref.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginUseCase) : super(const LoginState()) {
    _loadSavedCredentials();
  }

  final LoginUseCase loginUseCase;

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

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}

part of 'login_cubit.dart';

enum LoginStatus { initial, loading, success, error }

class LoginState {
  final LoginStatus status;
  final String? error;
  final bool isRememberMe;
  final bool isPasswordVisible;
  final String email;
  final String password;

  const LoginState({
    this.status = LoginStatus.initial,
    this.error,
    this.isRememberMe = false,
    this.isPasswordVisible = true,
    this.email = '',
    this.password = '',
  });

  LoginState copyWith({
    LoginStatus? status,
    String? error,
    bool? isRememberMe,
    bool? isPasswordVisible,
    String? email,
    String? password,
  }) {
    return LoginState(
      status: status ?? this.status,
      error: error ?? this.error,
      isRememberMe: isRememberMe ?? this.isRememberMe,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}

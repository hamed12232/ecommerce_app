part of 'sign_up_cubit.dart';

enum SignUpStatus { initial, loading, success, error }

class SignUpState {
  final SignUpStatus status;
  final String? error;
  final bool agreePolicy;

  SignUpState({
    this.status = SignUpStatus.initial,
    this.error,
    this.agreePolicy = false,
  });

  SignUpState copyWith({
    SignUpStatus? status,
    String? error,
    bool? agreePolicy,
  }) {
    return SignUpState(
      status: status ?? this.status,
      error: error ?? this.error,
      agreePolicy: agreePolicy ?? this.agreePolicy,
    );
  }
}

part of 'sign_up_cubit.dart';

enum SignUpStatus { initial, loading, success, error }

class SignUpState {
  final SignUpStatus status;
  final String? error;

  SignUpState({this.status = SignUpStatus.initial, this.error});

  SignUpState copyWith({SignUpStatus? status, String? error}) {
    return SignUpState(status: status ?? this.status, error: error ?? this.error);
  }
  
}

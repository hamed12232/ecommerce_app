import 'package:equatable/equatable.dart';

enum ForgetPasswordStatus { initial, loading, success, error }

class ForgetPasswordState extends Equatable {
  final ForgetPasswordStatus status;
  final String? error;

  const ForgetPasswordState({
    this.status = ForgetPasswordStatus.initial,
    this.error,
  });

  ForgetPasswordState copyWith({ForgetPasswordStatus? status, String? error}) {
    return ForgetPasswordState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, error];
}

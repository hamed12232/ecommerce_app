part of 'verify_email_cubit.dart';

enum VerifyEmailStatus { initial, loading, emailSent, verified, error }

class VerifyEmailState {
  final VerifyEmailStatus status;
  final String? error;

  const VerifyEmailState({this.status = VerifyEmailStatus.initial, this.error});

  VerifyEmailState copyWith({VerifyEmailStatus? status, String? error}) {
    return VerifyEmailState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}

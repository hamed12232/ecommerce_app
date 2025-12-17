import 'dart:async';

import 'package:ecommerce_app/features/auth/domain/usecases/send_email_verification_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verify_email_state.dart';

class VerifyEmailCubit extends Cubit<VerifyEmailState> {
  VerifyEmailCubit(this.sendEmailVerificationUseCase)
    : super(const VerifyEmailState());

  final SendEmailVerificationUseCase sendEmailVerificationUseCase;

  Timer? _timer;

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  Future<void> sendEmailVerification() async {
    emit(state.copyWith(status: VerifyEmailStatus.loading));
    final result = await sendEmailVerificationUseCase.call();
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: VerifyEmailStatus.error,
            error: failure.message,
          ),
        );
      },
      (_) {
        emit(state.copyWith(status: VerifyEmailStatus.emailSent));
      },
    );
  }

  void setTimerForAutoRedirect() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        emit(state.copyWith(status: VerifyEmailStatus.verified));
      }
    });
  }

  void checkEmailVerificationStatus() async {
    await FirebaseAuth.instance.currentUser?.reload();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && user.emailVerified) {
      emit(state.copyWith(status: VerifyEmailStatus.verified));
    }
  }
}

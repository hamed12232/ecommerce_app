import 'package:ecommerce_app/features/auth/domain/usecases/send_password_reset_email_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final SendPasswordResetEmailUseCase sendPasswordResetEmailUseCase;

  ForgetPasswordCubit(this.sendPasswordResetEmailUseCase)
    : super(const ForgetPasswordState());

  Future<void> sendPasswordResetEmail(String email) async {
    emit(state.copyWith(status: ForgetPasswordStatus.loading));

    final result = await sendPasswordResetEmailUseCase(email);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ForgetPasswordStatus.error,
          error: failure.message,
        ),
      ),
      (_) => emit(state.copyWith(status: ForgetPasswordStatus.success)),
    );
  }
}

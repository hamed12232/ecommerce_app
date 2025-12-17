import 'package:ecommerce_app/core/utils/helper/network_manager.dart';
import 'package:ecommerce_app/features/auth/data/models/user_model.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/save_user_record_usecase.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.signUpUseCase, this.saveUserRecordUseCase)
    : super(SignUpState());

  final SignUpUseCase signUpUseCase;
  final SaveUserRecordUseCase saveUserRecordUseCase;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void toggleAgreePolicy(bool value) {
    emit(state.copyWith(agreePolicy: value));
  }

  Future<void> signUp() async {
    try {
      emit(state.copyWith(status: SignUpStatus.loading));
      final isInternetConnected = await NetworkManager.instance.isConnected();
      if (!isInternetConnected) {
        emit(
          state.copyWith(
            status: SignUpStatus.error,
            error: 'No Internet Connection',
          ),
        );
        return;
      }
      if (!formKey.currentState!.validate()) {
        emit(
          state.copyWith(
            status: SignUpStatus.error,
            error: 'Please fill all fields correctly',
          ),
        );
        return;
      }

      // Validate privacy policy agreement
      if (!state.agreePolicy) {
        emit(
          state.copyWith(
            status: SignUpStatus.error,
            error: 'Please agree to Privacy Policy and Terms of use',
          ),
        );
        return;
      }

      final signUpResult = await signUpUseCase.call(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await signUpResult.fold(
        (failure) async {
          emit(
            state.copyWith(status: SignUpStatus.error, error: failure.message),
          );
        },
        (userCredential) async {
          final userModel = UserModel(
            id: userCredential.user!.uid,
            firstName: firstNameController.text.trim(),
            lastName: lastNameController.text.trim(),
            username: usernameController.text.trim(),
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
            phone: phoneController.text.trim(),
            profileImage: '', // Empty for now, can be updated later
          );
          final saveResult = await saveUserRecordUseCase.call(userModel);
          saveResult.fold(
            (failure) {
              emit(
                state.copyWith(
                  status: SignUpStatus.error,
                  error: failure.message,
                ),
              );
            },
            (_) {
              emit(state.copyWith(status: SignUpStatus.success));
            },
          );
        },
      );
    } catch (e) {
      emit(state.copyWith(status: SignUpStatus.error, error: e.toString()));
    }
  }

  @override
  Future<void> close() {
    // Dispose controllers
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    return super.close();
  }
}

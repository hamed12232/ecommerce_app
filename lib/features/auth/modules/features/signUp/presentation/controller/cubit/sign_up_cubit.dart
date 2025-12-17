import 'package:ecommerce_app/core/utils/constant/image_strings.dart';
import 'package:ecommerce_app/core/utils/helper/network_manager.dart';
import 'package:ecommerce_app/core/utils/popups/full_screen_loader.dart';
import 'package:ecommerce_app/core/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void signUp(BuildContext context) async {
    AppFullScreenLoader.openLoadingDialog(
      'We Are Processing Your Data...',
      AppImages.docerAnimation,
      context,
    );
    final isInternetConnected = await NetworkManager.instance.isConnected();
    if (!isInternetConnected) {
      AppLoaders.customToast(
        message: 'No Internet Connection',
        context: context,
      );
      AppFullScreenLoader.stopLoading(context);
      return;
    }
    if (formKey.currentState!.validate()) {
      AppFullScreenLoader.stopLoading(context);
      return;
    }
  }
}

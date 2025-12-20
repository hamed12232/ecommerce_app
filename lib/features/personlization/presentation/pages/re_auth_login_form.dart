import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/constant/text_strings.dart';
import 'package:ecommerce_app/core/utils/validators/validation.dart';
import 'package:ecommerce_app/features/personlization/presentation/controller/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class ReAuthLoginForm extends StatefulWidget {
  const ReAuthLoginForm({super.key});
  static const String routeName = 're_auth_login_form';

  @override
  State<ReAuthLoginForm> createState() => _ReAuthLoginFormState();
}

class _ReAuthLoginFormState extends State<ReAuthLoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _hidePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Re-Authenticate User')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Text
                const Text(
                  'Please enter your credentials to verify your identity and proceed with account deletion.',
                ),
                const SizedBox(height: AppSizes.spaceBtwSections),

                /// Email
                TextFormField(
                  controller: _emailController,
                  validator: (value) => Validator.validateEmail(value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.direct_right),
                    labelText: AppTextStrings.email,
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwInputFields),

                /// Password
                TextFormField(
                  controller: _passwordController,
                  validator: (value) =>
                      Validator.validateEmptyText('Password', value),
                  obscureText: _hidePassword,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.password_check),
                    labelText: AppTextStrings.password,
                    suffixIcon: IconButton(
                      onPressed: () =>
                          setState(() => _hidePassword = !_hidePassword),
                      icon: Icon(
                        _hidePassword ? Iconsax.eye_slash : Iconsax.eye,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwSections),

                /// Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context
                            .read<UserCubit>()
                            .reAuthenticateEmailAndPasswordUser(
                              _emailController.text.trim(),
                              _passwordController.text.trim(),
                            );
                      }
                    },
                    child: const Text('Verify'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

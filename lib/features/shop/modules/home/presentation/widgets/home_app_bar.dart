import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/text_strings.dart';
import 'package:ecommerce_app/core/widgets/cart_menu_icon.dart';
import 'package:ecommerce_app/features/personlization/presentation/controller/cubit/user_cubit.dart';
import 'package:ecommerce_app/features/personlization/presentation/controller/cubit/user_model_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserModelState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppTextStrings.homeAppbarTitle,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.apply(color: AppColors.grey),
                ),
                Text(
                  state.user.username,
                  style: Theme.of(
                    context,
                  ).textTheme.headlineMedium!.apply(color: AppColors.white),
                ),
              ],
            ),
            const CartMenuIcon(),
          ],
        );
      },
    );
  }
}

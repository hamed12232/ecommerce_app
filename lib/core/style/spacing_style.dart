import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:flutter/widgets.dart';

class SpacingStyle {
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: AppSizes.appBarHeight,
    left: AppSizes.defaultSpace,
    bottom: AppSizes.defaultSpace,
    right: AppSizes.defaultSpace,
  );
  static const EdgeInsets defaultPadding = EdgeInsets.only(
    left: AppSizes.defaultSpace,
    right: AppSizes.defaultSpace,
    bottom: AppSizes.defaultSpace,
  );

  static const EdgeInsets defaultPaddingWithTop = EdgeInsets.only(
    left: AppSizes.defaultSpace,
    right: AppSizes.defaultSpace,
    bottom: AppSizes.defaultSpace,
    top: AppSizes.appBarHeight,
  );
}

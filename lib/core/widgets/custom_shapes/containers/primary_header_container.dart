  import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:flutter/material.dart';
import '../curved_edges/curved_edges_widget.dart';
import 'circular_container.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TCurvedEdgesWidget(
      child: Container(
        color: AppColors.dashboardAppbarBackground,
        padding: const EdgeInsets.only(bottom: 0),
        /// -- If [size.isFinite': is not true.in Stack] error occurred -> Read README.md file at [DESIGN ERRORS] # 1
        child: Stack(
          children: [
            /// -- Background Custom Shapes
            Positioned(
                top: -150, right: -250, child: TCircularContainer(backgroundColor: AppColors.textWhite.withValues(alpha: 0.1))),
            Positioned(
                top: 100, right: -300, child: TCircularContainer(backgroundColor: AppColors.textWhite.withValues(alpha: 0.1))),
            child,
          ],
        ),
      ),
    );
  }
}

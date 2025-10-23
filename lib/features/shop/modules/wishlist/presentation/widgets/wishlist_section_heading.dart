import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class WishlistSectionHeading extends StatelessWidget {
  const WishlistSectionHeading({
    super.key,
    this.onPressed,
    this.textColor,
    required this.title,
  });
  final String title;

  final Color? textColor;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.displayMedium!.apply(color: textColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        IconButton(onPressed: () {}, icon: const Icon(Iconsax.add)),
      ],
    );
  }
}

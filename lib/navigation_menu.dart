import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/features/personlization/presentation/pages/profile_screen.dart';
import 'package:ecommerce_app/features/shop/modules/home/presentation/pages/home_screen.dart';
import 'package:ecommerce_app/features/shop/modules/store/presentation/screen/store_screen.dart';
import 'package:ecommerce_app/features/shop/modules/wishlist/presentation/pages/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  static const String routeName = '/home';

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const HomeScreen(),
    const StoreScreen(),
    const WishlistScreen(),
    const ProfileScreen(),
  ];
  final items = [
    {'icon': Iconsax.home_1, 'label': 'Home'},
    {'icon': Iconsax.shop, 'label': 'Store'},
    {'icon': Iconsax.heart, 'label': 'Wishlist'},
    {'icon': Iconsax.user, 'label': 'Profile'},
  ];
  @override
  Widget build(BuildContext context) {
    final screenWidth = AppHelperFunctions.screenWidth(context);
    final itemWidth = screenWidth / items.length;

    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: bottomNavigatorBar(context, itemWidth),
    );
  }

  Widget bottomNavigatorBar(BuildContext context, double itemWidth) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: SizedBox(
        height: 70,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            final isActive = index == _selectedIndex;

            return SizedBox(
              width: itemWidth,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => setState(() => _selectedIndex = index),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOutCubic,
                      padding: isActive
                          ? const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            )
                          : const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: isActive
                            // ignore: deprecated_member_use
                            ? AppColors.darkGrey.withOpacity(0.3)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        item['icon'] as IconData,
                        size: AppSizes.iconMd,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item['label'] as String,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

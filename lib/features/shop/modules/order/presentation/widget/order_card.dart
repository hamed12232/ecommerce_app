import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
// import 'package:ecommerce_app/core/utils/helper/helper_functions.dart'; // <-- لم نعد بحاجة لهذا
import 'package:ecommerce_app/features/shop/modules/order/presentation/widget/info_column.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class OrderCard extends StatelessWidget {
  final String status;
  final String orderDate;
  final String orderNumber;
  final String shippingDate;
  final IconData statusIcon;
  final Color statusColor;

  const OrderCard({
    super.key,
    required this.status,
    required this.orderDate,
    required this.orderNumber,
    required this.shippingDate,
    required this.statusIcon,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    // --- التغييرات هنا ---
    final theme = Theme.of(context);
    final isDarkMode = AppHelperFunctions.isDarkMode(context);
    // --- نهاية التغييرات ---

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        // --- التغيير هنا ---
        color: isDarkMode ? AppColors.dark : AppColors.grey10,
        // --- نهاية التغيير ---
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Status, Date, and Arrow
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(statusIcon, color: statusColor, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      status,
                      style: Theme.of(context).textTheme.titleLarge
                          ?.copyWith(color: AppColors.primary),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      orderDate,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        // --- التغيير هنا ---
                        // استبدلنا اللون الثابت بلون الثيم الأساسي للنصوص
                        color: theme.colorScheme.onSurface,
                        // --- نهاية التغيير ---
                      ),
                    ),
                  ],
                ),
              ),
              // Right arrow icon
              Icon(
                Iconsax.arrow_right_3,
                size: 20,
                // --- التغيير هنا ---
                // استبدلنا اللون الثابت بلون الثيم للحدود والأيقونات الثانوية
                color: theme.colorScheme.outline,
                // --- نهاية التغيير ---
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Bottom Row: Order # and Shipping Date
          Row(
            // Use spaceBetween to push them to opposite ends
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Order Number Column
              InfoColumn(
                // Location/pin icon
                icon: Iconsax.location,
                label: 'Order',
                value: orderNumber,
              ),
              // Shipping Date Column
              InfoColumn(
                // Calendar icon
                icon: Iconsax.calendar,
                label: 'Shipping Date',
                value: shippingDate,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

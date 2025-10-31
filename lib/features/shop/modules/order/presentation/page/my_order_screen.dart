import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/features/shop/modules/order/presentation/widget/order_card.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle:false,
        leading: IconButton(
          // Back arrow
          icon: const Icon(Iconsax.arrow_left_2),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title:  Text('My Orders',style: Theme.of(  context).textTheme.headlineMedium,
      ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          // First Card
          OrderCard(
            status: 'Processing',
            orderDate: '01 Sep 2023',
            orderNumber: 'CWT0012',
            shippingDate: '09 Sep 2023',
            // Icon for "Processing" (looks like a shopping bag/lock)
            statusIcon: Iconsax.shopping_bag,
            statusColor: Color.fromARGB(255, 28, 34, 62), // Purple/Blue color
          ),
          SizedBox(height: 16), // Spacing between cards
          // Second Card
          OrderCard(
            status: 'Shipment on the way',
            orderDate: '02 Oct 2023',
            orderNumber: 'CWT0025',
            shippingDate: '06 Oct 2023',
            // Icon for "Shipment"
            statusIcon: Iconsax.truck,
            statusColor: AppColors.primary, // Purple/Blue color
          ),
        ],
      ),
    );
  }
}

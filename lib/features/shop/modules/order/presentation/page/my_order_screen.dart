import 'package:ecommerce_app/core/utils/constant/dummy_data.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/popups/loaders.dart';
import 'package:ecommerce_app/features/shop/modules/order/presentation/controller/cubit/order_cubit.dart';
import 'package:ecommerce_app/features/shop/modules/order/presentation/controller/cubit/order_state.dart';
import 'package:ecommerce_app/features/shop/modules/order/presentation/widget/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  static const String routeName = '/my_orders';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'My Orders',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: BlocConsumer<OrderCubit, OrderState>(
        listener: (context, state) {
          if (state.listStatus == OrderListStatus.error) {
            AppLoaders.errorSnackBar(
              title: state.error ?? 'Failed to load orders',
              context: context,
            );
          }
        },
        builder: (context, state) {
          if (state.listStatus == OrderListStatus.loading ||
              state.listStatus == OrderListStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.orders.isEmpty) {
            return Center(
              child: Text(
                'No orders yet',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(AppSizes.defaultSpace),
            itemCount: state.orders.length,
            separatorBuilder: (_, __) =>
                const SizedBox(height: AppSizes.spaceBtwItems),
            itemBuilder: (context, index) {
              final order = state.orders[index];
              return OrderCard(
                status: order.orderStatusText,
                orderDate: order.formattedOrderDate,
                orderNumber: order.id,
                shippingDate: order.formattedDeliveryDate,
                statusIcon: getStatusIcon(order.status),
                statusColor: getStatusColor(order.status),
              );
            },
          );
        },
      ),
    );
  }
}

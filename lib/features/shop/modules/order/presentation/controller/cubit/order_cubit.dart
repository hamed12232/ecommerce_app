import 'package:ecommerce_app/features/shop/modules/cart/data/models/cart_item_model.dart';
import 'package:ecommerce_app/features/shop/modules/order/data/models/order_model.dart';
import 'package:ecommerce_app/features/shop/modules/order/domain/usecases/fetch_user_orders_usecase.dart';
import 'package:ecommerce_app/features/shop/modules/order/domain/usecases/save_order_usecase.dart';
import 'package:ecommerce_app/features/shop/modules/order/presentation/controller/cubit/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit({
    required this.saveOrderUseCase,
    required this.fetchUserOrdersUseCase,
  }) : super(const OrderState());

  final SaveOrderUseCase saveOrderUseCase;
  final FetchUserOrdersUseCase fetchUserOrdersUseCase;

  /// Save a new order from the current cart items.
  Future<void> processOrder({
    required List<CartItemModel> items,
    required double totalAmount,
    String paymentMethod = 'Paypal',
    String? address,
  }) async {
    emit(state.copyWith(saveStatus: SaveOrderStatus.loading));

    final order = OrderModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      status: OrderStatus.processing,
      totalAmount: totalAmount,
      orderDate: DateTime.now(),
      deliveryDate: DateTime.now().add(const Duration(days: 7)),
      paymentMethod: paymentMethod,
      address: address,
      items: items,
    );

    final result = await saveOrderUseCase(order);
    result.fold(
      (failure) => emit(
        state.copyWith(
          saveStatus: SaveOrderStatus.error,
          error: failure.message,
        ),
      ),
      (_) {
        emit(state.copyWith(saveStatus: SaveOrderStatus.success));
        // Reset save status so it can be used again
        emit(state.copyWith(saveStatus: SaveOrderStatus.initial));
      },
    );
  }

  /// Fetch all orders for the current user.
  Future<void> fetchUserOrders() async {
    emit(state.copyWith(listStatus: OrderListStatus.loading));
    final result = await fetchUserOrdersUseCase();
    result.fold(
      (failure) => emit(
        state.copyWith(
          listStatus: OrderListStatus.error,
          error: failure.message,
        ),
      ),
      (orders) => emit(
        state.copyWith(listStatus: OrderListStatus.loaded, orders: orders),
      ),
    );
  }
}

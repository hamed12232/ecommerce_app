import 'package:ecommerce_app/features/shop/modules/order/data/models/order_model.dart';

enum OrderListStatus { initial, loading, loaded, error }

enum SaveOrderStatus { initial, loading, success, error }

class OrderState {
  const OrderState({
    this.listStatus = OrderListStatus.initial,
    this.saveStatus = SaveOrderStatus.initial,
    this.orders = const [],
    this.error,
  });

  final OrderListStatus listStatus;
  final SaveOrderStatus saveStatus;
  final List<OrderModel> orders;
  final String? error;

  OrderState copyWith({
    OrderListStatus? listStatus,
    SaveOrderStatus? saveStatus,
    List<OrderModel>? orders,
    String? error,
  }) {
    return OrderState(
      listStatus: listStatus ?? this.listStatus,
      saveStatus: saveStatus ?? this.saveStatus,
      orders: orders ?? this.orders,
      error: error ?? this.error,
    );
  }
}

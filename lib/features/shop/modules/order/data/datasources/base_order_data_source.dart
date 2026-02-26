import 'package:ecommerce_app/features/shop/modules/order/data/models/order_model.dart';

abstract class BaseOrderDataSource {
  Future<void> saveOrder(OrderModel order);
  Future<List<OrderModel>> fetchUserOrders();
}

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/order/data/models/order_model.dart';

abstract class BaseOrderRepository {
  Future<Either<Exceptions, void>> saveOrder(OrderModel order);
  Future<Either<Exceptions, List<OrderModel>>> fetchUserOrders();
}

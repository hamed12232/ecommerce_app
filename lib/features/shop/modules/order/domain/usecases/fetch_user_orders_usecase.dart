import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/order/data/models/order_model.dart';
import 'package:ecommerce_app/features/shop/modules/order/domain/repositories/base_order_repository.dart';

class FetchUserOrdersUseCase {
  FetchUserOrdersUseCase({required this.repository});

  final BaseOrderRepository repository;

  Future<Either<Exceptions, List<OrderModel>>> call() {
    return repository.fetchUserOrders();
  }
}

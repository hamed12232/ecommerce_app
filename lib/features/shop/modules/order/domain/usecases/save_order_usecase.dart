import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/order/data/models/order_model.dart';
import 'package:ecommerce_app/features/shop/modules/order/domain/repositories/base_order_repository.dart';

class SaveOrderUseCase {
  SaveOrderUseCase({required this.repository});

  final BaseOrderRepository repository;

  Future<Either<Exceptions, void>> call(OrderModel order) {
    return repository.saveOrder(order);
  }
}

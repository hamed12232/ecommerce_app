import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/core/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_app/core/utils/exceptions/platform_exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/order/data/datasources/base_order_data_source.dart';
import 'package:ecommerce_app/features/shop/modules/order/data/models/order_model.dart';
import 'package:ecommerce_app/features/shop/modules/order/domain/repositories/base_order_repository.dart';

class OrderRepositoryImpl implements BaseOrderRepository {
  OrderRepositoryImpl({required this.dataSource});

  final BaseOrderDataSource dataSource;

  @override
  Future<Either<Exceptions, void>> saveOrder(OrderModel order) async {
    try {
      await dataSource.saveOrder(order);
      return const Right(null);
    } on AppFirebaseException catch (e) {
      return Left(Exceptions(e.message));
    } on AppPlatformException catch (e) {
      return Left(Exceptions(e.message));
    } catch (e) {
      return Left(Exceptions(e.toString()));
    }
  }

  @override
  Future<Either<Exceptions, List<OrderModel>>> fetchUserOrders() async {
    try {
      final orders = await dataSource.fetchUserOrders();
      return Right(orders);
    } on AppFirebaseException catch (e) {
      return Left(Exceptions(e.message));
    } on AppPlatformException catch (e) {
      return Left(Exceptions(e.message));
    } catch (e) {
      return Left(Exceptions(e.toString()));
    }
  }
}

import 'package:dartz/dartz.dart';

import '../../domain/entities/order.dart' as order;
import '../../domain/repositories/i_order_repository.dart';
import '../../errors/order_errors.dart';
import '../datasources/i_order_datasource.dart';
import '../models/order_model.dart';

class OrderRepositoryImpl implements IOrderRepository {
  final IOrderDatasource _orderDatasource;

  OrderRepositoryImpl(this._orderDatasource);

  @override
  Future<Either<OrderError, order.Order>> cancel(order.Order order) async {
    try {
      final result =
          await _orderDatasource.cancel(OrderModel.fromOrder(order: order));

      return Right(result);
    } on OrderError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(OrderError(e.toString()));
    }
  }

  @override
  Future<Either<OrderError, List<order.Order>>> getOrders() async {
    try {
      final result = await _orderDatasource.getOrders();

      _orderDatasource.sortOrderList(result);

      return Right(result);
    } on OrderError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(OrderError(e.toString()));
    }
  }
}

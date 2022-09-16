import 'package:dartz/dartz.dart';

import '../../errors/order_errors.dart';
import '../entities/order.dart' as order;

abstract class IOrderUsecase {
  Future<Either<OrderError, order.Order>> cancel(order.Order order);

  Future<Either<OrderError, List<order.Order>>> getOrders();

  Future<Either<OrderError, List<order.Order>>> getOrdersByDay(DateTime day);
}

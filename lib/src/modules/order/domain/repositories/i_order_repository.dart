import 'package:dartz/dartz.dart';

import '../../errors/order_errors.dart';
import '../entities/enums/order_status_enum.dart';
import '../entities/order.dart' as order;

abstract class IOrderRepository {
  Future<Either<OrderError, order.Order>> changeOrderStatus(
      order.Order order, OrderStatus status);

  Future<Either<OrderError, List<order.Order>>> getOrders();

  Future<Either<OrderError, List<order.Order>>> getOrdersByDay(DateTime day);
}

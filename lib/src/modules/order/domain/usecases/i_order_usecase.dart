import 'package:cardapio_manager/src/modules/order/domain/entities/enums/order_status_enum.dart';
import 'package:dartz/dartz.dart';

import '../../errors/order_errors.dart';
import '../entities/order.dart' as order;

abstract class IOrderUsecase {
  Future<Either<OrderError, order.Order>> changeOrderStatus(
      order.Order order, OrderStatus status);

  Future<Either<OrderError, List<order.Order>>> getOrders();

  Future<Either<OrderError, List<order.Order>>> getOrdersByDay(DateTime day);

  Future<Either<OrderError, List<order.Order>>> getOrdersByDayAndStatus(DateTime day, OrderStatus status);
}

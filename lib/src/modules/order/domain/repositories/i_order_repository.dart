import 'package:cardapio_manager/src/modules/core/reports/domain/entities/order_sum_report.dart';
import 'package:dartz/dartz.dart';

import '../../errors/order_errors.dart';
import '../entities/enums/order_status_enum.dart';
import '../entities/order.dart' as order;

abstract class IOrderRepository {
  Future<Either<OrderError, order.Order>> changeOrderStatus(
      order.Order order, OrderStatus status);

  Future<Either<OrderError, bool>> changeOrderListStatus(
      List<order.Order> orderList, OrderStatus status);

  Future<Either<OrderError, List<order.Order>>> getOrders();

  Future<Either<OrderError, List<order.Order>>> getOrdersByDay(DateTime day);

  Future<Either<OrderError, List<order.Order>>> getOrdersByDayAndStatus(
      DateTime day, OrderStatus status);

  Future<Either<OrderError, List<order.Order>>>
      getOrdersByDayAndStatusAndReport(
          DateTime day, OrderStatus status, OrderSumReport report);

  Future<Either<OrderError, List<order.Order>>> getOrdersByDayAndReport(
      DateTime day, OrderSumReport report);
}

import 'package:cardapio_manager/src/modules/core/reports/domain/entities/order_sum_report.dart';
import 'package:cardapio_manager/src/modules/order/domain/entities/enums/order_status_enum.dart';
import 'package:dartz/dartz.dart';

import '../../../errors/order_errors.dart';
import '../../entities/order.dart' as order;
import '../../repositories/i_order_repository.dart';
import '../i_order_usecase.dart';

class OrderUsecaseImpl implements IOrderUsecase {
  final IOrderRepository _repository;

  OrderUsecaseImpl(this._repository);

  @override
  Future<Either<OrderError, order.Order>> changeOrderStatus(
      order.Order order, OrderStatus status) async {
    if (order.status == status) {
      return Left(OrderError('Order Already $status'));
    }

    if (order.id.isEmpty) {
      return Left(OrderError('ID cannot be empty'));
    }

    return _repository.changeOrderStatus(order, status);
  }

  @override
  Future<Either<OrderError, bool>> changeOrderListStatus(
      List<order.Order> orderList, OrderStatus status) async {
    for (var order in orderList) {
      if (order.status == status) {
        return Left(OrderError('Order Already $status'));
      }

      if (order.id.isEmpty) {
        return Left(OrderError('ID cannot be empty'));
      }
    }

    return _repository.changeOrderListStatus(orderList, status);
  }

  @override
  Future<Either<OrderError, List<order.Order>>> getOrders() async {
    return _repository.getOrders();
  }

  @override
  Future<Either<OrderError, List<order.Order>>> getOrdersByDay(
      DateTime day) async {
    return _repository.getOrdersByDay(day);
  }

  @override
  Future<Either<OrderError, List<order.Order>>> getOrdersByDayAndStatus(
      DateTime day, OrderStatus status) {
    return _repository.getOrdersByDayAndStatus(day, status);
  }

  @override
  Future<Either<OrderError, List<order.Order>>> getOrdersByDayAndReport(
      DateTime day, OrderSumReport report) async {
    return _repository.getOrdersByDayAndReport(day, report);
  }

  @override
  Future<Either<OrderError, List<order.Order>>>
      getOrdersByDayAndStatusAndReport(
          DateTime day, OrderStatus status, OrderSumReport report) async {
    return _repository.getOrdersByDayAndStatusAndReport(day, status, report);
  }
}

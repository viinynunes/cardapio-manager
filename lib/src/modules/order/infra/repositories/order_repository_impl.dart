import 'package:cardapio_manager/src/modules/core/reports/domain/entities/order_sum_report.dart';
import 'package:dartz/dartz.dart';

import '../../../core/reports/infra/models/order_sum_report_model.dart';
import '../../domain/entities/enums/order_status_enum.dart';
import '../../domain/entities/order.dart' as order;
import '../../domain/repositories/i_order_repository.dart';
import '../../errors/order_errors.dart';
import '../datasources/i_order_datasource.dart';
import '../models/order_model.dart';

class OrderRepositoryImpl implements IOrderRepository {
  final IOrderDatasource _orderDatasource;

  OrderRepositoryImpl(this._orderDatasource);

  @override
  Future<Either<OrderError, order.Order>> changeOrderStatus(
      order.Order order, OrderStatus status) async {
    try {
      final result = await _orderDatasource.changeOrderStatus(
          OrderModel.fromOrder(order: order), status);

      return Right(result);
    } on OrderError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(OrderError(e.toString()));
    }
  }

  @override
  Future<Either<OrderError, bool>> changeOrderListStatus(
      List<order.Order> orderList, OrderStatus status) async {
    try {
      final result = await _orderDatasource.changeOrderListStatus(
          orderList.map((e) => OrderModel.fromOrder(order: e)).toList(),
          status);

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

      return Right(result);
    } on OrderError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(OrderError(e.toString()));
    }
  }

  @override
  Future<Either<OrderError, List<order.Order>>> getOrdersByDay(
      DateTime day) async {
    try {
      final result = await _orderDatasource.getOrdersByDay(day);

      return Right(result);
    } on OrderError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(OrderError(e.toString()));
    }
  }

  @override
  Future<Either<OrderError, List<order.Order>>> getOrdersByDayAndStatus(
      DateTime day, OrderStatus status) async {
    try {
      final result =
          await _orderDatasource.getOrdersByDayAndStatus(day, status);

      return Right(result);
    } on OrderError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(OrderError(e.toString()));
    }
  }

  @override
  Future<Either<OrderError, List<order.Order>>> getOrdersByDayAndReport(
      DateTime day, OrderSumReport report) async {
    try {
      final result = await _orderDatasource.getOrdersByDayAndReport(
          day, OrderSumReportModel.fromOrderSumReport(orderSumReport: report));

      return Right(result);
    } on OrderError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(OrderError(e.toString()));
    }
  }

  @override
  Future<Either<OrderError, List<order.Order>>>
      getOrdersByDayAndStatusAndReport(
          DateTime day, OrderStatus status, OrderSumReport report) async {
    try {
      final result = await _orderDatasource.getOrdersByDayAndStatusAndReport(
          day,
          status,
          OrderSumReportModel.fromOrderSumReport(orderSumReport: report));

      return Right(result);
    } on OrderError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(OrderError(e.toString()));
    }
  }
}

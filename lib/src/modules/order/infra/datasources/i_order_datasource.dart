import '../../../core/reports/infra/models/order_sum_report_model.dart';
import '../../domain/entities/enums/order_status_enum.dart';
import '../models/order_model.dart';

abstract class IOrderDatasource {
  Future<OrderModel> changeOrderStatus(OrderModel order, OrderStatus status);

  Future<bool> changeOrderListStatus(
      List<OrderModel> orderList, OrderStatus status);

  Future<List<OrderModel>> getOrders();

  Future<List<OrderModel>> getOrdersByDay(DateTime day);

  Future<List<OrderModel>> getOrdersByDayAndStatus(
      DateTime day, OrderStatus status);

  Future<List<OrderModel>> getOrdersByDayAndStatusAndReport(
      DateTime day, OrderStatus status, OrderSumReportModel report);

  Future<List<OrderModel>> getOrdersByDayAndReport(
      DateTime day, OrderSumReportModel report);
}

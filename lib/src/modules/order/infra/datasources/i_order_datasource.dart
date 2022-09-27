import '../../domain/entities/enums/order_status_enum.dart';
import '../models/order_model.dart';

abstract class IOrderDatasource {
  Future<OrderModel> changeOrderStatus(OrderModel order, OrderStatus status);

  Future<List<OrderModel>> getOrders();

  Future<List<OrderModel>> getOrdersByDay(DateTime day);

  Future<List<OrderModel>> getOrdersByDayAndStatus(DateTime day, OrderStatus status);
}

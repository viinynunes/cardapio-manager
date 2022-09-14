import '../models/order_model.dart';

abstract class IOrderDatasource {

  Future<OrderModel> cancel(OrderModel order);

  Future<List<OrderModel>> getOrders();

  void sortOrderList(List<OrderModel> orderList);
}

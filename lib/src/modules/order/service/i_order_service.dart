import 'package:cardapio_manager/src/modules/order/domain/entities/enums/order_status_enum.dart';

import '../domain/entities/order.dart';

abstract class IOrderService {
  List<Order> filterOrderListByText(List<Order> orderList, String searchText);

  List<Order> filterOrderListByStatus(List<Order> orderList, OrderStatus status);
}

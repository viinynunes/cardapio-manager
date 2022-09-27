import 'package:cardapio_manager/src/modules/order/domain/entities/enums/order_status_enum.dart';
import 'package:cardapio_manager/src/modules/order/domain/entities/order.dart';
import 'package:cardapio_manager/src/modules/order/service/i_order_service.dart';

class OrderServiceImpl implements IOrderService {
  @override
  List<Order> filterOrderListByText(List<Order> orderList, String searchText) {
    if (searchText.isEmpty) {
      return orderList;
    }

    List<Order> filteredList = [];

    for (var order in orderList) {
      if (order.client.name.toLowerCase().contains(searchText.toLowerCase()) ||
          order.number
              .toString()
              .toLowerCase()
              .contains(searchText.toLowerCase()) ||
          order.status.name.toLowerCase().contains(searchText.toLowerCase()) ||
          order.menuList.any((element) =>
              element.name.toLowerCase().contains(searchText.toLowerCase()))) {
        filteredList.add(order);
      }
    }

    return filteredList;
  }

  @override
  List<Order> filterOrderListByStatus(
      List<Order> orderList, OrderStatus status) {
    List<Order> filteredList = [];

    for (var order in orderList) {
      if (order.status == status) {
        filteredList.add(order);
      }
    }

    return filteredList;
  }
}

import 'package:cardapio_manager/src/modules/core/reports/domain/entities/order_sum_report.dart';

import '../../../domain/entities/enums/order_status_enum.dart';
import '../../../domain/entities/order.dart';

abstract class OrderEvents {}

class GetOrdersEvent extends OrderEvents {}

class GetOrdersByDayEvent extends OrderEvents {
  final DateTime day;

  GetOrdersByDayEvent(this.day);
}

class GetOrdersByDayAndReportEvent extends OrderEvents {
  final DateTime day;
  final OrderSumReport report;

  GetOrdersByDayAndReportEvent(this.day, this.report);
}

class FilterOrderListByTextEvent implements OrderEvents {
  final List<Order> orderList;
  final String searchText;

  FilterOrderListByTextEvent(this.orderList, this.searchText);
}

class FilterOrderListByStatusEvent implements OrderEvents {
  final DateTime day;
  final OrderStatus status;

  FilterOrderListByStatusEvent(this.day, this.status);
}

class GetOrderListByDayAndStatusAndItemEvent implements OrderEvents {
  final DateTime day;
  final OrderStatus status;
  final OrderSumReport report;

  GetOrderListByDayAndStatusAndItemEvent(this.day, this.status, this.report);
}

class ChangeOrderStatusEvent extends OrderEvents {
  final Order order;
  final OrderStatus status;

  ChangeOrderStatusEvent(this.order, this.status);
}

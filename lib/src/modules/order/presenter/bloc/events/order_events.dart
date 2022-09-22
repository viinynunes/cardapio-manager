import '../../../domain/entities/enums/order_status_enum.dart';
import '../../../domain/entities/order.dart';

abstract class OrderEvents {}

class GetOrdersEvent extends OrderEvents {}

class GetOrdersByDayEvent extends OrderEvents {
  final DateTime day;

  GetOrdersByDayEvent(this.day);
}

class ChangeOrderStatusEvent extends OrderEvents {
  final Order order;
  final OrderStatus status;

  ChangeOrderStatusEvent(this.order, this.status);
}

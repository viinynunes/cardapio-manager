import '../../../domain/entities/order.dart';

abstract class OrderEvents {}

class SendOrderEvent extends OrderEvents {}

class GetOrdersEvent extends OrderEvents {}

class GetOrdersByDayEvent extends OrderEvents {
  final DateTime day;

  GetOrdersByDayEvent(this.day);
}

class CancelOrderEvent extends OrderEvents {
  final Order order;

  CancelOrderEvent(this.order);
}

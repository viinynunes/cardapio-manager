import '../../../core/client/domain/entities/client.dart';
import '../../../menu/domain/entities/item_menu.dart';
import 'enums/order_status_enum.dart';

class Order {
  String id;
  Client client;
  List<ItemMenu> menuList;
  DateTime registrationDate;
  OrderStatus status;

  Order({
    required this.id,
    required this.client,
    required this.menuList,
    required this.registrationDate,
    required this.status,
  });
}

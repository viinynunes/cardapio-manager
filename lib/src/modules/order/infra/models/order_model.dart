import 'package:cardapio_manager/src/modules/core/client/infra/models/client_model.dart';

import '../../../menu/domain/entities/item_menu.dart';
import '../../../menu/infra/models/item_menu_model.dart';
import '../../domain/entities/enums/order_status_enum.dart';
import '../../domain/entities/order.dart';

class OrderModel extends Order {
  OrderModel(
      {required String id,
        required int number,
      required ClientModel client,
      required DateTime registrationDate,
      required OrderStatus status,
      required List<ItemMenu> menuList})
      : super(
            id: id,
            number: number,
            client: client,
            registrationDate: registrationDate,
            status: status,
            menuList: menuList);

  OrderModel.fromOrder({required Order order})
      : super(
          id: order.id,
          number: order.number,
          client: ClientModel.fromClient(order.client),
          registrationDate: order.registrationDate,
          status: order.status,
          menuList: order.menuList,
        );

  OrderModel.fromMap(
      {required Map<String, dynamic> map,
      required DateTime registrationDate,
      required List<ItemMenuModel> menuList})
      : super(
          id: map['id'],
          number: map['number'],
          client: ClientModel.fromMap(map['client']),
          registrationDate: registrationDate,
          status: OrderStatus.values.byName(map['status']),
          menuList: menuList,
        );

  Map<String, dynamic> toMap({required Map<String, dynamic> client}) {
    final map = {
      'id': id,
      'number': number,
      'client': client,
      'registrationDate': registrationDate,
      'status': status.name,
      'menuList': menuList
          .map((e) => ItemMenuModel.fromItemMenu(item: e).toMap())
          .toList(),
    };

    return map;
  }
}

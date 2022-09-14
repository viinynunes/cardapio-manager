import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/client/infra/models/client_model.dart';
import '../../../../menu/infra/models/item_menu_model.dart';
import '../../../domain/entities/enums/order_status_enum.dart';
import '../../../infra/datasources/i_order_datasource.dart';
import '../../../infra/models/order_model.dart';

class OrderFirebaseDatasource implements IOrderDatasource {
  final _userOrderCollection = FirebaseFirestore.instance.collection('users');
  final _orderCollection = FirebaseFirestore.instance.collection('orders');

  @override
  Future<OrderModel> cancel(OrderModel order) async {
    order.status = OrderStatus.cancelled;

    final user = ClientModel.fromClient(order.client).toMap();

    _userOrderCollection
        .doc(order.client.id)
        .collection('orders')
        .doc(order.id)
        .update(order.toMap(user: user));

    _orderCollection.doc(order.id).update(order.toMap(user: user));

    return order;
  }

  @override
  Future<List<OrderModel>> getOrders() async {
    List<OrderModel> orderList = [];

    final orderSnap = await _orderCollection
        .orderBy('registrationDate', descending: true)
        .get();

    for (var i in orderSnap.docs) {
      Timestamp timestamp = i.data()['registrationDate'];
      final registrationDate = DateTime.parse(timestamp.toDate().toString());

      List<ItemMenuModel> menuList = [];
      for (var menu in i.data()['menuList']) {
        menuList.add(ItemMenuModel.fromMap(map: menu));
      }

      orderList.add(OrderModel.fromMap(
          map: i.data(),
          registrationDate: registrationDate,
          menuList: menuList));
    }

    return orderList;
  }

  @override
  void sortOrderList(List<OrderModel> orderList) {
    orderList.sort((a, b) => b.registrationDate.compareTo(a.registrationDate));
  }
}

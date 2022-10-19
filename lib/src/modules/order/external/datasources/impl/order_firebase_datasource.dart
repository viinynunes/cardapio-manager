import 'package:cardapio_manager/src/modules/core/reports/domain/entities/order_sum_report.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/client/infra/models/client_model.dart';
import '../../../../menu/infra/models/item_menu_model.dart';
import '../../../domain/entities/enums/order_status_enum.dart';
import '../../../infra/datasources/i_order_datasource.dart';
import '../../../infra/models/order_model.dart';

class OrderFirebaseDatasource implements IOrderDatasource {
  final _clientOrderCollection =
      FirebaseFirestore.instance.collection('clients');
  final _orderCollection = FirebaseFirestore.instance.collection('orders');

  @override
  Future<OrderModel> changeOrderStatus(
      OrderModel order, OrderStatus status) async {
    order.status = status;

    final client = ClientModel.fromClient(order.client).toMap();

    _clientOrderCollection
        .doc(order.client.id)
        .collection('orders')
        .doc(order.id)
        .update(order.toMap(client: client));

    _orderCollection.doc(order.id).update(order.toMap(client: client));

    return order;
  }

  @override
  Future<List<OrderModel>> getOrders() async {
    List<OrderModel> orderList = [];

    final orderSnap = await _orderCollection
        .orderBy('registrationDate', descending: true)
        .get();

    for (var i in orderSnap.docs) {
      orderList.add(await _getOrderModel(i));
    }

    return orderList;
  }

  @override
  Future<List<OrderModel>> getOrdersByDay(DateTime day) async {
    List<OrderModel> orderList = [];

    final filteredDay = DateTime(day.year, day.month, day.day);

    final orderSnap = await _orderCollection
        .where('registrationDate', isEqualTo: filteredDay)
        .orderBy('number', descending: false)
        .get();

    for (var i in orderSnap.docs) {
      orderList.add(await _getOrderModel(i));
    }

    return orderList;
  }

  @override
  Future<List<OrderModel>> getOrdersByDayAndStatus(
      DateTime day, OrderStatus status) async {
    List<OrderModel> orderList = [];

    final filteredDay = DateTime(day.year, day.month, day.day);

    final orderSnap = await _orderCollection
        .where('registrationDate', isEqualTo: filteredDay)
        .where('status', isEqualTo: status.name)
        .orderBy('number', descending: false)
        .get();

    for (var i in orderSnap.docs) {
      orderList.add(await _getOrderModel(i));
    }

    return orderList;
  }

  @override
  Future<List<OrderModel>> getOrdersByDayAndReport(
      DateTime day, OrderSumReport report) async {
    List<OrderModel> orderList = [];
    day = DateTime(day.year, day.month, day.day);

    final orderSnap =
        await _orderCollection.where('registrationDate', isEqualTo: day).get();

    for (var item in orderSnap.docs) {
      for (var menuItem in item.get('menuList')) {
        if (menuItem['id'] == report.itemID) {
          orderList.add(await _getOrderModel(item));
        }
      }
    }

    return orderList;
  }

  Future<OrderModel> _getOrderModel(QueryDocumentSnapshot<Map<String, dynamic>> snap) async {
    Timestamp timestamp = snap.data()['registrationDate'];
    final registrationDate = DateTime.parse(timestamp.toDate().toString());

    List<ItemMenuModel> menuList = [];
    for (var menu in snap.data()['menuList']) {
      final item = await FirebaseFirestore.instance
          .collection('menu')
          .where('id', isEqualTo: menu['id'])
          .get();
      menuList.add(ItemMenuModel.fromMap(map: item.docs.first.data()));
    }

    return OrderModel.fromMap(
        map: snap.data(),
        registrationDate: registrationDate,
        menuList: menuList);
  }
}

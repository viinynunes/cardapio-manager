import 'package:cardapio_manager/src/modules/core/reports/infra/datasources/order_report_datasource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../infra/models/order_sum_report_model.dart';

class OrderReportFirebaseDatasourceImpl implements IOrderReportDatasource {
  @override
  Future<List<OrderSumReportModel>> getTotalSumByDay(DateTime day) async {
    List<OrderSumReportModel> orderSumList = [];

    day = DateTime(day.year, day.month, day.day);

    final itemEnabledByDaySnap = await FirebaseFirestore.instance
        .collection('menu')
        .where('weekdayList', arrayContains: day.weekday)
        .get();

    for (var itemIndex in itemEnabledByDaySnap.docs) {
      final reportIndex = OrderSumReportModel(
        itemID: itemIndex.get('id'),
        itemName: itemIndex.get('name'),
        totalSumOrders: 0,
      );

      orderSumList.add(reportIndex);
    }

    final snap = await FirebaseFirestore.instance
        .collection('orders')
        .where('registrationDate', isEqualTo: day)
        .where('status', isNotEqualTo: 'cancelled')
        .get();

    for (var i in snap.docs) {
      for (Map<String, dynamic> menuItemIndex in i.get('menuList')) {
        final item = orderSumList
            .singleWhere((element) => element.itemID == menuItemIndex['id']);

        item.totalSumOrders++;
      }
    }

    orderSumList.removeWhere((element) => element.totalSumOrders == 0);

    orderSumList.sort((a, b) => b.totalSumOrders.compareTo(a.totalSumOrders));

    return orderSumList;
  }
}

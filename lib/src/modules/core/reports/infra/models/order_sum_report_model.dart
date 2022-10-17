import 'package:cardapio_manager/src/modules/core/reports/domain/entities/order_sum_report.dart';

class OrderSumReportModel extends OrderSumReport {
  OrderSumReportModel(
      {required String itemID,
      required String itemName,
      required int totalSumOrders})
      : super(
            itemID: itemID, itemName: itemName, totalSumOrders: totalSumOrders);

  OrderSumReportModel.fromMap(Map<String, dynamic> map)
      : super(
            itemID: map['itemID'],
            totalSumOrders: map['totalSumOrders'],
            itemName: map['itemName']);

  OrderSumReportModel.fromOrderSumReport(
      {required OrderSumReport orderSumReport})
      : super(
            itemID: orderSumReport.itemID,
            itemName: orderSumReport.itemName,
            totalSumOrders: orderSumReport.totalSumOrders);
}

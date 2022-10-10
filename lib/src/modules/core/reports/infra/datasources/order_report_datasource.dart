import '../models/order_sum_report_model.dart';

abstract class IOrderReportDatasource {
  Future<List<OrderSumReportModel>> getTotalSumByDay(DateTime day);
}

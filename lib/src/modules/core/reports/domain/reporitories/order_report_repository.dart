import 'package:cardapio_manager/src/modules/core/reports/order_report_error.dart';
import 'package:dartz/dartz.dart';

import '../entities/order_sum_report.dart';

abstract class IOrderReportRepository {
  Future<Either<OrderReportError, List<OrderSumReport>>> getTotalSumByDay(
      DateTime day);
}

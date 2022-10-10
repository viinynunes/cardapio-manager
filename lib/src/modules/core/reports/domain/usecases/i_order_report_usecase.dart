import 'package:dartz/dartz.dart';

import '../../order_report_error.dart';
import '../entities/order_sum_report.dart';

abstract class IOrderReportUsecase {
  Future<Either<OrderReportError, List<OrderSumReport>>> getTotalSumByDay(
      DateTime day);
}

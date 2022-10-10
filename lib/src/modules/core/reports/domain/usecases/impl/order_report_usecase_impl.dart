import 'package:cardapio_manager/src/modules/core/reports/domain/entities/order_sum_report.dart';
import 'package:cardapio_manager/src/modules/core/reports/domain/reporitories/order_report_repository.dart';
import 'package:cardapio_manager/src/modules/core/reports/domain/usecases/i_order_report_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../order_report_error.dart';

class OrderReportUsecaseImpl implements IOrderReportUsecase {
  final IOrderReportRepository _repository;

  OrderReportUsecaseImpl(this._repository);

  @override
  Future<Either<OrderReportError, List<OrderSumReport>>> getTotalSumByDay(
      DateTime day) {
    return _repository.getTotalSumByDay(day);
  }
}

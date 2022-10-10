import 'package:cardapio_manager/src/modules/core/reports/domain/reporitories/order_report_repository.dart';
import 'package:cardapio_manager/src/modules/core/reports/infra/datasources/order_report_datasource.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/order_sum_report.dart';
import '../../order_report_error.dart';

class OrderReportRepositoryImpl implements IOrderReportRepository {
  final IOrderReportDatasource _datasource;

  OrderReportRepositoryImpl(this._datasource);

  @override
  Future<Either<OrderReportError, List<OrderSumReport>>>
      getTotalSumByDay(DateTime day) async {
    try {
      final result = await _datasource.getTotalSumByDay(day);

      return Right(result);
    } on OrderReportError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(OrderReportError(e.toString()));
    }
  }
}

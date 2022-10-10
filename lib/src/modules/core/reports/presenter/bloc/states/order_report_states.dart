import 'package:cardapio_manager/src/modules/core/reports/domain/entities/order_sum_report.dart';
import 'package:cardapio_manager/src/modules/core/reports/order_report_error.dart';

abstract class OrderReportStates {}

class OrderReportIdleState implements OrderReportStates {}

class OrderReportLoadingState implements OrderReportStates {}

class OrderReportSuccessState implements OrderReportStates {
  final List<OrderSumReport> orderSumReportList;

  OrderReportSuccessState(this.orderSumReportList);
}

class OrderReportErrorState implements OrderReportStates {
  final OrderReportError error;

  OrderReportErrorState(this.error);
}

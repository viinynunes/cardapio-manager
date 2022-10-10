import 'package:cardapio_manager/src/modules/core/reports/domain/usecases/i_order_report_usecase.dart';
import 'package:cardapio_manager/src/modules/core/reports/presenter/bloc/events/order_report_events.dart';
import 'package:cardapio_manager/src/modules/core/reports/presenter/bloc/states/order_report_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderReportBloc extends Bloc<OrderReportEvents, OrderReportStates> {
  final IOrderReportUsecase usecase;

  OrderReportBloc(this.usecase) : super(OrderReportIdleState()) {
    on<GetOrderReportByDay>((event, emit) async {
      emit(OrderReportLoadingState());

      final result = await usecase.getTotalSumByDay(event.day);

      result.fold((l) => emit(OrderReportErrorState(l)),
          (r) => emit(OrderReportSuccessState(r)));
    });
  }
}

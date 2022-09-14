import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/i_order_usecase.dart';
import 'events/order_events.dart';
import 'states/order_states.dart';

class OrderBloc extends Bloc<OrderEvents, OrderStates> {
  final IOrderUsecase orderUsecase;

  OrderBloc(this.orderUsecase) : super(OrderIdleState()) {
    on<GetOrdersEvent>((event, emit) async {
      emit(OrderLoadingState());

      final result = await orderUsecase.getOrders();

      result.fold((l) => emit(OrderErrorState(l)),
          (r) => emit(OrderGetListSuccessState(r)));
    });

    on<CancelOrderEvent>((event, emit) async {
      emit(OrderLoadingState());

      final result = await orderUsecase.cancel(event.order);

      result.fold(
          (l) => emit(OrderErrorState(l)), (r) => emit(OrderSuccessState()));
    });
  }
}

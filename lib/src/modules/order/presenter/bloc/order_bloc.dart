import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/i_order_usecase.dart';
import '../../service/i_order_service.dart';
import 'events/order_events.dart';
import 'states/order_states.dart';

class OrderBloc extends Bloc<OrderEvents, OrderStates> {
  final IOrderUsecase orderUsecase;
  final IOrderService orderService;

  OrderBloc(this.orderUsecase, this.orderService) : super(OrderIdleState()) {
    on<GetOrdersEvent>((event, emit) async {
      emit(OrderLoadingState());

      final result = await orderUsecase.getOrders();

      result.fold((l) => emit(OrderErrorState(l)),
          (r) => emit(OrderGetListSuccessState(r)));
    });

    on<GetOrdersByDayEvent>((event, emit) async {
      emit(OrderLoadingState());

      final result = await orderUsecase.getOrdersByDay(event.day);

      result.fold((l) => emit(OrderErrorState(l)),
          (r) => emit(OrderGetListSuccessState(r)));
    });

    on<FilterOrderListByTextEvent>((event, emit) {
      final result =
          orderService.filterOrderListByText(event.orderList, event.searchText);

      emit(OrderGetListSuccessState(result));
    });

    on<FilterOrderListByStatusEvent>((event, emit) async {
      final result =
          await orderUsecase.getOrdersByDayAndStatus(event.day, event.status);

      result.fold((l) => emit(OrderErrorState(l)),
          (r) => emit(OrderGetListSuccessState(r)));
    });

    on<ChangeOrderStatusEvent>((event, emit) async {
      emit(OrderLoadingState());

      final result =
          await orderUsecase.changeOrderStatus(event.order, event.status);

      result.fold(
          (l) => emit(OrderErrorState(l)), (r) => emit(OrderSuccessState()));
    });
  }
}

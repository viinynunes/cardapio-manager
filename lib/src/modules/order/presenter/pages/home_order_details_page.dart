import 'package:cardapio_manager/src/modules/core/reports/domain/entities/order_sum_report.dart';
import 'package:cardapio_manager/src/modules/order/domain/entities/enums/order_status_enum.dart';
import 'package:cardapio_manager/src/modules/order/domain/entities/order.dart';
import 'package:cardapio_manager/src/modules/order/presenter/bloc/events/order_events.dart';
import 'package:cardapio_manager/src/modules/order/presenter/bloc/order_bloc.dart';
import 'package:cardapio_manager/src/modules/order/presenter/bloc/states/order_states.dart';
import 'package:cardapio_manager/src/modules/order/presenter/pages/tiles/orders_tile.dart';
import 'package:cardapio_manager/src/modules/order/presenter/pages/utils/order_status_floating_action_button_options.dart';
import 'package:cardapio_manager/src/modules/order/presenter/pages/utils/show_order_list_status_change_dialog.dart';
import 'package:custom_floating_action_button/custom_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeOrderDetailsPage extends StatefulWidget {
  const HomeOrderDetailsPage(
      {Key? key, required this.report, required this.selectedDay})
      : super(key: key);

  final OrderSumReport report;
  final DateTime selectedDay;

  @override
  State<HomeOrderDetailsPage> createState() => _HomeOrderDetailsPageState();
}

class _HomeOrderDetailsPageState extends State<HomeOrderDetailsPage> {
  final orderBloc = Modular.get<OrderBloc>();
  List<Order> orderList = [];

  OrderStatus selectedStatus = OrderStatus.open;

  @override
  void initState() {
    super.initState();

    orderBloc.add(GetOrderListByDayAndStatusAndItemEvent(
        DateTime.now(), OrderStatus.open, widget.report));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomFloatingActionButton(
      body: Scaffold(
        appBar: AppBar(
          title: const Text('Pedidos'),
          centerTitle: true,
          actions: [
            BlocBuilder<OrderBloc, OrderStates>(
              bloc: orderBloc,
              builder: (_, state) {
                if (state is OrderGetListSuccessState) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Total ${state.orderList.length.toString()}'),
                    ),
                  );
                }

                return Container();
              },
            )
          ],
        ),
        body: SizedBox(
          height: size.height * 0.85,
          child: Column(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Card(
                  child: Center(
                    child: Text(
                      widget.report.itemName,
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Card(
                  child: Center(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() => selectedStatus = OrderStatus.open);
                            orderBloc.add(
                                GetOrderListByDayAndStatusAndItemEvent(
                                    widget.selectedDay,
                                    OrderStatus.open,
                                    widget.report));
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                                color: selectedStatus == OrderStatus.open
                                    ? Theme.of(context)
                                        .indicatorColor
                                        .withOpacity(0.2)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(32)),
                            child: const Center(child: Text('Aberto')),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(
                                () => selectedStatus = OrderStatus.confirmed);
                            orderBloc.add(
                                GetOrderListByDayAndStatusAndItemEvent(
                                    widget.selectedDay,
                                    OrderStatus.confirmed,
                                    widget.report));
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                                color: selectedStatus == OrderStatus.confirmed
                                    ? Theme.of(context)
                                        .indicatorColor
                                        .withOpacity(0.2)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(32)),
                            child: const Center(child: Text('Confirmado')),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() => selectedStatus = OrderStatus.closed);
                            orderBloc.add(
                                GetOrderListByDayAndStatusAndItemEvent(
                                    widget.selectedDay,
                                    OrderStatus.closed,
                                    widget.report));
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                                color: selectedStatus == OrderStatus.closed
                                    ? Theme.of(context)
                                        .indicatorColor
                                        .withOpacity(0.2)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(32)),
                            child: const Center(child: Text('Fechado')),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(
                                () => selectedStatus = OrderStatus.cancelled);
                            orderBloc.add(
                                GetOrderListByDayAndStatusAndItemEvent(
                                    widget.selectedDay,
                                    OrderStatus.cancelled,
                                    widget.report));
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                                color: selectedStatus == OrderStatus.cancelled
                                    ? Theme.of(context)
                                        .indicatorColor
                                        .withOpacity(0.2)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(32)),
                            child: const Center(child: Text('Cancelado')),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 14,
                fit: FlexFit.tight,
                child: BlocBuilder<OrderBloc, OrderStates>(
                  bloc: orderBloc,
                  builder: (_, state) {
                    if (state is OrderLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state is OrderErrorState) {
                      return Center(
                        child: Text(state.orderError.message),
                      );
                    }

                    if (state is OrderSuccessState) {
                      orderBloc.add(GetOrderListByDayAndStatusAndItemEvent(
                          DateTime.now(), selectedStatus, widget.report));
                    }

                    if (state is OrderGetListSuccessState) {
                      orderList = state.orderList;

                      return orderList.isNotEmpty
                          ? ListView.builder(
                              itemCount: orderList.length,
                              itemBuilder: (_, index) {
                                final order = orderList[index];
                                return OrdersTile(
                                  order: order,
                                  onTap: () {
                                    Modular.to.pushNamed('../order-item-page/', arguments: [order]);
                                  },
                                  selectedDay: widget.selectedDay,
                                  whenActionCompleted: () =>
                                      GetOrderListByDayAndStatusAndItemEvent(
                                          widget.selectedDay,
                                          selectedStatus,
                                          widget.report),
                                );
                              },
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.shopping_cart_outlined,
                                  size: 100,
                                ),
                                Text(
                                  'Nenhum Pedido Encontrado',
                                  style: Theme.of(context).textTheme.titleLarge,
                                )
                              ],
                            );
                    }

                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      openFloatingActionButton: Icon(
        Icons.menu,
        color: Theme.of(context).primaryColor,
      ),
      closeFloatingActionButton: Icon(
        Icons.menu_open,
        color: Theme.of(context).primaryColor,
      ),
      backgroundColor:
          Theme.of(context).floatingActionButtonTheme.backgroundColor,
      type: CustomFloatingActionButtonType.verticalUp,
      spaceFromBottom: 20,
      options: OrderStatusFloatingActionButtonOptions
          .getOrderStatusFloatingActionButtonList(
        context: context,
        status: selectedStatus,
        onConfirmAll: () async {
          await showDialog(
            context: context,
            builder: (_) => ShowOrderListStatusChangeDialog(
                orderList: orderList,
                status: OrderStatus.confirmed,
                selectedDay: widget.selectedDay,
                whenActionCompleted: () => orderBloc.add(
                    GetOrderListByDayAndStatusAndItemEvent(
                        DateTime.now(), selectedStatus, widget.report)),
                action: 'confirmar todos'),
          );
        },
        onCancelAll: () async {
          await showDialog(
            context: context,
            builder: (_) => ShowOrderListStatusChangeDialog(
                orderList: orderList,
                status: OrderStatus.cancelled,
                selectedDay: widget.selectedDay,
                whenActionCompleted: () => orderBloc.add(
                    GetOrderListByDayAndStatusAndItemEvent(
                        DateTime.now(), selectedStatus, widget.report)),
                action: 'cancelar todos'),
          );
        },
        onCloseAll: () async {
          await showDialog(
            context: context,
            builder: (_) => ShowOrderListStatusChangeDialog(
                orderList: orderList,
                status: OrderStatus.closed,
                selectedDay: widget.selectedDay,
                whenActionCompleted: () => orderBloc.add(
                    GetOrderListByDayAndStatusAndItemEvent(
                        DateTime.now(), selectedStatus, widget.report)),
                action: 'fechar todos'),
          );
        },
      ),
    );
  }
}

import 'package:cardapio_manager/src/modules/core/reports/domain/entities/order_sum_report.dart';
import 'package:cardapio_manager/src/modules/order/domain/entities/enums/order_status_enum.dart';
import 'package:cardapio_manager/src/modules/order/presenter/bloc/events/order_events.dart';
import 'package:cardapio_manager/src/modules/order/presenter/bloc/order_bloc.dart';
import 'package:cardapio_manager/src/modules/order/presenter/bloc/states/order_states.dart';
import 'package:cardapio_manager/src/modules/order/presenter/pages/tiles/orders_tile.dart';
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

  @override
  void initState() {
    super.initState();

    orderBloc.add(GetOrderListByDayAndStatusAndItemEvent(
        DateTime.now(), OrderStatus.open, widget.report));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
                          orderBloc.add(GetOrderListByDayAndStatusAndItemEvent(
                              widget.selectedDay,
                              OrderStatus.open,
                              widget.report));
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Center(child: Text('Aberto')),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          orderBloc.add(GetOrderListByDayAndStatusAndItemEvent(
                              widget.selectedDay,
                              OrderStatus.confirmed,
                              widget.report));
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Center(child: Text('Confirmado')),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          orderBloc.add(GetOrderListByDayAndStatusAndItemEvent(
                              widget.selectedDay,
                              OrderStatus.cancelled,
                              widget.report));
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Center(child: Text('Cancelado')),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          orderBloc.add(GetOrderListByDayAndStatusAndItemEvent(
                              widget.selectedDay,
                              OrderStatus.closed,
                              widget.report));
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Center(child: Text('Fechado')),
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

                  if (state is OrderGetListSuccessState) {
                    final orderList = state.orderList;

                    return ListView.builder(
                      itemCount: orderList.length,
                      itemBuilder: (_, index) {
                        final order = orderList[index];
                        return OrdersTile(
                          order: order,
                          onTap: () {},
                          selectedDay: widget.selectedDay,
                        );
                      },
                    );
                  }

                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

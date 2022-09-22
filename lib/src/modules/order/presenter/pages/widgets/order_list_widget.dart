import 'package:cardapio_manager/src/modules/order/domain/entities/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/entities/enums/order_status_enum.dart';
import '../../bloc/events/order_events.dart';
import '../../bloc/order_bloc.dart';
import '../../bloc/states/order_states.dart';
import '../tiles/orders_tile.dart';

class OrderListWidget extends StatefulWidget {
  const OrderListWidget(
      {Key? key, required this.day, required this.getOrderList})
      : super(key: key);

  final DateTime day;
  final Function(List<Order> orderList) getOrderList;

  @override
  State<OrderListWidget> createState() => _OrderListWidgetState();
}

class _OrderListWidgetState extends State<OrderListWidget> {
  final bloc = Modular.get<OrderBloc>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    showConfirmationDialog(String action, Order order) {
      return AlertDialog(
        title: Center(child: Text('Deseja $action o pedido ?')),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          TextButton(
              onPressed: () {
                Modular.to.pop();
              },
              child: const Text(
                'Não',
                style: TextStyle(fontSize: 20),
              )),
          TextButton(
              onPressed: () {
                bloc.add(ChangeOrderStatusEvent(
                  order,
                  action == 'cancelar'
                      ? OrderStatus.cancelled
                      : OrderStatus.confirmed,
                ));
                Modular.to.pop();
                bloc.add(GetOrdersByDayEvent(widget.day));
              },
              child: const Text('Sim', style: TextStyle(fontSize: 20)))
        ],
      );
    }

    return SizedBox(
      height: size.height * 0.8,
      width: size.width,
      child: BlocBuilder<OrderBloc, OrderStates>(
        bloc: bloc,
        builder: (_, state) {
          if (state is OrderGetListSuccessState) {
            final orderList = state.orderList;

            widget.getOrderList(orderList);

            if (orderList.isEmpty) {
              return const Center(
                child: Text('Sem pedidos para a data selecionada'),
              );
            }
            return ListView.builder(
                itemCount: orderList.length,
                itemBuilder: (_, index) {
                  var order = orderList[index];
                  return OrdersTile(
                    order: order,
                    onTap: () {},
                    onConfirm: () async {
                      await showDialog(
                          context: context,
                          builder: (_) {
                            return showConfirmationDialog('confirmar', order);
                          });
                    },
                    onCancel: () async {
                      await showDialog(
                          context: context,
                          builder: (_) {
                            return showConfirmationDialog('cancelar', order);
                          });
                    },
                  );
                });
          }

          if (state is OrderLoadingState) {
            return Overlay(
              initialEntries: [
                OverlayEntry(builder: (_) {
                  return Container(
                    color: Colors.black26,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                })
              ],
            );
          }

          if (state is OrderErrorState) {
            return Center(
              child: Text(state.orderError.message),
            );
          }

          return Container();
        },
      ),
    );
  }
}

import 'package:cardapio_manager/src/modules/order/domain/entities/enums/order_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/entities/order.dart';
import '../../bloc/events/order_events.dart';
import '../../bloc/order_bloc.dart';

class ShowOrderListStatusChangeDialog extends StatelessWidget {
  const ShowOrderListStatusChangeDialog(
      {Key? key,
      required this.orderList,
      required this.selectedDay,
      required this.whenActionCompleted,
      required this.action,
      required this.status})
      : super(key: key);

  final String action;
  final List<Order> orderList;
  final OrderStatus status;
  final DateTime selectedDay;
  final VoidCallback whenActionCompleted;

  @override
  Widget build(BuildContext context) {
    final orderBloc = Modular.get<OrderBloc>();

    return AlertDialog(
      title: Center(child: Text('Deseja ${action.toLowerCase()} os pedidos ?')),
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
              orderBloc.add(ChangeOrderListStatusEvent(
                orderList,
                status,
              ));
              whenActionCompleted();
              Modular.to.pop();
            },
            child: const Text('Sim', style: TextStyle(fontSize: 20)))
      ],
    );
  }
}

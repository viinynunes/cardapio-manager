import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/entities/enums/order_status_enum.dart';
import '../../../domain/entities/order.dart';
import '../../bloc/events/order_events.dart';
import '../../bloc/order_bloc.dart';

class ShowOrderStatusChangeDialog extends StatelessWidget {
  const ShowOrderStatusChangeDialog(
      {Key? key,
      required this.action,
      required this.order,
      required this.selectedDay,
      required this.whenActionCompleted})
      : super(key: key);

  final String action;
  final Order order;
  final DateTime selectedDay;
  final VoidCallback whenActionCompleted;

  @override
  Widget build(BuildContext context) {
    final bloc = Modular.get<OrderBloc>();

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
              whenActionCompleted();
              Modular.to.pop();
            },
            child: const Text('Sim', style: TextStyle(fontSize: 20)))
      ],
    );
  }
}

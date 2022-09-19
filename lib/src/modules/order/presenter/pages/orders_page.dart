import 'package:cardapio_manager/src/modules/core/drawer/presenter/custom_drawer.dart';
import 'package:cardapio_manager/src/modules/order/presenter/pages/widgets/order_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

import '../bloc/events/order_events.dart';
import '../bloc/order_bloc.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> with TickerProviderStateMixin {
  final orderBloc = Modular.get<OrderBloc>();

  final dateFormat = DateFormat('dd/MM/yyyy');
  late DateTime day;

  @override
  void initState() {
    super.initState();
    day = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Pedidos'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                final result = await showDatePicker(
                    context: context,
                    initialDate: day,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2200));

                setState(() {
                  if (result != null) {
                    day = result;
                    orderBloc.add(GetOrdersByDayEvent(day));
                  }
                });
              },
              child: Text(
                dateFormat.format(day),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: size.width * 0.95,
                padding: const EdgeInsets.all(8),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Pesquisar',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(width: 0.01))),
                ),
              ),
              OrderListWidget(day: day),
            ],
          ),
        ),
      ),
    );
  }
}

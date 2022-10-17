import 'package:cardapio_manager/src/modules/core/drawer/presenter/custom_drawer.dart';
import 'package:cardapio_manager/src/modules/order/domain/entities/enums/order_status_enum.dart';
import 'package:cardapio_manager/src/modules/order/presenter/pages/widgets/order_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/order.dart';
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
  List<Order> orderList = [];
  List<Order> orderFullList = [];

  @override
  void initState() {
    super.initState();
    day = DateTime.now();
    orderBloc.add(GetOrdersByDayEvent(day));
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
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    width: size.width * 0.8,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Pesquisar',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(width: 0.01),
                        ),
                      ),
                      style: Theme.of(context).textTheme.bodyMedium,
                      onChanged: (searchText) {
                        if (searchText.isEmpty) {
                          orderBloc.add(GetOrdersByDayEvent(day));
                        }
                        setState(() {
                          orderBloc.add(FilterOrderListByTextEvent(
                              orderFullList, searchText));
                        });
                      },
                    ),
                  ),
                  PopupMenuButton(
                    icon: const Icon(Icons.filter_alt),
                    onSelected: (e) {
                      orderFullList.addAll(orderList);
                    },
                    itemBuilder: (_) {
                      return [
                        PopupMenuItem(
                            onTap: () {
                              orderBloc.add(GetOrdersByDayEvent(day));
                            },
                            child: const Text('Todos')),
                        PopupMenuItem(
                            onTap: () {
                              orderBloc.add(FilterOrderListByStatusEvent(
                                  day, OrderStatus.open));
                            },
                            child: const Text('Aberto')),
                        PopupMenuItem(
                            onTap: () {
                              orderBloc.add(FilterOrderListByStatusEvent(
                                  day, OrderStatus.confirmed));
                            },
                            child: const Text('Confirmado')),
                        PopupMenuItem(
                            onTap: () {
                              orderBloc.add(FilterOrderListByStatusEvent(
                                  day, OrderStatus.cancelled));
                            },
                            child: const Text('Cancelado')),
                      ];
                    },
                  )
                ],
              ),
              OrderListWidget(
                day: day,
                getOrderList: (List<Order> orderList) {
                  this.orderList = orderList;
                  if (orderFullList.isEmpty) {
                    orderFullList.addAll(orderList);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cardapio_manager/src/modules/core/drawer/presenter/custom_drawer.dart';
import 'package:cardapio_manager/src/modules/order/presenter/bloc/states/order_states.dart';
import 'package:cardapio_manager/src/modules/order/presenter/pages/tiles/orders_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final bloc = Modular.get<OrderBloc>();
  final dateFormat = DateFormat('dd/MM/yyyy');
  late DateTime today;

  @override
  void initState() {
    super.initState();
    today = DateTime.now();
    bloc.add(GetOrdersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Pedidos'),
        centerTitle: true,
        actions: [
          ElevatedButton(
            onPressed: () async {
              final result = await showDatePicker(
                  context: context,
                  initialDate: today,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2200));

              setState(() {
                if (result != null) {
                  today = result;
                }
              });
            },
            child: Text(
              dateFormat.format(today),
            ),
          ),
        ],
      ),
      body: BlocBuilder<OrderBloc, OrderStates>(
        bloc: bloc,
        builder: (_, state) {
          if (state is OrderGetListSuccessState) {
            final orderList = state.orderList;

            return ListView.builder(
                itemCount: orderList.length,
                itemBuilder: (_, index) {
                  var order = orderList[index];
                  return OrdersTile(order: order, onTap: () {});
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

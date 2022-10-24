import 'package:cardapio_manager/src/modules/order/presenter/pages/tiles/order_item_menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/enums/order_status_enum.dart';
import '../../domain/entities/order.dart';
import '../bloc/order_bloc.dart';
import '../bloc/states/order_states.dart';

class OrderItemPage extends StatefulWidget {
  const OrderItemPage({Key? key, required this.order}) : super(key: key);

  final Order order;

  @override
  State<OrderItemPage> createState() => _OrderItemPageState();
}

class _OrderItemPageState extends State<OrderItemPage> {
  final bloc = Modular.get<OrderBloc>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final dateFormat = DateFormat('dd/MM/yyyy');

    Widget getDecoratedContainer(
        {double? height,
        required int flex,
        required bool withBackground,
        required Widget child}) {
      return Flexible(
        flex: flex,
        fit: FlexFit.tight,
        child: Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(bottom: 10),
            height: height != null ? size.height * height : null,
            decoration: BoxDecoration(
                color: withBackground ? Theme.of(context).cardColor : null,
                borderRadius: BorderRadius.circular(16)),
            child: child),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Pedido ${widget.order.number}'),
        centerTitle: true,
      ),
      body: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Container(
          height: size.height,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getDecoratedContainer(
                height: 0.07,
                flex: 2,
                withBackground: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Text(
                        'Cliente',
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Text(widget.order.client.name,
                          textAlign: TextAlign.center),
                    ),
                  ],
                ),
              ),
              getDecoratedContainer(
                height: 0.07,
                withBackground: true,
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                      fit: FlexFit.tight,
                      child: Text(
                        dateFormat.format(widget.order.registrationDate),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: BlocBuilder<OrderBloc, OrderStates>(
                        bloc: bloc,
                        builder: (context, state) {
                          if (state is OrderSuccessState) {
                            widget.order.status = OrderStatus.cancelled;

                            return Text(
                              widget.order.status.name.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: widget.order.status.name ==
                                          OrderStatus.cancelled.name
                                      ? Colors.red
                                      : Colors.green),
                            );
                          }

                          return Text(
                            widget.order.status.name.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: widget.order.status.name ==
                                        OrderStatus.cancelled.name
                                    ? Colors.red
                                    : Colors.green),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              getDecoratedContainer(
                flex: 10,
                withBackground: false,
                child: Column(
                  children: [
                    const Flexible(
                        fit: FlexFit.tight, flex: 1, child: Text('Pedido')),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 15,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: widget.order.menuList.length,
                        itemBuilder: (context, index) {
                          var itemMenu = widget.order.menuList[index];

                          return OrderItemMenuTile(itemMenu: itemMenu);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

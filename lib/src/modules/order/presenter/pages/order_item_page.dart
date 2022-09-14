import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../bloc/events/order_events.dart';
import '../pages/tiles/order_item_menu_tile.dart';
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

class _OrderItemPageState extends State<OrderItemPage> with TickerProviderStateMixin {
  final bloc = Modular.get<OrderBloc>();

  late final AnimationController orderCancelConfirmedAniController;
  late final AnimationController orderCancelFailedAniController;

  @override
  void initState() {
    super.initState();

    orderCancelConfirmedAniController = AnimationController(vsync: this);
    orderCancelConfirmedAniController.duration = const Duration(seconds: 2);

    orderCancelFailedAniController = AnimationController(vsync: this);
    orderCancelFailedAniController.duration = const Duration(seconds: 2);
  }

  @override
  void dispose() {
    orderCancelFailedAniController.dispose();
    orderCancelConfirmedAniController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final dateFormat = DateFormat('dd/MM/yyyy');
    bool eventPressed = false;

    Widget _getDecoratedContainer(
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
                color: withBackground ? Colors.grey[300] : null,
                borderRadius: BorderRadius.circular(16)),
            child: child),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Pedido ${widget.order.id}'),
        centerTitle: true,
      ),
      body: WillPopScope(
        onWillPop: () async {
          Modular.to.pop(eventPressed);

          return eventPressed;
        },
        child: Container(
          height: size.height,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getDecoratedContainer(
                height: 0.07,
                flex: 1,
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
              _getDecoratedContainer(
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
              _getDecoratedContainer(
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
              BlocBuilder<OrderBloc, OrderStates>(
                bloc: bloc,
                builder: (_, states) {
                  if (states is OrderSuccessState) {
                    return Container();
                  }

                  return widget.order.status == OrderStatus.open
                      ? _getDecoratedContainer(
                          height: size.height * 0.07,
                          withBackground: true,
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  eventPressed = true;
                                  bloc.add(CancelOrderEvent(widget.order));
                                },
                                child: const Text('Cancelar Pedido'),
                              ),
                            ],
                          ),
                        )
                      : Container();
                },
              ),
              BlocBuilder<OrderBloc, OrderStates>(
                bloc: bloc,
                builder: (context, state) {
                  if (state is OrderLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is OrderSuccessState) {
                    orderCancelConfirmedAniController.forward();

                    return _getDecoratedContainer(
                      height: 0.2,
                      flex: 1,
                      withBackground: true,
                      child: Center(
                        child: Lottie.asset(
                          'assets/lottie/order-cancel-confirmed.json',
                          controller: orderCancelConfirmedAniController,
                        ),
                      ),
                    );
                  }

                  if (state is OrderErrorState) {
                    orderCancelFailedAniController.forward();

                    return Scaffold(
                      backgroundColor: Colors.white,
                      body: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              'assets/lottie/order-cancel-failed.json',
                              controller: orderCancelFailedAniController,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              state.orderError.message,
                              style: const TextStyle(fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

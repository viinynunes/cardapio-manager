import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/enums/order_status_enum.dart';
import '../../../domain/entities/order.dart';

class OrdersTile extends StatefulWidget {
  const OrdersTile({Key? key, required this.order, required this.onTap})
      : super(key: key);

  final Order order;
  final VoidCallback onTap;

  @override
  State<OrdersTile> createState() => _OrdersTileState();
}

class _OrdersTileState extends State<OrdersTile> {
  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    final size = MediaQuery.of(context).size;

    double height = size.height * 0.1;

    return AnimatedContainer(
      height: height,
      duration: const Duration(seconds: 1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Card(
          child: Row(
            children: [
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Text(
                  dateFormat.format(widget.order.registrationDate),
                  textAlign: TextAlign.center,
                ),
              ),
              Flexible(
                flex: 4,
                fit: FlexFit.tight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Text(
                        widget.order.id,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Text(
                        widget.order.client.name,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: ListView(
                        children: widget.order.menuList
                            .map((e) => Text(
                                  e.name,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: widget.order.status == OrderStatus.open
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.order.status.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: widget.order.status.name ==
                                        OrderStatus.cancelled.name
                                    ? Colors.red
                                    : Colors.green),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text(
                              'Confirmar',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        widget.order.status.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: widget.order.status.name ==
                                    OrderStatus.cancelled.name
                                ? Colors.red
                                : Colors.green),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

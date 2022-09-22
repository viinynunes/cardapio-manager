import 'package:flutter/material.dart';

import '../../../domain/entities/enums/order_status_enum.dart';
import '../../../domain/entities/order.dart';

class OrdersTile extends StatefulWidget {
  const OrdersTile(
      {Key? key,
      required this.order,
      required this.onTap,
      required this.onCancel,
      required this.onConfirm})
      : super(key: key);

  final Order order;
  final VoidCallback onTap;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  @override
  State<OrdersTile> createState() => _OrdersTileState();
}

class _OrdersTileState extends State<OrdersTile> {
  String dropdownValue = dropDownButtonItems.first;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.23,
      padding: const EdgeInsets.only(right: 8, left: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Card(
          child: Container(
            margin: const EdgeInsets.only(top: 3),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Row(
                            children: [
                              Text(
                                'Número do pedido: ',
                                style: _getTextStyle(fontSize: 20),
                              ),
                              Text(
                                widget.order.number.toString(),
                                style: _getTextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Status: ',
                              style: _getTextStyle(fontSize: 16),
                            ),
                            Text(
                              widget.order.status.name.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: _getTextStyle(
                                  fontSize: 14,
                                  color: widget.order.status.name ==
                                          OrderStatus.cancelled.name
                                      ? Colors.red
                                      : Colors.green),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Cliente: ${widget.order.client.name}',
                      style: _getTextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const Divider(),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Items: ',
                            style: _getTextStyle(fontSize: 16),
                          ),
                          const Spacer(),
                          SizedBox(
                            height: 15,
                            width: size.width * 0.3,
                            child: ListView.builder(
                              itemCount: widget.order.menuList.length,
                              shrinkWrap: true,
                              itemBuilder: (_, index) {
                                final item = widget.order.menuList[index];
                                return Text(
                                    '${(index + 1).toString()} - ${item.name}');
                              },
                            ),
                          )
                        ],
                      ),
                      widget.order.status != OrderStatus.cancelled
                          ? DropdownButton<String>(
                              elevation: 0,
                              value: dropdownValue,
                              onChanged: (item) {
                                item == 'Cancelar'
                                    ? widget.onCancel()
                                    : widget.onConfirm();
                                setState(() {
                                  dropdownValue = item!;
                                });
                              },
                              style: _getTextStyle(
                                  fontSize: 18, color: Colors.black),
                              items: dropDownButtonItems
                                  .map(
                                    (dropdownSelection) =>
                                        DropdownMenuItem<String>(
                                      value: dropdownSelection,
                                      child: Text(
                                        dropdownSelection,
                                        style: TextStyle(
                                            color:
                                                dropdownSelection == 'Cancelar'
                                                    ? Colors.red
                                                    : Colors.black),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getTextStyle({required double fontSize, Color? color}) {
    return TextStyle(
      fontSize: fontSize,
      color: color,
    );
  }
}

final dropDownButtonItems = [
  'Confirmar',
  'Cancelar',
];

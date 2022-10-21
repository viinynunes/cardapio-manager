import 'package:cardapio_manager/src/modules/order/domain/entities/enums/order_status_enum.dart';
import 'package:flutter/material.dart';

class OrderStatusFloatingActionButtonOptions {
  static List<Widget> getOrderStatusFloatingActionButtonList(
      {required BuildContext context,
      required OrderStatus status,
      required VoidCallback onConfirmAll,
      required VoidCallback onCancelAll,
      required VoidCallback onCloseAll}) {
    if (status == OrderStatus.open) {
      return [
        _getDecoratedRow(
            context: context,
            text: 'Confirmar Todos',
            icon: Icons.verified,
            onPressed: onConfirmAll),
        _getDecoratedRow(
            context: context,
            text: 'Cancelar Todos',
            icon: Icons.cancel,
            onPressed: onCancelAll),
      ];
    }

    if (status == OrderStatus.confirmed) {
      return [
        _getDecoratedRow(
            context: context,
            text: 'Fechar Todos',
            icon: Icons.close_fullscreen_rounded,
            onPressed: onCloseAll),
        _getDecoratedRow(
            context: context,
            text: 'Cancelar Todos',
            icon: Icons.cancel,
            onPressed: onCancelAll),
      ];
    }

    if (status == OrderStatus.closed) {
      return [
        Container(),
        Container(),
      ];
    }
    if (status == OrderStatus.cancelled) {
      return [
        Container(),
        Container(),
      ];
    }

    return [];
  }

  static _getDecoratedRow(
      {required BuildContext context,
      required String text,
      required IconData icon,
      required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Text(
              text,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          CircleAvatar(
            backgroundColor: Theme.of(context).backgroundColor.withOpacity(0.5),
            child: Icon(
              icon,
              color: Theme.of(context).indicatorColor,
            ),
          ),
        ],
      ),
    );
  }
}

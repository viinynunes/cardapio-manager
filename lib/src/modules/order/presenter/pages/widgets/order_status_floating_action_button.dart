import 'package:cardapio_manager/src/modules/order/domain/entities/enums/order_status_enum.dart';
import 'package:cardapio_manager/src/modules/order/presenter/pages/widgets/delegates/order_status_flow_delegate.dart';
import 'package:flutter/material.dart';

class OrderStatusFloatingActionButton extends StatefulWidget {
  const OrderStatusFloatingActionButton({Key? key, required this.status})
      : super(key: key);

  final OrderStatus status;

  @override
  State<OrderStatusFloatingActionButton> createState() =>
      _OrderStatusFloatingActionButtonState();
}

class _OrderStatusFloatingActionButtonState
    extends State<OrderStatusFloatingActionButton>
    with TickerProviderStateMixin {
  late AnimationController floatingAnimationController;
  bool isOpen = false;

  @override
  void initState() {
    super.initState();

    floatingAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
  }

  @override
  void dispose() {
    floatingAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    toggleMenu() {
      isOpen
          ? floatingAnimationController.reverse()
          : floatingAnimationController.forward();
      isOpen = !isOpen;
    }

    List<Widget> getFloatingByOrderStatus() {
      if (widget.status == OrderStatus.open) {
        return [
          FloatingActionButton(
            heroTag: null,
            onPressed: () => toggleMenu(),
            child: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: floatingAnimationController,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Confirmar Todos'),
              Icon(Icons.subdirectory_arrow_left)
            ],
          )
        ];
      }

      if (widget.status == OrderStatus.confirmed) {
        return [
          FloatingActionButton(
            heroTag: null,
            onPressed: () => toggleMenu(),
            child: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: floatingAnimationController,
            ),
          ),
          FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.remove),
          )
        ];
      }

      if (widget.status == OrderStatus.closed) {
        return [
          FloatingActionButton(
            heroTag: null,
            onPressed: () => toggleMenu(),
            child: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: floatingAnimationController,
            ),
          ),
          FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.save),
          )
        ];
      }

      if (widget.status == OrderStatus.cancelled) {
        return [
          FloatingActionButton(
            heroTag: null,
            onPressed: () => toggleMenu(),
            child: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: floatingAnimationController,
            ),
          ),
          FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.light),
          )
        ];
      }

      return [];
    }

    return Flow(
        clipBehavior: Clip.none,
        delegate:
            OrderStatusFlowDelegate(animation: floatingAnimationController),
        children: getFloatingByOrderStatus());
  }
}

import 'package:cardapio_manager/src/modules/core/weekday/domain/entities/weekday.dart';
import 'package:flutter/material.dart';

class OrderDaysTile extends StatelessWidget {
  const OrderDaysTile(
      {Key? key,
      required this.day,
      required this.selected,
      required this.onTap})
      : super(key: key);

  final Weekday day;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: selected ? Theme.of(context).secondaryHeaderColor : null),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                day.name,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

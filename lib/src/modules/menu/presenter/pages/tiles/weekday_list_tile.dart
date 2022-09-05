import 'package:flutter/material.dart';

import '../../../domain/entities/weekday.dart';

class WeekdayListTile extends StatefulWidget {
  const WeekdayListTile(
      {Key? key,
      required this.weekday,
      required this.checked,
      required this.onAdd,
      required this.onRemove})
      : super(key: key);

  final Weekday weekday;
  final bool checked;
  final Function(int weekdayNumb) onAdd;
  final Function(int weekdayNumb) onRemove;

  @override
  State<WeekdayListTile> createState() => _WeekdayListTileState();
}

class _WeekdayListTileState extends State<WeekdayListTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(flex: 1, child: Text(widget.weekday.name)),
          Flexible(
            flex: 1,
            child: Checkbox(
              value: widget.checked,
              onChanged: (e) {
                setState(() {
                  if (e!) {
                    widget.onAdd(widget.weekday.weekday);
                  } else {
                    widget.onRemove(widget.weekday.weekday);
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

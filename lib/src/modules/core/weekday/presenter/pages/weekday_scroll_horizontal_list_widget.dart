import 'package:cardapio_manager/src/modules/core/weekday/domain/entities/weekday.dart';
import 'package:cardapio_manager/src/modules/core/weekday/presenter/pages/tiles/weekday_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../bloc/days_of_week_bloc.dart';
import '../bloc/events/days_of_week_event.dart';
import '../bloc/states/days_of_week_state.dart';

class WeekdayScrollHorizontalListWidget extends StatefulWidget {
  const WeekdayScrollHorizontalListWidget({Key? key, required this.getWeekday, required this.selectedWeekday})
      : super(key: key);

  final Weekday selectedWeekday;
  final Function(Weekday weekday) getWeekday;

  @override
  State<WeekdayScrollHorizontalListWidget> createState() =>
      _WeekdayScrollHorizontalListWidgetState();
}

class _WeekdayScrollHorizontalListWidgetState
    extends State<WeekdayScrollHorizontalListWidget> {
  final daysBloc = Modular.get<DaysOfWeekBloc>();

  late Weekday weekday;

  @override
  void initState() {
    super.initState();
    daysBloc.add(GetOrderedWeekdaysOrderedByToday(DateTime.now(), widget.selectedWeekday));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      height: size.height * 0.08,
      width: size.width,
      child: BlocBuilder<DaysOfWeekBloc, DaysOfWeekState>(
        bloc: daysBloc,
        builder: (_, state) {
          if (state is DaysOfWeekLoadingState) {
            return const Center(
              child: LinearProgressIndicator(),
            );
          }

          if (state is DaysOfWeekSuccessState) {
            final daysList = state.weekDayList;

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: daysList.length,
              itemBuilder: (_, index) {
                final day = daysList[index];
                return OrderDaysTile(
                  onTap: () {
                    for (var element in daysList) {
                      element.selected = false;
                    }
                    setState(() {
                      day.selected = true;
                      widget.getWeekday(day);
                    });
                  },
                  day: day,
                  selected: day.selected,
                );
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}

import 'package:cardapio_manager/src/modules/menu/errors/item_menu_errors.dart';

import '../../../domain/entities/weekday.dart';

abstract class DaysOfWeekState {}

class DaysOfWeekInitialState extends DaysOfWeekState {}

class DaysOfWeekLoadingState extends DaysOfWeekState {}

class DaysOfWeekSuccessState extends DaysOfWeekState {
  List<Weekday> weekDayList;

  DaysOfWeekSuccessState(this.weekDayList);
}

class DaysOfWeekErrorState extends DaysOfWeekState {
  ItemMenuError error;

  DaysOfWeekErrorState(this.error);
}

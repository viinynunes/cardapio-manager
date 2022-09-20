import '../../../domain/entities/weekday.dart';

abstract class DaysOfWeekEvent {}

class GetOrderedWeekdaysOrderedByToday extends DaysOfWeekEvent {
  final DateTime today;
  final Weekday weekday;

  GetOrderedWeekdaysOrderedByToday(this.today, this.weekday);
}

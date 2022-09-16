abstract class DaysOfWeekEvent {}

class GetOrderedWeekdaysOrderedByToday extends DaysOfWeekEvent {
  DateTime today;

  GetOrderedWeekdaysOrderedByToday(this.today);
}
abstract class OrderReportEvents {}

class GetOrderReportByDay implements OrderReportEvents {
  final DateTime day;

  GetOrderReportByDay(this.day);
}

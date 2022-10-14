import 'package:cardapio_manager/src/modules/core/reports/domain/entities/order_sum_report.dart';
import 'package:flutter/material.dart';

class HomeOrderReportSumReportGraphicTile extends StatelessWidget {
  const HomeOrderReportSumReportGraphicTile(
      {Key? key, required this.report, required this.color})
      : super(key: key);

  final OrderSumReport report;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Container(
              color: color,
              height: size.height * 0.01,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            flex: 9,
            fit: FlexFit.tight,
            child: Text(
              report.itemName,
              style: TextStyle(color: color, fontSize: 12),
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}

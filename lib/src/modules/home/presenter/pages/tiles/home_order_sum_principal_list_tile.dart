import 'package:cardapio_manager/src/modules/core/reports/domain/entities/order_sum_report.dart';
import 'package:flutter/material.dart';

class HomeOrderSumPrincipalListTile extends StatelessWidget {
  const HomeOrderSumPrincipalListTile({Key? key, required this.report, required this.onTap})
      : super(key: key);

  final OrderSumReport report;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Text(
                report.itemName,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Text(report.totalSumOrders.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16)),
            ),
            const Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Icon(Icons.list),
            ),
          ],
        ),
      ),
    );
  }
}

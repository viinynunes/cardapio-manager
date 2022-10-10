import 'dart:math' as math;

import 'package:cardapio_manager/src/modules/core/drawer/presenter/custom_drawer.dart';
import 'package:cardapio_manager/src/modules/core/reports/presenter/bloc/events/order_report_events.dart';
import 'package:cardapio_manager/src/modules/core/reports/presenter/bloc/order_report_bloc.dart';
import 'package:cardapio_manager/src/modules/core/reports/presenter/bloc/states/order_report_states.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final orderReportBloc = Modular.get<OrderReportBloc>();

  final dateFormat = DateFormat('dd-MM-yyyy');
  late DateTime selectedDay;

  @override
  void initState() {
    super.initState();

    selectedDay = DateTime.now();

    orderReportBloc.add(GetOrderReportByDay(selectedDay));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                final result = await showDatePicker(
                    context: context,
                    initialDate: selectedDay,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2200));

                setState(() {
                  if (result != null) {
                    selectedDay = result;
                    orderReportBloc.add(GetOrderReportByDay(selectedDay));
                  }
                });
              },
              child: Text(
                dateFormat.format(selectedDay),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              BlocBuilder<OrderReportBloc, OrderReportStates>(
                bloc: orderReportBloc,
                builder: (_, state) {
                  if (state is OrderReportLoadingState) {
                    return const Center(
                      child: LinearProgressIndicator(),
                    );
                  }

                  if (state is OrderReportErrorState) {
                    return Center(
                      child: Text(state.error.message),
                    );
                  }

                  if (state is OrderReportSuccessState) {
                    final reportList = state.orderSumReportList;

                    int reportListTotalItems = 0;

                    for (var e in reportList) {
                      reportListTotalItems += e.totalSumOrders;
                    }

                    return reportList.isNotEmpty
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: PieChart(
                                    PieChartData(
                                      sectionsSpace: 5,
                                      centerSpaceRadius: size.width * 0.1,
                                      sections: reportList.map(
                                        (e) {
                                          final percentageTitle =
                                              (e.totalSumOrders /
                                                      reportListTotalItems) *
                                                  100;
                                          return PieChartSectionData(
                                            title:
                                                '${percentageTitle.toStringAsFixed(0)}%',
                                            value: e.totalSumOrders.toDouble(),
                                            color: Color((math.Random()
                                                            .nextDouble() *
                                                        0xFFFFFF)
                                                    .toInt())
                                                .withOpacity(1.0),
                                          );
                                        },
                                      ).toList(),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Container(
                                    height: size.height * 0.3,
                                    color: Colors.blueAccent.withOpacity(0.3),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: reportList
                                          .map((e) => ListTile(
                                                title: Text(e.itemName),
                                              ))
                                          .toList(),
                                    )),
                              )
                            ],
                          )
                        : const Center(
                            child: Text('Nenhum pedido no dia'),
                          );
                  }

                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

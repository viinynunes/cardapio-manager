import 'package:cardapio_manager/src/modules/core/drawer/presenter/custom_drawer.dart';
import 'package:cardapio_manager/src/modules/core/reports/presenter/bloc/events/order_report_events.dart';
import 'package:cardapio_manager/src/modules/core/reports/presenter/bloc/order_report_bloc.dart';
import 'package:cardapio_manager/src/modules/core/reports/presenter/bloc/states/order_report_states.dart';
import 'package:cardapio_manager/src/modules/home/presenter/pages/tiles/home_order_sum_principal_list_tile.dart';
import 'package:cardapio_manager/src/modules/home/presenter/pages/tiles/home_order_sum_report_graphic_tile.dart';
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

    final randomColorArray = [
      Theme.of(context).indicatorColor,
      Colors.purpleAccent,
      Colors.orange,
      Colors.redAccent,
      Colors.teal,
      Colors.green,
      Colors.pink,
      Colors.blue,
      Colors.yellow,
    ];

    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
              style: ButtonStyle(
                  side:
                      MaterialStateProperty.all(const BorderSide(width: 0.1))),
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
          child: BlocBuilder<OrderReportBloc, OrderReportStates>(
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

                return SizedBox(
                  height: size.height * 0.85,
                  width: size.width,
                  child: Column(
                    children: [
                      reportList.isNotEmpty
                          ? Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: PieChart(
                                        PieChartData(
                                            sectionsSpace: 5,
                                            centerSpaceRadius:
                                                size.width * 0.13,
                                            sections: List.generate(
                                                reportList.length, (index) {
                                              final e = reportList[index];

                                              final percentageTitle = (e
                                                          .totalSumOrders /
                                                      reportListTotalItems) *
                                                  100;

                                              return PieChartSectionData(
                                                title:
                                                    '${percentageTitle.toStringAsFixed(0)}%',
                                                titleStyle: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                                value:
                                                    e.totalSumOrders.toDouble(),
                                                color: randomColorArray[index],
                                              );
                                            })),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.05),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: List.generate(
                                            reportList.length,
                                            (index) {
                                              final e = reportList[index];

                                              return HomeOrderReportSumReportGraphicTile(
                                                report: e,
                                                color: randomColorArray[index],
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : const Flexible(
                              child: Center(
                                child: Text('Nenhum pedido no dia'),
                              ),
                            ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).dialogBackgroundColor,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Column(
                            children: [
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Row(
                                  children: [
                                    Flexible(
                                      flex: 3,
                                      fit: FlexFit.tight,
                                      child: Text('Item',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: Text('Total',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: Text('',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Flexible(
                                flex: 6,
                                fit: FlexFit.tight,
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: reportList.length,
                                  itemBuilder: (_, index) {
                                    final report = reportList[index];
                                    return HomeOrderSumPrincipalListTile(
                                      report: report,
                                      onTap: () {
                                        Modular.to.pushNamed(
                                            '/order/home-order-details/',
                                            arguments: [report]);
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}

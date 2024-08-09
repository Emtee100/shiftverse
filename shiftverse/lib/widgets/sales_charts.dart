import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shiftverse/controllers/firebaseController.dart';
import 'package:shiftverse/models/sales.dart';

class ChartSales extends StatefulWidget {
  const ChartSales({super.key});

  @override
  State<ChartSales> createState() => _ChartSalesState();
}

class _ChartSalesState extends State<ChartSales> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseController>(
        builder: (context, value, child) => StreamBuilder(
            stream: value.getMonthlySaleRecords(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                List<QueryDocumentSnapshot<Sale>> salesRecords =
                    snapshot.data!.docs;
                List<FlSpot> saleSpots = [];

                for (final saleRecord in salesRecords) {
                  Sale saleData = saleRecord.data();

                  saleSpots.add(FlSpot(
                      saleData.saleDate.millisecondsSinceEpoch.toDouble(),
                      saleData.saleAmount));
                }
                return LineChart(LineChartData(
                    borderData: FlBorderData(
                        show: true,
                        border: Border(
                            right: const BorderSide(color: Colors.transparent),
                            top: const BorderSide(color: Colors.transparent),
                            left: BorderSide(
                                color: Theme.of(context).colorScheme.onSurface),
                            bottom: BorderSide(
                                color:
                                    Theme.of(context).colorScheme.onSurface))),
                    gridData: const FlGridData(
                      show: false,
                    ),
                    minY: 0,
                    maxY: 5000,
                    maxX: salesRecords.first
                        .data()
                        .saleDate
                        .millisecondsSinceEpoch
                        .toDouble(),
                    minX: salesRecords.last
                        .data()
                        .saleDate
                        .millisecondsSinceEpoch
                        .toDouble(),
                    lineTouchData: LineTouchData(
                      touchTooltipData: LineTouchTooltipData(
                        tooltipRoundedRadius: 10,
                        fitInsideHorizontally: true,
                        fitInsideVertically: true,
                        //function for returning a custom tooltip that shows pamphlets sold and date they were sold
                        getTooltipItems: (touchedSpots) {
                          return touchedSpots.map((touchedSpot) {
                            String pamphletsSold = touchedSpot.y.toString();
                            DateTime dateFromEpoch =
                                DateTime.fromMillisecondsSinceEpoch(
                                    touchedSpot.x.toInt());
                            String dateSold =
                                DateFormat('dd-MM-yyyy').format(dateFromEpoch);
                            final textStyle = TextStyle(
                                color: Theme.of(context).colorScheme.surface,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .fontSize);
                            return LineTooltipItem(
                                """Pamphlets sold: $pamphletsSold
                                  Date sold: $dateSold""", textStyle);
                          }).toList();
                        },
                      ),
                    ),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                          //axisNameSize: 12,
                          axisNameWidget: Text(
                            style: Theme.of(context).textTheme.labelSmall,
                            'Pamphlets sold',
                          ),
                          sideTitles: SideTitles(
                            reservedSize: 42,
                            showTitles: true,
                            interval: 1000,
                            getTitlesWidget: (value, meta) {
                              int formattedValue = value.toInt();
                              return SideTitleWidget(
                                axisSide: meta.axisSide,
                                child: Text(
                                  '$formattedValue',
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              );
                            },
                          )),
                      topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                          axisNameWidget: Text(
                            'Date sold',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          sideTitles: SideTitles(
                            //interval: 10,
                            reservedSize: 40,
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              //create a DateTime object from the x-axis value which are milliseconds since epoch
                              DateTime dateFromEpoch =
                                  DateTime.fromMillisecondsSinceEpoch(
                                      value.toInt(),
                                      isUtc: false);
                              //Format the date
                              String text =
                                  DateFormat('dd/MM').format(dateFromEpoch);
                              //return Text widget containing the formatted date
                              return SideTitleWidget(
                                angle: 120,
                                //space: 16,
                                fitInside: SideTitleFitInsideData.fromTitleMeta(
                                    meta,
                                    distanceFromEdge: 0),
                                axisSide: meta.axisSide,
                                child: Text(
                                  text,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              );
                            },
                          )),
                    ),
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceContainerHigh,
                    lineBarsData: [
                      LineChartBarData(
                        color: Theme.of(context).colorScheme.primary,
                        spots: saleSpots,
                      ),
                      // LineChartBarData(
                      //   spots: remainingPamphletSpots,
                      //   color: Theme.of(context).colorScheme.error,
                      // )
                    ]));
              } else if (snapshot.hasError) {
                return Text(
                    'An error occured getting sales data, ${snapshot.error}');
              } else {
                return const Text('Null');
              }
            }));
  }
}

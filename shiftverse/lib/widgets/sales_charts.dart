import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
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
            stream: value.getSaleRecords(),
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
                    //minY: 0,
                    titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                            //axisNameSize: 12,
                            axisNameWidget: Text(
                              style: Theme.of(context).textTheme.labelSmall,
                              'Pamphlets sold',
                            ),
                            sideTitles: const SideTitles(
                                reservedSize: 40, showTitles: true)),
                        topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false))),
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceContainerHigh,
                    lineBarsData: [LineChartBarData(spots: saleSpots)]));
              } else if (snapshot.hasError) {
                return const Text('An error occured getting sales data');
              } else {
                return const Text('Null');
              }
            }));
  }
}

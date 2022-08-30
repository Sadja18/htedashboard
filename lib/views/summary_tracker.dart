import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:intl/intl.dart';
import '../models/local_data.dart' as records;

class SummaryTracker extends StatefulWidget {
  const SummaryTracker({Key? key}) : super(key: key);

  @override
  State<SummaryTracker> createState() => _SummaryTrackerState();
}

class _SummaryTrackerState extends State<SummaryTracker> {
  // int recordIndex = 0;
  late List<ChartData> datasource;
  @override
  void initState() {
    if (kDebugMode) {
      log(records.intake.length.toString());
    }
    datasource = records.intake
        .map(
          (e) => ChartData(
            e['name'],
            e['total'],
            e['annual'],
          ),
        )
        .toList();
    super.initState();
  }

  Widget tableCell(index) {
    return TableCell(
      child: Center(
        child: SfCartesianChart(
          enableSideBySideSeriesPlacement: true,
          primaryXAxis: CategoryAxis(
            isVisible: true,
          ),
          primaryYAxis: NumericAxis(),
          legend: Legend(
            isVisible: true,
          ),
          palette: const [
            Color.fromARGB(255, 54, 120, 218),
            Colors.orange,
          ],
          series: [
            ColumnSeries(
              name: "Total",
              yAxisName: "Total",
              // isVisibleInLegend: true,
              isVisible: true,
              dataSource: [datasource[index]],
              xValueMapper: (ChartData data, _) => data.collegeName,
              yValueMapper: (ChartData data, _) => data.total,
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
              ),
            ),
            ColumnSeries(
              name: "Annual",
              yAxisName: "Annual",
              isVisible: true,
              dataSource: [datasource[index]],
              xValueMapper: (ChartData data, _) => data.collegeName,
              yValueMapper: (ChartData data, _) => data.annual,
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  TableRow tableRow(baseIndex) {
    return TableRow(
      children: [
        (baseIndex < datasource.length)
            ? tableCell(baseIndex)
            : const SizedBox(
                height: 0,
                width: 0,
              ),
        (baseIndex + 1 < datasource.length)
            ? tableCell(baseIndex + 1)
            : const SizedBox(
                height: 0,
                width: 0,
              ),
        (baseIndex + 2 < datasource.length)
            ? tableCell(baseIndex + 2)
            : const SizedBox(
                height: 0,
                width: 0,
              ),
        (baseIndex + 3 < datasource.length)
            ? tableCell(baseIndex + 3)
            : const SizedBox(
                height: 0,
                width: 0,
              ),
      ],
    );
  }

  List<TableRow> tableGen() {
    List<TableRow> rows = [];

    for (int i = 0; i < datasource.length; i++) {
      if (i < datasource.length) {
        TableRow tableRowTmp = tableRow(i);
        rows.add(tableRowTmp);
        i = i + 3;
      } else {
        break;
      }
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    // late List<ChartData> data=[ChartData()];

    return Container(
      width: MediaQuery.of(context).size.width * 0.98,
      height: MediaQuery.of(context).size.height * 0.95,
      alignment: Alignment.center,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: tableGen(),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.collegeName, this.total, this.annual);
  final String collegeName;
  final double total;
  final double annual;
}

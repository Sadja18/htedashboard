// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../models/local_data.dart' as records;

class GenderParityIndex extends StatefulWidget {
  final List genderParityInfo;
  const GenderParityIndex({
    Key? key,
    required this.genderParityInfo,
  }) : super(key: key);

  @override
  State<GenderParityIndex> createState() => _GenderParityIndexState();
}

class _GenderParityIndexState extends State<GenderParityIndex> {
  late List<ChartData> datasource;

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
              name: "Boys",
              yAxisName: "Boys",
              // isVisibleInLegend: true,
              isVisible: true,
              dataSource: [datasource[index]],
              xValueMapper: (ChartData data, _) => data.collegeName,
              yValueMapper: (ChartData data, _) => data.numBoys,
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
              ),
            ),
            ColumnSeries(
              name: "Girls",
              yAxisName: "Girls",
              isVisible: true,
              dataSource: [datasource[index]],
              xValueMapper: (ChartData data, _) => data.collegeName,
              yValueMapper: (ChartData data, _) => data.numGirls,
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
  void initState() {
    datasource = widget.genderParityInfo
        .map(
          (e) => ChartData(
            e['name'],
            e['male'],
            e['female'],
          ),
        )
        .toList();

    if (kDebugMode) {
      log(datasource.toString());
      log(records.gpi.toString());
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.98,
      height: MediaQuery.of(context).size.height * 0.95,
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
  ChartData(this.collegeName, this.numBoys, this.numGirls);
  final String collegeName;
  final double numBoys;
  final double numGirls;
}

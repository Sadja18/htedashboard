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
  var _tooltipBehaviour = TooltipBehavior(enable: true);

  Widget tableCell(index) {
    var end = index + 4;
    end = end > datasource.length ? datasource.length : end;

    return TableCell(
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.width * 0.18,
        child: SfCartesianChart(
          tooltipBehavior: _tooltipBehaviour,
          margin: const EdgeInsets.all(25),
          enableSideBySideSeriesPlacement: true,
          primaryXAxis: CategoryAxis(
            isVisible: true,
          ),
          // primaryYAxis: NumericAxis(),
          legend: Legend(
            isVisible: true,
          ),
          palette: const [
            Color.fromARGB(255, 54, 120, 218),
            Colors.orange,
          ],
          series: [
            StackedColumnSeries<ChartData, String>(
              name: "Boys",
              width: 0.09,
              dataSource: datasource.sublist(index, end),
              xValueMapper: (ChartData data, _) => data.collegeName,
              yValueMapper: (ChartData data, _) => data.numBoys,
              enableTooltip: true,
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                showCumulativeValues: true,
              ),
            ),
            StackedColumnSeries<ChartData, String>(
              name: "Girls",
              width: 0.09,
              dataSource: datasource.sublist(index, end),
              xValueMapper: (ChartData data, _) => data.collegeName,
              yValueMapper: (ChartData data, _) => data.numGirls,
              enableTooltip: true,
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                showCumulativeValues: true,
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
      ],
    );
  }

  List<TableRow> tableGen() {
    List<TableRow> rows = [];

    for (int i = 0; i < datasource.length; i = i + 4) {
      if (i < datasource.length) {
        TableRow tableRowTmp = tableRow(i);
        rows.add(tableRowTmp);
      } else {
        break;
      }
    }
    return rows;
  }

  @override
  void initState() {
    _tooltipBehaviour = TooltipBehavior(enable: true);
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
      print(datasource);
      // log(records.gpi.toString());
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
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
  final int numBoys;
  final int numGirls;
}

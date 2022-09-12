import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import './courses_selector.dart';
import '../api/fetches.dart';

class StudentAttendanceWidget extends StatefulWidget {
  final int collegeId;
  const StudentAttendanceWidget({
    Key? key,
    required this.collegeId,
  }) : super(key: key);

  @override
  State<StudentAttendanceWidget> createState() =>
      _StudentAttendanceWidgetState();
}

class _StudentAttendanceWidgetState extends State<StudentAttendanceWidget> {
  late Future _studentAttendanceBaseFuture;

  List processRecords(data) {
    List updated = [];

    for (var entry in data) {
      var courseId = entry['courseId'];
      var courseName = entry['courseName'];
      var stAt = entry['studentAttendance'];
      double sum = 0;
      if (kDebugMode) {
        // log(courseName.toString());
        // log(stAt.toString());
      }
      for (var att in stAt) {
        var attendance = att['attendance_percentage'];
        sum = sum + double.parse(attendance.split("%")[0]);
        if (kDebugMode) {
          // log(att.toString());
          // log(attendance.toString());
          // log(attendance.runtimeType.toString());
          log("Sum $sum");
          log("\n");
        }
      }
      if (kDebugMode) {
        log(" Course $courseName");
        log("$sum");
        log("${sum / stAt.length}");
      }
      updated.add({
        "courseId": courseId,
        "courseName": courseName,
        "percent": sum / stAt.length
      });
    }

    return updated;
  }

  @override
  void initState() {
    if (kDebugMode) {
      log("here1");
    }
    _studentAttendanceBaseFuture =
        fetchStudentAttendanceCourseCurrentSem(widget.collegeId);

    if (kDebugMode) {
      log("here2");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.80,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.99,
            height: MediaQuery.of(context).size.height * 0.85,
            child: FutureBuilder(
              future: _studentAttendanceBaseFuture,
              builder: (BuildContext c, AsyncSnapshot s) {
                if (s.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.10,
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: const CircularProgressIndicator.adaptive(),
                    ),
                  );
                } else {
                  if (s.hasData && s.data != null && s.data != false) {
                    if (kDebugMode) {
                      log(s.data.toString());
                    }
                    return Visualize(records: processRecords(s.data));
                  } else {
                    return Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.10,
                        height: MediaQuery.of(context).size.height * 0.08,
                        child:
                            const Text("No student attendance records found"),
                      ),
                    );
                  }
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class Visualize extends StatefulWidget {
  final List records;
  const Visualize({
    Key? key,
    required this.records,
  }) : super(key: key);

  @override
  State<Visualize> createState() => _VisualizeState();
}

class _VisualizeState extends State<Visualize> {
  late List<ChartData> datasource = [];

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
              name: "Attendance",
              yAxisName: "Attendance Percentage",
              // isVisibleInLegend: true,
              isVisible: true,
              dataSource: [datasource[index]],
              xValueMapper: (ChartData data, _) => data.courseName,
              yValueMapper: (ChartData data, _) => data.percent,
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    List<ChartData> tmp = [];

    for (var r in widget.records) {
      tmp.add(ChartData(r['courseName'].toString(), r['percent']));
    }
    setState(() {
      datasource = tmp;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.99,
      height: MediaQuery.of(context).size.height * 0.80,
      alignment: Alignment.center,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Table(
          columnWidths: const {
            0: FractionColumnWidth(0.30),
            1: FractionColumnWidth(0.30),
            2: FractionColumnWidth(0.30)
          },
          children: tableGen(),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.courseName, this.percent);
  String courseName;
  double percent;
}

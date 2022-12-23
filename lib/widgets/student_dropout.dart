import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import './courses_selector.dart';
import '../api/fetches.dart';

class StudentDropoutWidget extends StatefulWidget {
  final int collegeId;
  const StudentDropoutWidget({Key? key, required this.collegeId})
      : super(key: key);

  @override
  State<StudentDropoutWidget> createState() =>
      _StudentDropoutWidgetState();
}

class _StudentDropoutWidgetState extends State<StudentDropoutWidget> {
  String selectedCourse = "";

  void courseSelector(String selectedCourseName) {
    if (kDebugMode) {
      log("in main $selectedCourseName");
    }
    setState(() {
      selectedCourse = selectedCourseName;
    });
  }

  dynamic preProcessorCurrent(data) {
    var current = [];
    if (data['current'] != null && data['current'].isNotEmpty) {
      for (var group in data['current']) {
        current.add({
          'count': group['colyear_count'],
          'label': group['colyear'][1],
        });
      }
      return current;
    } else {
      return current;
    }
  }

  dynamic preProcessorTerminate(data) {
    var terminated = [];

    if (data['terminate'] != null && data['terminate'].isNotEmpty) {
      for (var group in data['terminate']) {
        terminated.add({
          'count': group['colyear_count'],
          'label': group['colyear'][1],
        });
      }
      return terminated;
    } else {
      return terminated;
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      log('collegeId ${widget.collegeId}');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.80,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.80,
            height: MediaQuery.of(context).size.height * 0.05,
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                0: FractionColumnWidth(0.50),
                1: FractionColumnWidth(0.50),
              },
              children: [
                TableRow(
                  children: [
                    const TableCell(
                      child: Center(
                        child: Text(
                          "Select Course:",
                          maxLines: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: SelectorCourseFuture(
                          collegeId: widget.collegeId,
                          courseSelector: courseSelector,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          (selectedCourse == "")
              ? const SizedBox(
                  width: 0,
                  height: 0,
                )
              : FutureBuilder(
                  future: fetchStudentDropoutsinCollegeCourse(
                      widget.collegeId, selectedCourse),
                  builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.10,
                          height:
                              MediaQuery.of(context).size.height * 0.08,
                          child:
                              const CircularProgressIndicator.adaptive(),
                        ),
                      );
                    } else {
                      if (kDebugMode) {
                        log("");
                      }
                      if (snapshot.hasData &&
                          snapshot.data != null &&
                          snapshot.data.isNotEmpty) {
                        return Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.80,
                          height:
                              MediaQuery.of(context).size.height * 0.80,
                          decoration: const BoxDecoration(),
                          child: Table(
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            columnWidths: const {
                              0: FractionColumnWidth(0.50),
                              1: FractionColumnWidth(0.50),
                            },
                            children: [
                              TableRow(
                                children: [
                                  TableCell(
                                    child: (snapshot.data['current'] !=
                                                null &&
                                            snapshot.data['current']
                                                .isNotEmpty)
                                        ? Center(
                                            child: ChartExistingStudent(
                                              groupedRecords:
                                                  preProcessorCurrent(
                                                      snapshot.data),
                                              name: 'Existing',
                                            ),
                                          )
                                        : Center(
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height:
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.08,
                                              child: const Text(
                                                "No student has taken admission in this course",
                                                textAlign:
                                                    TextAlign.center,
                                              ),
                                            ),
                                          ),
                                  ),
                                  TableCell(
                                    child: (snapshot.data['terminate'] !=
                                                null &&
                                            snapshot.data['terminate']
                                                .isNotEmpty)
                                        ? Center(
                                            child: ChartExistingStudent(
                                              groupedRecords:
                                                  preProcessorCurrent(
                                                      snapshot.data),
                                              name: 'Dropouts',
                                            ),
                                          )
                                        : Center(
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height:
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.08,
                                              child: const Text(
                                                "No student has dropped out",
                                                textAlign:
                                                    TextAlign.center,
                                              ),
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Center(
                          child: SizedBox(
                            width:
                                MediaQuery.of(context).size.width * 0.10,
                            height:
                                MediaQuery.of(context).size.height * 0.08,
                            child: const Text(
                              "No students record found for the selected course",
                            ),
                          ),
                        );
                      }
                    }
                  },
                ),
        ],
      ),
    );
  }
}

class ChartExistingStudent extends StatefulWidget {
  final List groupedRecords;
  final String name;
  const ChartExistingStudent({
    Key? key,
    required this.groupedRecords,
    required this.name,
  }) : super(key: key);

  @override
  State<ChartExistingStudent> createState() =>
      _ChartExistingStudentState();
}

class _ChartExistingStudentState extends State<ChartExistingStudent> {
  late List<ChartExistingData> datasource;

  @override
  void initState() {
    datasource = widget.groupedRecords
        .map((e) => ChartExistingData(e['label'], e['count']))
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 28.0,
      ),
      child: SfCartesianChart(
        margin: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 10.0,
        ),
        borderColor: Colors.black,
        borderWidth: 1.0,
        enableSideBySideSeriesPlacement: true,
        primaryXAxis: CategoryAxis(
          isVisible: true,
        ),
        legend: Legend(
          isVisible: true,
          isResponsive: true,
        ),
        series: [
          BarSeries(
            width: 0.2,
            spacing: 0,
            name: widget.name,
            yAxisName: "Number of Students",
            isVisible: true,
            dataSource: datasource,
            xValueMapper: (ChartExistingData data, _) => data.yearName,
            yValueMapper: (ChartExistingData data, _) => data.count,
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
            ),
          ),
        ],
      ),
    );
  }
}

class ChartExistingData {
  ChartExistingData(this.yearName, this.count);
  final String yearName;
  final double count;
}

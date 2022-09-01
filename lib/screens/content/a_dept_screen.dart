import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../widgets/avatar_generator.dart';

import '../../api/fetches.dart';

class ScreenCollegeDeptInfo extends StatefulWidget {
  static const routeName = "/screen-college-dept-info";
  const ScreenCollegeDeptInfo({Key? key}) : super(key: key);

  @override
  State<ScreenCollegeDeptInfo> createState() => _ScreenCollegeDeptInfoState();
}

class _ScreenCollegeDeptInfoState extends State<ScreenCollegeDeptInfo> {
  var collegeId;
  var collegeName;

  late String selectedDeptName = "";

  int totalStudents = 0;
  int boys = 0;
  int girls = 0;
  int others = 0;

  void getCounts(data) {
    for (var record in data) {
      if (kDebugMode) {
        log('getcoynrs');
        log(record.toString());
      }
      if (record['department_id'][1] != null &&
          selectedDeptName != "" &&
          identical(record['department_id'][0].toString(), selectedDeptName)) {
        setState(() {
          totalStudents = record['totalStudents'];
          boys = record['boys'];
          girls = record['girls'];
          others = record['trans'];
        });
        break;
      }
    }
  }

  List<String> deptNameProcessor(List records) {
    List<String> deptNames = [""];
    if (kDebugMode) {
      log('processing dept names');
      log(records.toString());
    }

    records.forEach((entry) {
      if (kDebugMode) {
        log(entry.toString());
      }
      var deptName = entry['department_id'][1];
      deptNames.add(deptName);
    });

    if (kDebugMode) {
      log('deptName');
      log(deptNames.toSet().toList().toString());
    }
    return deptNames;
  }

  void callbackDeptSelector(String deptName, data, collegeId) async {
    var information =
        await fetchStudentCountsForGivenDeptCollege(collegeId, deptName);

    setState(() {
      selectedDeptName = deptName;
      totalStudents = information['total'];
      boys = information['boys'];
      girls = information['girls'];
      others = information['trans'];
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    collegeId = arguments['collegeId'];
    collegeName = arguments['collegeName'];

    if (kDebugMode) {
      log(arguments.toString());
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(collegeName.toString()),
      ),
      body: FutureBuilder(
          future: fetchDeptsForCollege(collegeId),
          builder: (BuildContext ctx, AsyncSnapshot snapshot) {
            if (kDebugMode) {
              log(snapshot.data.toString());
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.10,
                  height: MediaQuery.of(context).size.height * 0.10,
                  child: const CircularProgressIndicator.adaptive(),
                ),
              );
            } else if (snapshot.hasData &&
                snapshot.data != null &&
                snapshot.data.isNotEmpty) {
              String profileImageString = snapshot.data['dp'].toString();
              var data = snapshot.data['data'];
              return Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    AvatarGeneratorNewTwo(base64Code: profileImageString),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.80,
                      height: MediaQuery.of(context).size.height * 0.65,
                      decoration: const BoxDecoration(
                          // color: Color.fromARGB(255, 255, 203, 200),
                          ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.80,
                            height: MediaQuery.of(context).size.height * 0.15,
                            child: DropdownDeptSelector(
                              data: data,
                              collegeId: collegeId,
                              callbackDeptName: callbackDeptSelector,
                              deptNames: deptNameProcessor(data),
                            ),
                          ),
                          (selectedDeptName != "")
                              ? Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.50,
                                  height:
                                      MediaQuery.of(context).size.height * 0.40,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                  ),
                                  decoration: const BoxDecoration(
                                      // color: Color.fromARGB(255, 168, 204, 235),
                                      ),
                                  child: StudentCountChart(
                                    totalStudents: totalStudents.toDouble(),
                                    boys: boys.toDouble(),
                                    girls: girls.toDouble(),
                                    trans: others.toDouble(),
                                    deptName: selectedDeptName,
                                  ),
                                )
                              : const SizedBox(
                                  height: 0,
                                  width: 0,
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox(
                height: 0,
                width: 0,
              );
            }
          }),
    );
  }
}

class DropdownDeptSelector extends StatefulWidget {
  final List data;
  final int collegeId;
  final List<String> deptNames;
  final Function(String, List, int) callbackDeptName;
  const DropdownDeptSelector({
    Key? key,
    required this.data,
    required this.callbackDeptName,
    required this.collegeId,
    required this.deptNames,
  }) : super(key: key);

  @override
  State<DropdownDeptSelector> createState() => _DropdownDeptSelectorState();
}

class _DropdownDeptSelectorState extends State<DropdownDeptSelector> {
  late List<String> deptNames;
  late String selectedOption;

  @override
  void initState() {
    super.initState();

    setState(() {
      deptNames = widget.deptNames;
      selectedOption = widget.deptNames[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(),
      width: MediaQuery.of(context).size.width * 0.40,
      height: MediaQuery.of(context).size.height * 0.15,
      child: DropdownButton(
          value: selectedOption,
          items: deptNames
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              selectedOption = value.toString();
            });
            widget.callbackDeptName(
                selectedOption, widget.data, widget.collegeId);
          }),
    );
  }
}

class StudentCountChart extends StatefulWidget {
  final double totalStudents;
  final double boys;
  final double girls;
  final double trans;
  final String deptName;

  const StudentCountChart({
    Key? key,
    required this.deptName,
    required this.totalStudents,
    required this.boys,
    required this.girls,
    required this.trans,
  }) : super(key: key);

  @override
  State<StudentCountChart> createState() => _StudentCountChartState();
}

class _StudentCountChartState extends State<StudentCountChart> {
  late List<ChartData> datasource;

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      log([
        widget.deptName,
        widget.totalStudents.toDouble(),
        widget.boys.toDouble(),
        widget.girls.toDouble(),
        widget.trans.toDouble(),
      ].toString());
    }

    datasource = [
      ChartData(
        "Student Count \n${widget.deptName}",
        widget.totalStudents.toDouble(),
        widget.boys.toDouble(),
        widget.girls.toDouble(),
        widget.trans.toDouble(),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.50,
      height: MediaQuery.of(context).size.height * 0.40,
      child: SingleChildScrollView(
        child: SfCartesianChart(
          enableSideBySideSeriesPlacement: true,
          primaryXAxis: CategoryAxis(
            isVisible: true,
          ),
          primaryYAxis: NumericAxis(),
          legend: Legend(
            isVisible: true,
          ),
          series: [
            ColumnSeries(
              name: "Total",
              yAxisName: "Total",
              // isVisibleInLegend: true,
              isVisible: true,
              dataSource: [datasource[0]],
              xValueMapper: (ChartData data, _) => data.deptName,
              yValueMapper: (ChartData data, _) => data.total,
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
              ),
            ),
            ColumnSeries(
              name: "Boys",
              yAxisName: "Boys",
              // isVisibleInLegend: true,
              isVisible: true,
              dataSource: [datasource[0]],
              xValueMapper: (ChartData data, _) => data.deptName,
              yValueMapper: (ChartData data, _) => data.boys,
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
              ),
            ),
            ColumnSeries(
              name: "Girls",
              yAxisName: "Girls",
              // isVisibleInLegend: true,
              isVisible: true,
              dataSource: [datasource[0]],
              xValueMapper: (ChartData data, _) => data.deptName,
              yValueMapper: (ChartData data, _) => data.girls,
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
              ),
            ),
            ColumnSeries(
              name: "Trans",
              yAxisName: "Trans",
              // isVisibleInLegend: true,
              isVisible: true,
              dataSource: [datasource[0]],
              xValueMapper: (ChartData data, _) => data.deptName,
              yValueMapper: (ChartData data, _) => data.trans,
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.deptName, this.total, this.boys, this.girls, this.trans);
  final String deptName;
  final double total;
  final double boys;
  final double girls;
  final double trans;
}

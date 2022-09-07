import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';
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
              log("dept snapshot.data.toString()");
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
              return Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    // color: Colors.redAccent,
                    ),
                margin: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                ),
                padding: const EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
                ),
                child: TableDeptFacultyCount(
                  records: snapshot.data,
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

class TableDeptFacultyCount extends StatefulWidget {
  final List records;
  const TableDeptFacultyCount({
    Key? key,
    required this.records,
  }) : super(key: key);

  @override
  State<TableDeptFacultyCount> createState() => _TableDeptFacultyCountState();
}

class _TableDeptFacultyCountState extends State<TableDeptFacultyCount> {
  ScrollController verticalBodyController =
      ScrollController(initialScrollOffset: 0.0);

  ScrollController verticalTitleController =
      ScrollController(initialScrollOffset: 0.0);

  ScrollController horizontalTitleController =
      ScrollController(initialScrollOffset: 0.0);

  ScrollController horizontalBodyController =
      ScrollController(initialScrollOffset: 0.0);

  ScrollControllers scrollControllers() {
    return ScrollControllers(
      verticalTitleController: verticalTitleController,
      verticalBodyController: verticalBodyController,
      horizontalTitleController: horizontalTitleController,
      horizontalBodyController: horizontalBodyController,
    );
  }

  var cellColor = const Color.fromARGB(255, 187, 238, 231);

  late List<String> teacherTypeNames = [];

  int calculateStaffCount(entries) {
    int sum = 0;
    // if (kDebugMode) {
    //   log(entries.toString());
    // }
    for (var entry in entries) {
      var key = entry.keys.toList()[0];
      sum = sum + int.parse(entry[key].toString());
    }
    return sum;
  }

  void getListOfTeacherTypeNames() {
    List<String> tmp = [];

    var firstEntryOfRecords = widget.records[0]['facultyCounts'];

    for (var item in firstEntryOfRecords) {
      var key = item.keys.toList()[0];
      tmp.add(key.toString());
    }
    setState(() {
      teacherTypeNames = tmp;
    });
  }

  String findThisTeacherTypeCount(int rowIndex, int index) {
    // int val = 0;
    var teacherTypeName = teacherTypeNames[index];
    var facultyCounts = widget.records[rowIndex]['facultyCounts'];
    for (var item in facultyCounts) {
      var key = item.keys.toList()[0];
      if (key == teacherTypeName) {
        return item[key].toString();
      }
    }
    return "0";
  }

  @override
  void initState() {
    getListOfTeacherTypeNames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 45.0,
      ),
      child: StickyHeadersTable(
        initialScrollOffsetX: 0,
        initialScrollOffsetY: 0,
        cellAlignments: const CellAlignments.uniform(
          Alignment.center,
        ),
        cellDimensions: CellDimensions.variableColumnWidthAndRowHeight(
          columnWidths: [
                MediaQuery.of(context).size.width * 0.12,
                MediaQuery.of(context).size.width * 0.12,
              ] +
              List<double>.generate(
                teacherTypeNames.length,
                (index) => MediaQuery.of(context).size.width * 0.05,
              ),
          rowHeights: List<double>.generate(widget.records.length,
              (index) => MediaQuery.of(context).size.height * 0.08),
          stickyLegendWidth: MediaQuery.of(context).size.width * 0.12,
          stickyLegendHeight: MediaQuery.of(context).size.height * 0.09,
        ),
        scrollControllers: scrollControllers(),
        columnsLength: 2 + teacherTypeNames.length,
        rowsLength: widget.records.length,
        columnsTitleBuilder: (colIndex) =>
            colIndex < 2 + teacherTypeNames.length
                ? Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                    ),
                    child: colIndex == 0
                        ? const Text(
                            "HoD",
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          )
                        : colIndex == 1
                            ? const Text(
                                "Number of Faculty",
                                maxLines: 3,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                teacherTypeNames[colIndex - 2],
                                maxLines: 3,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                  )
                : const SizedBox(
                    width: 0,
                    height: 0,
                  ),
        rowsTitleBuilder: (rowIndex) => Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: cellColor,
          ),
          child: Text(
            widget.records[rowIndex]['deptName'] == null ||
                    widget.records[rowIndex]['deptName'] == false
                ? ""
                : widget.records[rowIndex]['deptName'].toString(),
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        contentCellBuilder: (columnIndex, rowIndex) =>
            columnIndex == 0 || columnIndex == 1
                ? Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: cellColor,
                    ),
                    child: columnIndex == 0
                        ? Text(
                            widget.records[rowIndex]['HoD'] == null ||
                                    widget.records[rowIndex]['HoD'] == false
                                ? ""
                                : widget.records[rowIndex]['HoD'].toString(),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 15),
                          )
                        : Text(
                            calculateStaffCount(
                                    widget.records[rowIndex]['facultyCounts'])
                                .toString(),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 15),
                          ),
                  )
                : columnIndex < teacherTypeNames.length + 2 && columnIndex > 1
                    ? Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: cellColor,
                        ),
                        child: Text(
                          findThisTeacherTypeCount(rowIndex, columnIndex - 2)
                              .toString(),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      )
                    : const SizedBox(
                        width: 0,
                        height: 0,
                      ),
        legendCell: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Colors.blueAccent,
          ),
          child: const Text(
            "Department Name",
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

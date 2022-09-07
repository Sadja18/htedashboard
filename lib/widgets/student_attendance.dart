import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './courses_selector.dart';

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
  String selectedCourse = "";

  void courseSelector(String selectedCourseName) {
    if (kDebugMode) {
      log("in student attendance main $selectedCourseName");
    }
    setState(() {
      selectedCourse = selectedCourseName;
    });
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
                            fontSize: 20,
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
              ? const Padding(
                  padding: EdgeInsets.all(28.0),
                  child: SizedBox(
                    child: Text(
                      "Please select a course",
                    ),
                  ),
                )
              : Center(
                  child: SizedBox(
                    child: FutureBuilder(
                        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.10,
                            height: MediaQuery.of(context).size.height * 0.10,
                            child: const CircularProgressIndicator.adaptive(),
                          ),
                        );
                      } else {
                        if (snapshot.hasData &&
                            snapshot.data != null &&
                            snapshot.data.isNotEmpty) {
                          return Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.10,
                            height: MediaQuery.of(context).size.height * 0.12,
                            margin: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              selectedCourse,
                            ),
                          );
                        } else {
                          return Center(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 20.0,
                              ),
                              width: MediaQuery.of(context).size.width * 0.10,
                              height: MediaQuery.of(context).size.height * 0.10,
                              child: Text(
                                "Unable to fetch records for course $selectedCourse",
                              ),
                            ),
                          );
                        }
                      }
                    }),
                  ),
                ),
        ],
      ),
    );
  }
}

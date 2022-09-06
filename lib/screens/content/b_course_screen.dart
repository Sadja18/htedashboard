import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

import '../../api/fetches.dart';

class ScreenCollegeCourseInfo extends StatefulWidget {
  static const routeName = '/screen-college-course-info';
  const ScreenCollegeCourseInfo({Key? key}) : super(key: key);

  @override
  State<ScreenCollegeCourseInfo> createState() =>
      _ScreenCollegeCourseInfoState();
}

class _ScreenCollegeCourseInfoState extends State<ScreenCollegeCourseInfo> {
  var collegeId;
  var collegeName;

  late String selectedCourseName = "";

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
          selectedCourseName != "" &&
          identical(
              record['department_id'][0].toString(), selectedCourseName)) {
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

  List<String> courseNameProcessor(List records) {
    List<String> courseNames = [""];
    if (kDebugMode) {
      log('processing course names');
      log(records.toString());
    }

    records.forEach((entry) {
      if (kDebugMode) {
        log(entry.toString());
      }
      var courseName = entry['name'];
      courseNames.add(courseName);
    });

    if (kDebugMode) {
      log('courseName');
      log(courseNames.toSet().toList().toString());
    }
    return courseNames;
  }

  void callbackCourseSelector(String courseName, data, collegeId) async {
    if (kDebugMode) {
      log("parent log $courseName $collegeId");
    }
    var information =
        await fetchStudentCountsForGivenCourseCollege(collegeId, courseName);

    // setState(() {
    //   selectedCourseName = courseName;
    //   totalStudents = information['total'];
    //   boys = information['boys'];
    //   girls = information['girls'];
    //   others = information['trans'];
    // });
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    collegeId = arguments['collegeId'];
    collegeName = arguments['collegeName'];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(collegeName.toString()),
      ),
      body: FutureBuilder(
        future: fetchCourseDataForCollege(collegeId),
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
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
            var data = snapshot.data;
            return Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.92,
              margin: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              padding: const EdgeInsets.only(
                left: 19.0,
              ),
              decoration: const BoxDecoration(
                  // color: Color.fromARGB(255, 240, 90, 82),
                  ),
              child: CouseInfoStickyHeader(courseInfo: data),
            );
          } else {
            return const SizedBox(
              height: 0,
              width: 0,
            );
          }
        },
      ),
    );
  }
}

class CouseInfoStickyHeader extends StatefulWidget {
  final List courseInfo;
  const CouseInfoStickyHeader({
    Key? key,
    required this.courseInfo,
  }) : super(key: key);

  @override
  State<CouseInfoStickyHeader> createState() => _CouseInfoStickyHeaderState();
}

class _CouseInfoStickyHeaderState extends State<CouseInfoStickyHeader> {
  ScrollControllers scrollControllers() {
    return ScrollControllers(
      verticalTitleController: verticalTitleController,
      verticalBodyController: verticalBodyController,
      horizontalTitleController: horizontalTitleController,
      horizontalBodyController: horizontalBodyController,
    );
  }

  ScrollController verticalBodyController =
      ScrollController(initialScrollOffset: 0.0);
  ScrollController verticalTitleController =
      ScrollController(initialScrollOffset: 0.0);
  ScrollController horizontalTitleController =
      ScrollController(initialScrollOffset: 0.0);
  ScrollController horizontalBodyController =
      ScrollController(initialScrollOffset: 0.0);

  var cellColor = Color.fromARGB(255, 187, 238, 231);

  Widget colBuilder(colIndex) {
    switch (colIndex) {
      case 0:
        return const Text(
          "Code",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        );
      case 1:
        return const Text(
          "Duration (yrs)",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        );
      case 2:
        return const Text("");
      case 3:
        return const Text(
          "Department",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        );
      case 4:
        return const Text(
          "Total Students",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        );
      case 5:
        return const Text(
          "Male Students",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        );
      case 6:
        return const Text(
          "Female Students",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        );
      case 7:
        return const Text(
          "Trans Students",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        );
      default:
        return const SizedBox(
          width: 0,
          height: 0,
        );
    }
  }

  Widget rowBuilder(rowIndex) {
    return Text(
      widget.courseInfo[rowIndex]['courseName'].toString(),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  Widget contentBuilder(rowIndex, colIndex) {
    switch (colIndex) {
      case 0:
        return Text(
          widget.courseInfo[rowIndex]['courseCode'].toString(),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
        );
      case 1:
        return Text(
          widget.courseInfo[rowIndex]['courseDuration'].toString(),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
        );
      case 2:
        return const Text("");
      case 3:
        return Text(
          widget.courseInfo[rowIndex]['courseDept'] != false
              ? widget.courseInfo[rowIndex]['courseDept'][1]
              : "".toString(),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
        );
      case 4:
        return Text(
          widget.courseInfo[rowIndex]['totalStudents'].toString(),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
        );
      case 5:
        return Text(
          widget.courseInfo[rowIndex]['maleStudents'].toString(),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
        );
      case 6:
        return Text(
          widget.courseInfo[rowIndex]['femaleStudents'].toString(),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
        );
      case 7:
        return Text(
          widget.courseInfo[rowIndex]['transStudents'].toString(),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
        );

      default:
        return const Text("");
    }
  }

  @override
  Widget build(BuildContext context) {
    return StickyHeadersTable(
      cellDimensions: CellDimensions.variableColumnWidthAndRowHeight(
        columnWidths: [
          MediaQuery.of(context).size.width * 0.12,
          MediaQuery.of(context).size.width * 0.11,
          MediaQuery.of(context).size.width * 0,
          MediaQuery.of(context).size.width * 0.12,
          MediaQuery.of(context).size.width * 0.11,
          MediaQuery.of(context).size.width * 0.11,
          MediaQuery.of(context).size.width * 0.11,
          MediaQuery.of(context).size.width * 0.11,
        ],
        rowHeights: List<double>.generate(widget.courseInfo.length,
            (int index) => MediaQuery.of(context).size.height * 0.10),
        stickyLegendWidth: MediaQuery.of(context).size.width * 0.18,
        stickyLegendHeight: MediaQuery.of(context).size.height * 0.10,
      ),
      initialScrollOffsetX: 0.0,
      initialScrollOffsetY: 0.0,
      scrollControllers: scrollControllers(),
      columnsLength: 8,
      rowsLength: widget.courseInfo.length,
      columnsTitleBuilder: (colIndex) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.blueAccent,
          ),
          child: Center(child: colBuilder(colIndex)),
        );
      },
      rowsTitleBuilder: (rowIndex) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: cellColor,
          ),
          child: Center(child: rowBuilder(rowIndex)),
        );
      },
      contentCellBuilder: (colIndex, rowIndex) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: cellColor,
          ),
          child: Center(
            child: contentBuilder(rowIndex, colIndex),
          ),
        );
      },
      legendCell: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.blueAccent,
        ),
        child: const Text(
          "Course Name",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}

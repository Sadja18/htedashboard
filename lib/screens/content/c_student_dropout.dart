import 'package:flutter/material.dart';
import '../../widgets/student_dropout.dart';
import '../../widgets/student_attendance.dart';

class ScreenStudentDropoutInfo extends StatefulWidget {
  static const routeName = "/screen-student-dropout-info";
  const ScreenStudentDropoutInfo({Key? key}) : super(key: key);

  @override
  State<ScreenStudentDropoutInfo> createState() =>
      _ScreenStudentDropoutInfoState();
}

class _ScreenStudentDropoutInfoState extends State<ScreenStudentDropoutInfo> {
  var collegeId;
  var collegeName;
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    collegeId = arguments['collegeId'];
    collegeName = arguments['collegeName'];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(collegeName),
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text("Student Dropouts"),
              ),
              Tab(
                child: Text("Student Attendance"),
              ),
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            StudentDropoutWidget(collegeId: collegeId),
            StudentAttendanceWidget(collegeId: collegeId),
          ],
        ),
      ),
    );
  }
}

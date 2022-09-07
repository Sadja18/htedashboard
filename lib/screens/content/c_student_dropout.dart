import 'package:flutter/material.dart';
import '../../widgets/student_dropout.dart';

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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(collegeName),
      ),
      body: StudentDropoutWidget(collegeId: collegeId),
    );
  }
}

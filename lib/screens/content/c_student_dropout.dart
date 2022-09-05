import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ScreenStudentDropoutInfo extends StatefulWidget {
  static const routeName = "/screen-student-dropout-info";
  const ScreenStudentDropoutInfo({Key? key}) : super(key: key);

  @override
  State<ScreenStudentDropoutInfo> createState() =>
      _ScreenStudentDropoutInfoState();
}

class _ScreenStudentDropoutInfoState extends State<ScreenStudentDropoutInfo> {
  var collegeId = 13;
  var collegeName = "Government College Daman";
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
      body: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.80,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: const CircularProgressIndicator.adaptive(),
          );
        } else {
          if (snapshot.hasData && snapshot.data != null) {
            var data = snapshot.data;
            return Text(data.toString());
          } else {
            return const Center(
              child: SizedBox(
                child: Text("No records found"),
              ),
            );
          }
        }
      }),
    );
  }
}

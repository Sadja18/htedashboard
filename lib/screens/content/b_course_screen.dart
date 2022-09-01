import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../widgets/avatar_generator.dart';
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
    // var information =
    //     await fetchStudentCountsForGivenCourseCollege(collegeId, courseName);

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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.40,
                            height: MediaQuery.of(context).size.height * 0.08,
                            child: DropdownCourseSelector(
                              data: data,
                              collegeId: collegeId,
                              callbackCourseName: callbackCourseSelector,
                              courseNames: courseNameProcessor(data),
                            ),
                          ),
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
        },
      ),
    );
  }
}

class DropdownCourseSelector extends StatefulWidget {
  final List data;
  final List<String> courseNames;
  final Function(String, List, int) callbackCourseName;
  final int collegeId;
  const DropdownCourseSelector({
    Key? key,
    required this.courseNames,
    required this.callbackCourseName,
    required this.collegeId,
    required this.data,
  }) : super(key: key);

  @override
  State<DropdownCourseSelector> createState() => _DropdownCourseSelectorState();
}

class _DropdownCourseSelectorState extends State<DropdownCourseSelector> {
  late List<String> courseNames;
  late String selectedOption;

  @override
  void initState() {
    super.initState();

    setState(() {
      courseNames = widget.courseNames;
      selectedOption = widget.courseNames[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: DropdownButton(
          items: courseNames
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ),
              )
              .toList(),
          onChanged: (value) {
            setState(() {
              selectedOption = value.toString();
            });

            widget.callbackCourseName(
                selectedOption, widget.data, widget.collegeId);
          }),
    );
  }
}

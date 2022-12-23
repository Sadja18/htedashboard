import 'dart:developer';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../api/fetches.dart';

class SelectorCourseFuture extends StatefulWidget {
  final int collegeId;
  final Function(String) courseSelector;
  const SelectorCourseFuture({
    Key? key,
    required this.collegeId,
    required this.courseSelector,
  }) : super(key: key);

  @override
  State<SelectorCourseFuture> createState() =>
      _SelectorCourseFutureState();
}

class _SelectorCourseFutureState extends State<SelectorCourseFuture> {
  late Future<dynamic> _courseFuture;

  @override
  void initState() {
    _courseFuture = fetchAllCoursesInCollege(widget.collegeId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _courseFuture,
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(child: CircularProgressIndicator.adaptive()),
            );
          } else {
            if (snapshot.hasData && snapshot.data != null) {
              return SelectorCourseDropdown(
                courseNames: snapshot.data,
                selectedCourse: widget.courseSelector,
              );
            } else {
              return const Center(
                child: SizedBox(
                  child: Text(
                    "No records found",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              );
            }
          }
        });
  }
}

class SelectorCourseDropdown extends StatefulWidget {
  final List<String> courseNames;
  final Function(String) selectedCourse;
  const SelectorCourseDropdown(
      {Key? key, required this.courseNames, required this.selectedCourse})
      : super(key: key);

  @override
  State<SelectorCourseDropdown> createState() =>
      _SelectorCourseDropdownState();
}

class _SelectorCourseDropdownState extends State<SelectorCourseDropdown> {
  late String selectedCourseName;
  late List<String> courseNames;

  @override
  void initState() {
    List<String> tmp = [""];
    for (var courseName in widget.courseNames) {
      tmp.add(courseName);
    }

    setState(() {
      courseNames = tmp;
    });
    setState(() {
      selectedCourseName = courseNames[0];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.50,
      height: MediaQuery.of(context).size.height * 0.08,
      alignment: Alignment.center,
      decoration: const BoxDecoration(),
      child: DropdownButton(
        value: selectedCourseName,
        items: courseNames
            .map(
              (e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e.toString(),
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  )),
            )
            .toList(),
        onChanged: (selectedValue) {
          if (kDebugMode) {
            log('dropdown $selectedValue');
          }
          setState(() {
            selectedCourseName = selectedValue.toString();
          });
          widget.selectedCourse(selectedCourseName.toString());
        },
      ),
    );
  }
}

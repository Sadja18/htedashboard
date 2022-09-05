import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class SelectorCourseFuture extends StatefulWidget {
  const SelectorCourseFuture({Key? key}) : super(key: key);

  @override
  State<SelectorCourseFuture> createState() => _SelectorCourseFutureState();
}

class _SelectorCourseFutureState extends State<SelectorCourseFuture> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (BuildContext ctx, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: SizedBox(child: CircularProgressIndicator.adaptive()),
        );
      } else {
        if (snapshot.hasData && snapshot.data != null) {
          return Text(snapshot.data.toString());
        } else {
          return const Center(
            child: SizedBox(
              child: Text("No records found"),
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
  State<SelectorCourseDropdown> createState() => _SelectorCourseDropdownState();
}

class _SelectorCourseDropdownState extends State<SelectorCourseDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.80,
      height: MediaQuery.of(context).size.height * 0.10,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Text(widget.courseNames.toString()),
      ),
    );
  }
}

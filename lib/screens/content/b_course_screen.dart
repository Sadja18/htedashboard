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
        future: fetchCourseInfoForCollege(collegeId),
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
                  Text(data.toString()),
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

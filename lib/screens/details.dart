import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

import '../views/counts_institute_staff.dart';
import '../views/counts_institute_students.dart';
import '../views/list_institutes.dart';

class ScreenDetailTables extends StatelessWidget {
  static const routeName = "/screen-one-table-screen";
  const ScreenDetailTables({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 5.0,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 5.0,
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListInstitutes(),
            CountInstituteWiseStaff(),
            CountInstituteWiseStudent(),
          ],
        ),
      ),
    );
  }
}

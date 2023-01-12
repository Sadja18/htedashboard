// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import './screens/login.dart';

import './base_view.dart';
import './screens/details.dart';
import './screens/summary.dart';
import './screens/gender_parity_index_screen.dart';
import './screens/attendance.dart';
import './screens/content/a_dept_screen.dart';
import './screens/content/b_course_screen.dart';
import './screens/content/c_student_dropout.dart';
import './screens/content/d_teaching_staff_screen.dart';
import './screens/content/e_ntstaff_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HTE',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
              fontSizeFactor: 1.50,
              fontSizeDelta: 0.5,
              // fontFamily: 'Poppins',
            ),
        primarySwatch: Colors.blue,
      ),

      // home: BaseView(),
      routes: {
        "/": (ctx) => login(),
        ScreenDetailTables.routeName: (ctx) => ScreenDetailTables(),
        SummaryScreen.routeName: (ctx) => SummaryScreen(),
        GPIScreen.routeName: (ctx) => GPIScreen(),
        ScreenAttendancePercentages.routeName: (ctx) =>
            ScreenAttendancePercentages(),
        ScreenCollegeDeptInfo.routeName: (ctx) => ScreenCollegeDeptInfo(),
        ScreenCollegeCourseInfo.routeName: (ctx) => ScreenCollegeCourseInfo(),
        ScreenTeachingStaffInfo.routename: (ctx) => ScreenTeachingStaffInfo(),
        ScreenNtStaff.routeName: (ctx) => ScreenNtStaff(),
        ScreenStudentDropoutInfo.routeName: (ctx) => ScreenStudentDropoutInfo(),
      },
      // debugShowCheckedModeBanner: false,
    );
  }
}

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(MyApp());
// }

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ScreenNtStaff extends StatefulWidget {
  static const routeName = "/screen-ntstaff-info";
  const ScreenNtStaff({Key? key}) : super(key: key);

  @override
  State<ScreenNtStaff> createState() => _ScreenNtStaffState();
}

class _ScreenNtStaffState extends State<ScreenNtStaff> {
  var collegeId;
  var collegeName;
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    collegeId = arguments['collegeId'];
    collegeName = arguments['collegeName'];

    return Scaffold(
      appBar: AppBar(
        title: Text(collegeName),
        centerTitle: true,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width * 0.90,
        height: MediaQuery.of(context).size.height * 0.90,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.80,
                height: MediaQuery.of(context).size.height * 0.15,
                child: Center(
                  child: Text("Selectors(Post, Appnt Type, Department)"),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.80,
                height: MediaQuery.of(context).size.height * 0.70,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text("Charts"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

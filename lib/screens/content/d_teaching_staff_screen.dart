// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ScreenTeachingStaffInfo extends StatefulWidget {
  static const routename = '/screen-teaching-staff-info';
  const ScreenTeachingStaffInfo({Key? key}) : super(key: key);

  @override
  State<ScreenTeachingStaffInfo> createState() =>
      _ScreenTeachingStaffInfoState();
}

class _ScreenTeachingStaffInfoState extends State<ScreenTeachingStaffInfo> {
  var collegeName;
  var collegeId;
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
              Text("Selectors(Dept, Teacher Type, Appnt Type) row widget"),
              Text('Charts (Appnt Type, Teacher Type,)')
            ],
          ),
        ),
      ),
    );
  }
}

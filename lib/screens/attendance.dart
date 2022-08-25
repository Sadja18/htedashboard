// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:dashboard/models/local_data.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/foundation.dart';
import '../widgets/selectors.dart';
import '../api/fetches.dart';

class ScreenAttendancePercentages extends StatefulWidget {
  static const routeName = "/screen-attendance-percentage";
  const ScreenAttendancePercentages({Key? key}) : super(key: key);

  @override
  State<ScreenAttendancePercentages> createState() =>
      _ScreenAttendancePercentagesState();
}

class _ScreenAttendancePercentagesState
    extends State<ScreenAttendancePercentages> {
  late String selectedBlock;
  late String selectedCluster;
  late String selectedCity;
  late int selectedCollegeId;
  late List<String> block;
  late List<String> cluster;
  late List<String> city;
  late List<String> colleges;

  void baserecords() async {
    var records = await fetchSelectorBaseRecords();

    if (records != false && records != null) {
      processRecords(records);
    }
  }

  void processRecords(data) {
    List collFetch = data['colleges'];
    List cityFetch = data['cities'];
    List clustFetch = data['clusters'];
    List blockFetch = data['blocks'];

    List<String> list = [
      "",
    ];
    for (var element in blockFetch) {
      for (var val in element.values) {
        list.add(val.toString());
      }
    }

    setState(() {
      block = list.toSet().toList();
    });
    if (kDebugMode) {
      // log(list.toString());
      log(list.toSet().toList().length.toString());
      log(block.toString());
    }
    list = [""];
    for (var element in clustFetch) {
      for (var val in element.values) {
        list.add(val.toString());
      }
    }
    setState(() {
      cluster = list.toSet().toList();
    });
    list = [""];
    for (var element in cityFetch) {
      for (var val in element.values) {
        list.add(val.toString());
      }
    }
    setState(() {
      city = list.toSet().toList();
    });
    list = [""];
    for (var element in collFetch) {
      for (var val in element.values) {
        list.add(val.toString());
      }
    }
    setState(() {
      colleges = list.toSet().toList();
    });
    list = [];
  }

  void districtCallback(String districtName) {
    if (kDebugMode) {
      log('district call back');
    }
  }

  @override
  void initState() {
    baserecords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Attendance"),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(
            horizontal: 40.0,
            vertical: 10.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: const <int, TableColumnWidth>{
                  0: FractionColumnWidth(0.25),
                  1: FractionColumnWidth(0.25),
                  2: FractionColumnWidth(0.25),
                  3: FractionColumnWidth(0.25)
                },
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.20,
                          child: Selector(
                            optionNames: block,
                            selectorCallback: districtCallback,
                          ),
                        ),
                      ),
                      TableCell(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.20,
                          child: Selector(
                            optionNames: cluster,
                            selectorCallback: districtCallback,
                          ),
                        ),
                      ),
                      TableCell(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.20,
                          child: Selector(
                            optionNames: city,
                            selectorCallback: districtCallback,
                          ),
                        ),
                      ),
                      TableCell(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.20,
                          child: Selector(
                            optionNames: colleges,
                            selectorCallback: districtCallback,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Text("Analytics"),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:developer';

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
  late List block;
  late List cluster;
  late List city;
  late List colleges;

  void districtCallback(String districtName) {
    if (kDebugMode) {
      log('district call back');
    }
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
        child: FutureBuilder(
            future: fetchSelectorBaseRecords(),
            builder: (BuildContext contextOuter, AsyncSnapshot snapshotOuter) {
              if (snapshotOuter.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: const CircularProgressIndicator.adaptive(),
                );
              } else {
                if (snapshotOuter.hasData) {
                  return Text(snapshotOuter.data.toString());
                } else {
                  return Container(
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
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
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
                                    height: MediaQuery.of(context).size.height *
                                        0.20,
                                    child: Selector(
                                      optionNames: ["District 1", "District 2"],
                                      selectorCallback: districtCallback,
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.20,
                                    child: Selector(
                                      optionNames: ["Cluster 1", "Cluster 2"],
                                      selectorCallback: districtCallback,
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.20,
                                    child: Selector(
                                      optionNames: ["Village 1", "Village 2"],
                                      selectorCallback: districtCallback,
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.20,
                                    child: Selector(
                                      optionNames: ["College 1", "College 2"],
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
                  );
                }
              }
            }),
      ),
    );
  }
}

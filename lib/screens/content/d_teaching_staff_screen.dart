// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../api/fetches.dart';

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

  late Future<dynamic> _facultyProfileAnalytics;
  // late Future _facultyAttendanceAnalytics;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    collegeId = arguments['collegeId'];
    collegeName = arguments['collegeName'];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(collegeName),
          bottom: const TabBar(tabs: [
            Tab(
              child: Text("Profiles"),
            ),
            Tab(
              child: Text("Attendance"),
            ),
          ]),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ProfileTabChild(collegeId: collegeId),
            SizedBox(
              child: Text("Attendance"),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileTabChild extends StatefulWidget {
  final int collegeId;
  const ProfileTabChild({
    Key? key,
    required this.collegeId,
  }) : super(key: key);

  @override
  State<ProfileTabChild> createState() => _ProfileTabChildState();
}

class _ProfileTabChildState extends State<ProfileTabChild> {
  late Future<dynamic> _facultyProfileAnalytics;

  var selectedDeptName = "";
  var selectedDesignation = "";
  var selectedAppointmentType = "";

  List<String> getAllDept(counts) {
    List<String> values = [];

    values = counts.keys.toList();

    return values;
  }

  void deptNameCallback(String selectedVal) {
    if (kDebugMode) {
      log('selected dept $selectedVal');
    }
    setState(() {
      selectedDeptName = selectedVal;
      selectedDesignation = "";
      selectedAppointmentType = "";
    });
  }

  List<String> getAllDesignation(counts) {
    List<String> values = [];

    var deptName = counts.keys.toList()[0];
    if (kDebugMode) {
      print(counts[deptName].keys.toList());
    }

    values = counts[deptName].keys.toList();

    return values;
  }

  void designationCallback(String selectedVal) {
    if (kDebugMode) {
      log('selected designation $selectedVal');
    }
    setState(() {
      selectedDesignation = selectedVal;
      selectedAppointmentType = "";
    });
  }

  List<String> getAllAppointmentTypes(counts) {
    List<String> values = [];

    var deptName = counts.keys.toList()[0];

    var designation = counts[deptName].keys.toList()[0];
    var recordDesignation = counts[deptName][designation];

    values = recordDesignation.keys.toList();

    return values;
  }

  void appointmentTypeCallback(String selectedVal) {
    if (kDebugMode) {
      log('selected appointment type $selectedVal');
    }
    setState(() {
      selectedAppointmentType = selectedVal;
    });
  }

  Widget widgetDynamicSelector(
      String label, List<String> options, Function(String) callBackFunction) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: const {
          0: FractionColumnWidth(0.30),
          1: FractionColumnWidth(0.70)
        },
        children: [
          TableRow(
            children: [
              TableCell(
                child: Container(
                  decoration: const BoxDecoration(
                      // color: Colors.white,
                      ),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    label,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              TableCell(
                child: SizedBox(
                  // width: MediaQuery.of(context).size.width,
                  child: SelectorProfile(
                    stringValues: options,
                    callbackProfile: callBackFunction,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget showInfoBasedOnSelect() {
    if (selectedDeptName != "") {
      if (selectedDesignation != "") {
        if (selectedAppointmentType != "") {
          // iterate over the data variable to find profiles of all the faculty
          // matching criteria and display the info as individual rows in the
          // sticky table
        } else {
          // show count for all appointment types
          // as chart
        }
      } else {
        // show a sticky table
        // columns designation name; <all appointment types>
      }
    } else {
      // show a chart
      // department name; <all appointment types>
    }
    return Container();
  }

  @override
  void initState() {
    _facultyProfileAnalytics =
        fetchFacultyStaffProfileAnalytics(widget.collegeId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _facultyProfileAnalytics,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.10,
                height: MediaQuery.of(context).size.height * 0.05,
                child: const CircularProgressIndicator.adaptive(),
              ),
            );
          } else if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data.isNotEmpty) {
            var counts = snapshot.data['counts'];
            var data = snapshot.data['data'];

            // return Text("Info \n $counts \n $data");
            return Container(
              decoration: const BoxDecoration(
                  // color: Colors.amber,
                  ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.90,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.08,
                      decoration: const BoxDecoration(
                          // color: Colors.blueAccent,
                          ),
                      alignment: Alignment.center,
                      child: Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        columnWidths: const {
                          0: FractionColumnWidth(0.450),
                          1: FractionColumnWidth(0.300),
                          2: FractionColumnWidth(0.30),
                        },
                        children: [
                          TableRow(
                            children: [
                              TableCell(
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  child: Table(
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    columnWidths: {
                                      0: FractionColumnWidth(0.20),
                                      1: FractionColumnWidth(0.80),
                                    },
                                    children: [
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                              ),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Center(
                                                child: Text(
                                                  "Department: ",
                                                  textAlign: TextAlign.center,
                                                  maxLines: 2,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: SizedBox(
                                              // width: MediaQuery.of(context).size.width,
                                              child: SelectorProfile(
                                                stringValues:
                                                    getAllDept(counts),
                                                callbackProfile:
                                                    deptNameCallback,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              TableCell(
                                child: widgetDynamicSelector(
                                  "Designation: ",
                                  getAllDesignation(counts),
                                  designationCallback,
                                ),
                              ),
                              TableCell(
                                child: widgetDynamicSelector(
                                  "Appointment Type",
                                  getAllAppointmentTypes(counts),
                                  appointmentTypeCallback,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      height: MediaQuery.of(context).size.height * 0.70,
                      decoration: const BoxDecoration(),
                      alignment: Alignment.center,
                      child: showInfoBasedOnSelect(),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        });
  }
}

class SelectorProfile extends StatefulWidget {
  final List<String> stringValues;
  final Function(String) callbackProfile;
  const SelectorProfile({
    Key? key,
    required this.stringValues,
    required this.callbackProfile,
  }) : super(key: key);

  @override
  State<SelectorProfile> createState() => _SelectorProfileState();
}

class _SelectorProfileState extends State<SelectorProfile> {
  late List<String> options;
  late String selectedOption;

  @override
  void initState() {
    List<String> tmp = [""];
    if (widget.stringValues.isNotEmpty) {
      for (var dept in widget.stringValues) {
        tmp.add(dept);
      }
    }
    setState(() {
      options = tmp;
    });
    setState(() {
      selectedOption = "";
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (widget.stringValues.isNotEmpty)
        ? DropdownButton(
            underline: const SizedBox(),
            value: selectedOption,
            items: options
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e.toString(),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                    ),
                  ),
                )
                .toList(),
            onChanged: (selectedVal) {
              setState(() {
                selectedOption = selectedVal.toString();
              });

              widget.callbackProfile(selectedOption);
            })
        : const Text("");
  }
}

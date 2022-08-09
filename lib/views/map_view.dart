// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../models/local_data.dart' as localData;

var myMapboxToken =
    "pk.eyJ1Ijoic2FkamEiLCJhIjoiY2w1dXg5N29yMDQ2cjNldDJmcG1zYmc5ZCJ9.z_QoEiKHhuWFyXBj4jLuzQ";

var myUrlTemplate =
    "https://api.mapbox.com/styles/v1/sadja/cl5uyfih7000f14qosvxym6tl/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic2FkamEiLCJhIjoiY2w1dXg5N29yMDQ2cjNldDJmcG1zYmc5ZCJ9.z_QoEiKHhuWFyXBj4jLuzQ";

class MapViewInstitute extends StatefulWidget {
  const MapViewInstitute({Key? key}) : super(key: key);

  @override
  State<MapViewInstitute> createState() => _MapViewInstituteState();
}

class _MapViewInstituteState extends State<MapViewInstitute> {
  // LatLngBounds a = LatLngBounds();
  LatLng vapiBusStop = LatLng(20.380071292228884, 72.90839236138073);

  LatLng governmentEngineeringCollegeDaman =
      LatLng(20.413948413362892, 72.86147157672059);
  LatLng governmentPolytechnicDaman =
      LatLng(20.41379008533039, 72.86259918650929);
  LatLng governmentCollegeDaman = LatLng(20.4232, 72.8495);
  LatLng abdulKalamGovtCollege = LatLng(20.28857815568338, 73.0117148821264);

  Widget collegeDetailWidget() {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(
        8.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: FractionColumnWidth(0.50),
              1: FractionColumnWidth(0.50),
            },
            children: [
              TableRow(
                children: [
                  const TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "HoI: ",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        localData.college['Government College Daman']!['HoI']
                            .toString(),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  const TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Affliated To: ",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        localData.college['Government College Daman']![
                                'Affliated_To']
                            .toString(),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  const TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Email: ",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        localData.college['Government College Daman']!['Email']
                            .toString(),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  const TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Number of Departments: ",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        localData.college['Government College Daman']!['Depts']
                            .length
                            .toString(),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  const TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Number of Teaching Staff: ",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        localData.college['Government College Daman']![
                                'Number of Teaching Staff']
                            .toString(),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Table(
          //   defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          //   columnWidths: const {
          //     0: FractionColumnWidth(0.50),
          //     1: FractionColumnWidth(0.50),
          //   },
          // ),
        ],
      ),
    );
  }

  Future<void> showDetails(String collegeName) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) {
          return AlertDialog(
            title: Container(
              alignment: Alignment.center,
              child: Text(collegeName),
            ),
            content: Container(
              width: MediaQuery.of(context).size.width * 0.20,
              height: MediaQuery.of(context).size.height * 0.40,
              alignment: Alignment.center,
              child: collegeName == "Government College Daman"
                  ? collegeDetailWidget()
                  : const Text("College detail info"),
            ),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4.0,
                    vertical: 4.0,
                  ),
                  // ignore: prefer_const_constructors
                  child: Text(
                    "Close",
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  FlutterMap getMap() {
    return FlutterMap(
      options: MapOptions(
        minZoom: 8,
        maxZoom: 38,
        zoom: 11.6,
        center: vapiBusStop,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: myUrlTemplate,
          additionalOptions: {
            'accessToken': myMapboxToken,
            'id': "mapbox.mapbox-streets-v8",
          },
        ),
        PolygonLayerOptions(
          polygonCulling: false,
          polygons: [
            Polygon(
              borderStrokeWidth: 3.5,
              isFilled: true,
              labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black),
              points: [
                LatLng(20.41392495295493, 72.86237189934553),
                LatLng(20.413497186401866, 72.86260596657408),
                LatLng(20.41353557575646, 72.86279907203762),
                LatLng(20.413974310557645, 72.86267033506192),
              ],
              color: Colors.redAccent,
              borderColor: Colors.blue,
              label: "Government Polytechnic College, Daman",
            ),
            Polygon(
              borderStrokeWidth: 3.5,
              isFilled: true,
              labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black),
              points: [
                LatLng(20.41494888599428, 72.86022703174065),
                LatLng(20.414873473711797, 72.86054353240354),
                LatLng(20.414953913478453, 72.86131064417968),
                LatLng(20.41183181417045, 72.86239962103679),
                LatLng(20.41221893781033, 72.86184172156322),
                LatLng(20.412226479170286, 72.86182831051819),
                LatLng(20.41263622583855, 72.86182294610018),
                LatLng(20.412621143158432, 72.8618309927272),
                LatLng(20.41291274137879, 72.86068837168999),
              ],
              // color: Colors.redAccent,
              borderColor: Colors.blue,
              label: "Government Engineering College, Daman",
            ),
          ],
        ),
        MarkerLayerOptions(
          markers: [
            Marker(
              point: governmentEngineeringCollegeDaman,
              builder: (ctx) => Container(
                alignment: Alignment.center,
                child: GestureDetector(
                  onLongPress: () {
                    if (kDebugMode) {
                      log("Open the web page of college");
                    }
                  },
                  onTap: () async {
                    showDetails("Government Engineering College daman");
                  },
                  // ignore: prefer_const_constructors
                  child: Image.asset(
                    "assets/images/marker_hat_filled.png",
                    fit: BoxFit.cover,
                    semanticLabel: "Government Engineering College Daman",
                    height: 30,
                  ),
                ),
              ),
            ),
            // Polygon(points: []),
            Marker(
              point: governmentPolytechnicDaman,
              builder: (ctx) => Container(
                alignment: Alignment.center,
                child: GestureDetector(
                  onLongPress: () {
                    if (kDebugMode) {
                      log("Open the web page of college");
                    }
                  },
                  onTap: () async {
                    showDetails("Government Polytechnic Daman");
                  },
                  // ignore: prefer_const_constructors
                  child: Image.asset(
                    "assets/images/marker_hat_filled.png",
                    fit: BoxFit.cover,
                    semanticLabel: "Government Engineering College Daman",
                    height: 30,
                  ),
                ),
              ),
            ),
            Marker(
              point: governmentCollegeDaman,
              builder: (ctx) => Container(
                alignment: Alignment.center,
                child: GestureDetector(
                  onLongPress: () {
                    if (kDebugMode) {
                      log("Open the web page of college");
                    }
                  },
                  onTap: () async {
                    showDetails("Government College Daman");
                  },
                  // ignore: prefer_const_constructors
                  child: Image.asset(
                    "assets/images/marker_hat_filled.png",
                    fit: BoxFit.cover,
                    semanticLabel: "Government College Daman",
                    height: 30,
                  ),
                ),
              ),
            ),
            Marker(
              point: abdulKalamGovtCollege,
              builder: (ctx) => Container(
                alignment: Alignment.center,
                child: GestureDetector(
                  onLongPress: () {
                    if (kDebugMode) {
                      log("Open the web page of college");
                    }
                  },
                  onTap: () async {
                    showDetails(
                        "Dr. A.P.J. Abdul Kalam Government College, Silvassa");
                  },
                  // ignore: prefer_const_constructors
                  child: Image.asset(
                    "assets/images/marker_hat_filled.png",
                    fit: BoxFit.cover,
                    semanticLabel:
                        "Dr. A.P.J. Abdul Kalam Government College, Silvassa",
                    height: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height,
      child: getMap(),
    );
  }
}

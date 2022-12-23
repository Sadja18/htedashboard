// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';

import 'package:dashboard/models/local_data.dart';
import 'package:dashboard/widgets/avatar_generator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as ltlng;

// import '../api/read_base_info.dart';
import '../api/fetches.dart';
import '../screens/content/b_course_screen.dart';
import '../screens/content/a_dept_screen.dart';
import '../screens/content/c_student_dropout.dart';
import '../screens/content/d_teaching_staff_screen.dart';
import '../screens/content/e_ntstaff_screen.dart';

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
  // ltlng.LatLngBounds a = ltlng.LatLngBounds();
  ltlng.LatLng vapiBusStop =
      ltlng.LatLng(20.380071292228884, 72.90839236138073);

// points
//1
  ltlng.LatLng govtEngineeringCollegeDaman =
      ltlng.LatLng(20.41337272693001, 72.8612683013883);
//2
  ltlng.LatLng govtPolytechnicDaman =
      ltlng.LatLng(20.41379008533039, 72.86259918650929);

//3
  ltlng.LatLng govtCollegeDaman = ltlng.LatLng(20.423289, 72.849520);

//4
  ltlng.LatLng govtITIDaman =
      ltlng.LatLng(20.413687420039434, 72.87029705281888);

//5
  ltlng.LatLng drBhimraoGovtPolytechnic =
      ltlng.LatLng(20.21585359701345, 73.03804685413407);

//6
  ltlng.LatLng govtITISilvassa =
      ltlng.LatLng(20.27915241635105, 73.00290883651383);

//7
  ltlng.LatLng govtPolytechnicDiu =
      ltlng.LatLng(20.762963392009883, 70.9457635356939);

//8
  ltlng.LatLng abdulKalamGovtCollege =
      ltlng.LatLng(20.288398966788893, 73.01175890524844);

//9
  ltlng.LatLng diuCollegeDiu =
      ltlng.LatLng(20.71542645343596, 70.99317737627099);

//10
  ltlng.LatLng govtITIGhoghlaDiu =
      ltlng.LatLng(20.73856749614502, 71.00429500283235);

// polyplots
//1
  List<ltlng.LatLng> govtEngineeringCollegeDamanPolyplot = [
    ltlng.LatLng(20.414949429347523, 72.8602391157279),
    ltlng.LatLng(20.41289317453841, 72.86067899800543),
    ltlng.LatLng(20.412644310542934, 72.86183234787869),
    ltlng.LatLng(20.413099304007865, 72.86201205588219),
    ltlng.LatLng(20.41348139692861, 72.86125030852403),
    ltlng.LatLng(20.41492429192422, 72.86092576123383),
    ltlng.LatLng(20.41488658578158, 72.86055829859978),
  ];

//2
  List<ltlng.LatLng> govtPolytechnicDamanPolyplot = [
    ltlng.LatLng(20.41392495295493, 72.86237189934553),
    ltlng.LatLng(20.413497186401866, 72.86260596657408),
    ltlng.LatLng(20.41353557575646, 72.86279907203762),
    ltlng.LatLng(20.413974310557645, 72.86267033506192),
  ];

//3
  List<ltlng.LatLng> govtCollegeDamanPolypot = [
    // ltlng.LatLng(20.423547, 72.849099),
    // ltlng.LatLng(20.423403, 72.849111),
    // ltlng.LatLng(20.423412, 72.849237),
    // ltlng.LatLng(20.423505, 72.849232),
    // ltlng.LatLng(20.423512, 72.849339),
    // ltlng.LatLng(20.423638, 72.849330),
    // ltlng.LatLng(20.423635, 72.849231),
    // ltlng.LatLng(20.423532, 72.849241),
    // ltlng.LatLng(20.423529, 72.849208),
    // ltlng.LatLng(20.423559, 72.849197),
    // ltlng.LatLng(20.423559, 72.849197),
    // ltlng.LatLng(20.423487, 72.849387),
    // ltlng.LatLng(20.423502, 72.849505),
    // ltlng.LatLng(20.423594, 72.849485),
    // ltlng.LatLng(20.423584, 72.849366),
  ];

//4
  List<ltlng.LatLng> govtITIDamanPolyplot = [
    ltlng.LatLng(20.41352588781436, 72.87009417075404),
    ltlng.LatLng(20.413593149022073, 72.87039878729846),
    ltlng.LatLng(20.413769522716105, 72.87034775206588),
    ltlng.LatLng(20.41370076689331, 72.87002559216027),
  ];

//5
  List<ltlng.LatLng> drBhimraoAmbedkarGovtPolytechnicPolyplot = [
    ltlng.LatLng(20.215473749762005, 73.03716792453409),
    ltlng.LatLng(20.215160504046658, 73.0384219602604),
    ltlng.LatLng(20.21571080015443, 73.03878734477055),
    ltlng.LatLng(20.215903403332334, 73.03844225939983),
    ltlng.LatLng(20.21621453103917, 73.03731452943015),
  ];

//6
  List<ltlng.LatLng> govtITISilvassaPolyplot = [
    ltlng.LatLng(20.27904437889038, 73.00284760220215),
    ltlng.LatLng(20.279061304144957, 73.00300097347802),
    ltlng.LatLng(20.279162855633626, 73.00297729114867),
    ltlng.LatLng(20.279047552375758, 73.00284309128227),
  ];

//7
  List<ltlng.LatLng> govtPolytechnicDiuPolyplot = [
    ltlng.LatLng(20.719182256583874, 70.93862709035956),
    ltlng.LatLng(20.719153406084832, 70.93873974313789),
    ltlng.LatLng(20.719224905137587, 70.93875985970544),
    ltlng.LatLng(20.719251246885367, 70.93869749834602),
  ];

//8
  List<ltlng.LatLng> abdulKalamGovtCollegePolyplot = [
    ltlng.LatLng(20.288055792075138, 73.01177558594787),
    ltlng.LatLng(20.28804232889887, 73.01197653717612),
    ltlng.LatLng(20.288079726607865, 73.01197972687815),
    ltlng.LatLng(20.288082718424196, 73.0120195981536),
    ltlng.LatLng(20.288163497443307, 73.01203554666378),
    ltlng.LatLng(20.288182944237917, 73.0120817973433),
    ltlng.LatLng(20.288181448330715, 73.01208339219433),
    ltlng.LatLng(20.288214358285575, 73.01212485832079),
    ltlng.LatLng(20.288340014412594, 73.01209455615145),
    ltlng.LatLng(20.28833851850693, 73.01205946942906),
    ltlng.LatLng(20.28842677691704, 73.01204352091888),
    ltlng.LatLng(20.288483621290165, 73.01203554666378),
    ltlng.LatLng(20.288483621290165, 73.01207860764127),
    ltlng.LatLng(20.28859431816746, 73.01208817674737),
    ltlng.LatLng(20.288603293586476, 73.01201481360056),
    ltlng.LatLng(20.28861226900497, 73.01182024177638),
    ltlng.LatLng(20.288616756714028, 73.01173093011937),
    ltlng.LatLng(20.28851054756489, 73.01172295586429),
    ltlng.LatLng(20.28850157214049, 73.01176442199076),
    ltlng.LatLng(20.288369932523057, 73.01173571467243),
    ltlng.LatLng(20.288374420239137, 73.01170062795003),
    ltlng.LatLng(20.2882442764203, 73.01165597212155),
    ltlng.LatLng(20.28822782144692, 73.011697438248),
    ltlng.LatLng(20.28817696060906, 73.01174847348058),
    ltlng.LatLng(20.288105157044846, 73.01173890437447),
    ltlng.LatLng(20.288094685688947, 73.01177239624585),
  ];

//9
  List<ltlng.LatLng> diuCollegeDiuPloyplot = [
    ltlng.LatLng(20.715391024837185, 70.99320369276057),
    ltlng.LatLng(20.715507684066328, 70.9932533136272),
    ltlng.LatLng(20.715522109663677, 70.99321844491011),
    ltlng.LatLng(20.71540294164429, 70.99316614183446),
  ];

//10
  List<ltlng.LatLng> govtITIGhoghlaDiuPolyplot = [
    ltlng.LatLng(20.73854804500116, 71.0042991070836),
    ltlng.LatLng(20.73857751890894, 71.00435342181599),
    ltlng.LatLng(20.738613263853225, 71.00433263469618),
    ltlng.LatLng(20.7385856712654, 71.00427697885928),
  ];

  Widget collegeDetailWidget(String collegeName, data) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          45.0,
        ),
      ),
      padding: const EdgeInsets.all(
        8.0,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          data['HoI'],
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 22,
                          ),
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
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          data['affliatedTo'].toString(),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 22,
                          ),
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
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          data['email'].toString(),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 22,
                          ),
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
                          "Contact: ",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          data['contact'] == false ||
                                  data['contact'] == null
                              ? data['mobile'] == false ||
                                      data['mobile'] == null
                                  ? ""
                                  : data["mobile"].toString()
                              : data["contact"].toString(),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 22,
                          ),
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
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            // show departments in new screen

                            var collegeId = data['collegeId'];
                            Navigator.pushNamed(
                                context, ScreenCollegeDeptInfo.routeName,
                                arguments: {
                                  'collegeId': collegeId,
                                  'collegeName': collegeName,
                                });
                          },
                          child: Text(
                            data['deptsCount'].toString(),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 22,
                            ),
                          ),
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
                          "Number of Courses: ",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            var collegeId = data['collegeId'];

                            Navigator.pushNamed(
                                context, ScreenCollegeCourseInfo.routeName,
                                arguments: {
                                  'collegeId': collegeId,
                                  'collegeName': collegeName,
                                });
                          },
                          child: Text(
                            data['coursesCount'].toString(),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 22,
                            ),
                          ),
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
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            int collegeId = data['collegeId'];
                            Navigator.pushNamed(
                              context,
                              ScreenTeachingStaffInfo.routename,
                              arguments: {
                                'collegeId': collegeId,
                                'collegeName': collegeName,
                              },
                            );
                          },
                          child: Text(
                            data['teachersCount'].toString(),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 22,
                            ),
                          ),
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
                          "Number of Non-Teaching Staff: ",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            int collegeId = data['collegeId'];
                            Navigator.pushNamed(
                              context,
                              ScreenNtStaff.routeName,
                              arguments: {
                                'collegeId': collegeId,
                                'collegeName': collegeName,
                              },
                            );
                          },
                          child: Text(
                            data['staffsCount'].toString(),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 22,
                            ),
                          ),
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
                          "Number of Students: ",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            int collegeId = data['collegeId'];

                            if (kDebugMode) {
                              log("information clicked");
                              log("College ID $collegeId");
                              log("College Name, $collegeName");
                            }

                            Navigator.pushNamed(
                              context,
                              ScreenStudentDropoutInfo.routeName,
                              arguments: {
                                'collegeId': collegeId,
                                'collegeName': collegeName,
                              },
                            );
                          },
                          child: Text(
                            data['studentsCount'].toString(),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget titleWidget(String profilePic, String collegeName,
      String? district, String? cluster, String? city) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.40,
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: BoxDecoration(
        color: Colors.blue.shade600,
      ),
      alignment: Alignment.center,
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: const {
          0: FractionColumnWidth(0.25),
          1: FractionColumnWidth(0.75),
        },
        children: [
          TableRow(
            children: [
              TableCell(
                child: AvatarBuilder(profilePic: profilePic),
              ),
              TableCell(
                child: Center(
                  child: Text(
                    "$collegeName\n$city, $cluster, $district",
                    softWrap: true,
                    maxLines: 4,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> showDetails(String collegeName) async {
    var data = await fetchSingleCollegeInfo(collegeName);

    if (data != null) {
      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) {
            return AlertDialog(
              titlePadding: const EdgeInsets.all(0),
              title: titleWidget(
                data['profilePic'],
                collegeName,
                data['district'],
                data['cluster'],
                data['city'],
              ),
              content: Container(
                width: MediaQuery.of(context).size.width * 0.40,
                height: MediaQuery.of(context).size.height * 0.45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    45.0,
                  ),
                ),
                alignment: Alignment.center,
                child: collegeDetailWidget(collegeName, data),
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
    } else {
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
                child:
                    Text("No detailed information found on $collegeName"),
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
  }

  FlutterMap getMap() {
    return FlutterMap(
      options: MapOptions(
        minZoom: 2,
        maxZoom: 38,
        zoom: 9.2,
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
            //1
            Polygon(
              borderStrokeWidth: 3.5,
              isFilled: true,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.black,
              ),
              points: govtEngineeringCollegeDamanPolyplot,
              // color: Colors.redAccent,
              borderColor: Colors.blue,
              label: "Government Engineering College, Daman",
            ),
            //2
            Polygon(
              borderStrokeWidth: 3.5,
              isFilled: true,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.black,
              ),
              points: govtPolytechnicDamanPolyplot,
              color: Colors.redAccent,
              borderColor: Colors.blue,
              label: "Government Polytechnic College, Daman",
            ),
            //3
            Polygon(
              borderStrokeWidth: 3.5,
              isFilled: true,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.black,
              ),
              label: "Government College, Daman",
              points: govtCollegeDamanPolypot,
            ),
            //4
            Polygon(
              borderStrokeWidth: 3.5,
              isFilled: true,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.black,
              ),
              label: "Government Industrial Training Institute, Daman",
              points: govtITIDamanPolyplot,
            ),
            //5
            Polygon(
              borderStrokeWidth: 3.5,
              isFilled: true,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.black,
              ),
              label: "Dr Bhimrao Ambedkar Government Poytechnic, Silvassa",
              points: drBhimraoAmbedkarGovtPolytechnicPolyplot,
            ),
            //6
            Polygon(
              borderStrokeWidth: 3.5,
              isFilled: true,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.black,
              ),
              label: "Government Industrial Training Institute, Silvassa",
              points: govtITISilvassaPolyplot,
            ),
            //7
            Polygon(
              borderStrokeWidth: 3.5,
              isFilled: true,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.black,
              ),
              label: "Government Polytechnic, Diu",
              points: govtPolytechnicDiuPolyplot,
            ),
            //8
            Polygon(
              borderStrokeWidth: 3.5,
              isFilled: true,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.black,
              ),
              label: "Dr. A.P.J. Abdul Kalam Government College, Silvassa",
              points: abdulKalamGovtCollegePolyplot,
            ),
            //9
            Polygon(
              borderStrokeWidth: 3.5,
              isFilled: true,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.black,
              ),
              label: "Diu College, Diu",
              points: diuCollegeDiuPloyplot,
            ),
            //10
            Polygon(
              borderStrokeWidth: 3.5,
              isFilled: true,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.black,
              ),
              label:
                  "Government Industrial Training Institute, Ghoghla-Diu",
              points: govtITIGhoghlaDiuPolyplot,
            ),
          ],
        ),
        MarkerLayerOptions(
          markers: [
            //1
            Marker(
              point: govtEngineeringCollegeDaman,
              builder: (ctx) => Container(
                alignment: Alignment.center,
                child: Tooltip(
                  message: "Government Engineering College, Daman",
                  padding: const EdgeInsets.all(30),
                  margin:
                      const EdgeInsets.only(top: 30, left: 30, right: 30),
                  decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(22)),
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                  child: InkWell(
                    onTap: () {
                      showDetails("Government Engineering College Daman");
                    },
                    child: Image.asset(
                      "assets/images/marker_hat_filled.png",
                      fit: BoxFit.cover,
                      semanticLabel:
                          "Government Engineering College Daman",
                      height: 30,
                    ),
                  ),
                ),
              ),
            ),
            //2
            Marker(
              point: govtPolytechnicDaman,
              builder: (ctx) => Container(
                alignment: Alignment.center,
                child: Tooltip(
                  message: "Government Polytechnic, Daman",
                  padding: const EdgeInsets.all(30),
                  margin:
                      const EdgeInsets.only(top: 30, left: 30, right: 30),
                  decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(22)),
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                  child: InkWell(
                    onLongPress: () {
                      if (kDebugMode) {
                        log("Open the web page of college");
                      }
                    },
                    onTap: () {
                      showDetails("Government Polytechnic Daman");
                    },
                    // ignore: prefer_const_constructors
                    child: Image.asset(
                      "assets/images/marker_hat_filled.png",
                      fit: BoxFit.cover,
                      semanticLabel: "Government Polytechnic Daman",
                      height: 30,
                    ),
                  ),
                ),
              ),
            ),
            //3
            Marker(
              point: govtCollegeDaman,
              builder: (ctx) => Container(
                alignment: Alignment.center,
                child: Tooltip(
                  message: "Government College, Daman",
                  padding: const EdgeInsets.all(30),
                  margin:
                      const EdgeInsets.only(top: 30, left: 30, right: 30),
                  decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(22)),
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                  child: InkWell(
                    onLongPress: () {
                      if (kDebugMode) {
                        log("Open the web page of college");
                      }
                    },
                    onTap: () {
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
            ),
            //4
            Marker(
              point: govtITIDaman,
              builder: (ctx) => Container(
                alignment: Alignment.center,
                child: Tooltip(
                  message:
                      "Government Industrial Training Institute (ITI), Daman",
                  padding: const EdgeInsets.all(30),
                  margin:
                      const EdgeInsets.only(top: 30, left: 30, right: 30),
                  decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(22)),
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                  child: InkWell(
                    onLongPress: () {
                      if (kDebugMode) {
                        log("Open the web page of college");
                      }
                    },
                    onTap: () {
                      showDetails(
                          "Government Industrial Training Institute (ITI), Daman");
                    },
                    // ignore: prefer_const_constructors
                    child: Image.asset(
                      "assets/images/marker_hat_filled.png",
                      fit: BoxFit.cover,
                      semanticLabel:
                          "Government Industrial Training Institute (ITI), Daman",
                      height: 30,
                    ),
                  ),
                ),
              ),
            ),
            //5
            Marker(
              point: drBhimraoGovtPolytechnic,
              builder: (ctx) => Container(
                alignment: Alignment.center,
                child: Tooltip(
                  message:
                      "DR BABASAHEB BHIMRAO AMBEDKAR GOVERNMENT POLYTECHNIC",
                  padding: const EdgeInsets.all(30),
                  margin:
                      const EdgeInsets.only(top: 30, left: 30, right: 30),
                  decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(22)),
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                  child: InkWell(
                    onLongPress: () {
                      if (kDebugMode) {
                        log("Open the web page of college");
                      }
                    },
                    onTap: () {
                      showDetails(
                          "DR BABASAHEB BHIMRAO AMBEDKAR GOVERNMENT POLYTECHNIC");
                    },
                    // ignore: prefer_const_constructors
                    child: Image.asset(
                      "assets/images/marker_hat_filled.png",
                      fit: BoxFit.cover,
                      semanticLabel:
                          "DR BABASAHEB BHIMRAO AMBEDKAR GOVERNMENT POLYTECHNIC",
                      height: 30,
                    ),
                  ),
                ),
              ),
            ),
            //6
            Marker(
              point: govtITISilvassa,
              builder: (ctx) => Container(
                alignment: Alignment.center,
                child: Tooltip(
                  message:
                      "Government Industrial Training Institute (ITI), Silvassa, DNH",
                  padding: const EdgeInsets.all(30),
                  margin:
                      const EdgeInsets.only(top: 30, left: 30, right: 30),
                  decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(22)),
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                  child: InkWell(
                    onLongPress: () {
                      if (kDebugMode) {
                        log("Open the web page of college");
                      }
                    },
                    onTap: () {
                      showDetails(
                          "GOVERNMENT INDUSTRIAL TRAINING INSTITUTE (ITI) SILVASSA, DNH");
                    },
                    // ignore: prefer_const_constructors
                    child: Image.asset(
                      "assets/images/marker_hat_filled.png",
                      fit: BoxFit.cover,
                      semanticLabel: "Government Polytechnic Diu",
                      height: 30,
                    ),
                  ),
                ),
              ),
            ),
            //7
            Marker(
              point: govtPolytechnicDiu,
              builder: (ctx) => Container(
                alignment: Alignment.center,
                child: Tooltip(
                  message: "Goverment Polytechnic, Diu",
                  padding: const EdgeInsets.all(30),
                  margin:
                      const EdgeInsets.only(top: 30, left: 30, right: 30),
                  decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(22)),
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                  child: InkWell(
                    onLongPress: () {
                      if (kDebugMode) {
                        log("Open the web page of college");
                      }
                    },
                    onTap: () {
                      showDetails("Government Polytechnic Diu");
                    },
                    // ignore: prefer_const_constructors
                    child: Image.asset(
                      "assets/images/marker_hat_filled.png",
                      fit: BoxFit.cover,
                      semanticLabel: "Government Polytechnic Diu",
                      height: 30,
                    ),
                  ),
                ),
              ),
            ),
            //8
            Marker(
              point: abdulKalamGovtCollege,
              builder: (ctx) => Container(
                alignment: Alignment.center,
                child: Tooltip(
                  message:
                      "Dr. A.P.J. Abdul Kalam Goverment College, Silvassa",
                  padding: const EdgeInsets.all(30),
                  margin:
                      const EdgeInsets.only(top: 30, left: 30, right: 30),
                  decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(22)),
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                  child: InkWell(
                    onLongPress: () {
                      if (kDebugMode) {
                        log("Open the web page of college");
                      }
                    },
                    onTap: () {
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
            ),
            //9
            Marker(
              point: diuCollegeDiu,
              builder: (ctx) => Container(
                alignment: Alignment.center,
                child: Tooltip(
                  message: "Diu College, Diu",
                  padding: const EdgeInsets.all(30),
                  margin:
                      const EdgeInsets.only(top: 30, left: 30, right: 30),
                  decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(22)),
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                  child: InkWell(
                    onLongPress: () {
                      if (kDebugMode) {
                        log("Open the web page of college");
                      }
                    },
                    onTap: () {
                      showDetails("Diu College, Diu");
                    },
                    // ignore: prefer_const_constructors
                    child: Image.asset(
                      "assets/images/marker_hat_filled.png",
                      fit: BoxFit.cover,
                      semanticLabel: "Diu College, Diu",
                      height: 30,
                    ),
                  ),
                ),
              ),
            ),
            //10
            Marker(
              point: govtITIGhoghlaDiu,
              builder: (ctx) => Container(
                alignment: Alignment.center,
                child: Tooltip(
                  message:
                      "Government Industrial Training Institute, Ghoghla-Diu",
                  padding: const EdgeInsets.all(30),
                  margin:
                      const EdgeInsets.only(top: 30, left: 30, right: 30),
                  decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(22)),
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                  child: InkWell(
                    onLongPress: () {
                      if (kDebugMode) {
                        log("Open the web page of college");
                      }
                    },
                    onTap: () {
                      showDetails(
                          "Government Industrial Training Institute, Ghoghla-Diu");
                    },
                    // ignore: prefer_const_constructors
                    child: Image.asset(
                      "assets/images/marker_hat_filled.png",
                      fit: BoxFit.cover,
                      semanticLabel: "Government ITI, Ghoghla-Diu",
                      height: 30,
                    ),
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
  void initState() {
    // dataLoader();
    super.initState();
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

class AvatarBuilder extends StatelessWidget {
  final String profilePic;
  const AvatarBuilder({
    Key? key,
    required this.profilePic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      height: MediaQuery.of(context).size.height * 0.15,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: ClipOval(
        child: Image(
          image: Image.memory(
                  const Base64Decoder().convert(profilePic.toString()))
              .image,
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
      ),
    );
  }
}

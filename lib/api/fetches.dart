import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<dynamic> fetchSelectorBaseRecords() async {
  if (kDebugMode) {
    log('seletiob ');
  }
  try {
    if (kDebugMode) {
      log('sending');
    }
    Map<String, String> queryParams = {"permit": "sadjaBase"};
    var response = await http.get(
      Uri(
          scheme: 'http',
          host: "localhost",
          path: "/hteapi/fetchdcvc.php",
          queryParameters: queryParams),
      headers: {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*"
      },
    );

    if (kDebugMode) {
      log('receiving');
      log(response.statusCode.toString());
      log(response.body);
    }
    if (response.statusCode == 200) {
      if (kDebugMode) {
        log('here 2');
      }
      var body = jsonDecode(response.body);
      if (kDebugMode) {
        log('here3');
      }
      if (body['message'] != null &&
          body['message'].toString().toLowerCase() == 'success') {
        var data = body['data'];
        if (kDebugMode) {
          log("message");
          log(data.toString());
        }

        Map<String, List<Map<int, String>>> records = {
          "colleges": [],
          "blocks": [],
          "clusters": [],
          "cities": [],
        };
        for (var entry in data) {
          Map<int, String> collegeTmp = {};
          Map<int, String> blockTmp = {};
          Map<int, String> clusterTmp = {};
          Map<int, String> cityTmp = {};

          collegeTmp[entry['id']] = entry['name'];

          records['colleges']?.add(collegeTmp);

          if (entry['block'] != false && entry['block'].isNotEmpty) {
            blockTmp[entry['block'][0]] = entry['block'][1];

            records['blocks']?.add(blockTmp);
          }
          if (entry['cluster'] != false && entry['cluster'].isNotEmpty) {
            clusterTmp[entry['cluster'][0]] = entry['cluster'][1];
            records['clusters']?.add(clusterTmp);
          }
          if (entry['city'] != false && entry['city'].isNotEmpty) {
            cityTmp[entry['city'][0]] = entry['city'][1];
            records['cities']?.add(cityTmp);
          }
        }

        if (kDebugMode) {
          print(records['cities']?[0].values.toString());
        }

        return records;
      } else {
        return null;
      }
    } else {
      return null;
    }
  } catch (e) {
    if (kDebugMode) {
      log(e.toString());
      log("${e is SocketException}");
      log("message");
    }
    return null;
  }
}

Future<dynamic> fetchSingleCollegeInfo(String collegeName) async {
  try {
    if (kDebugMode) {
      log('sending');
    }
    Map<String, String> queryParams = {
      "permit": "staffCount",
      "college": collegeName
    };
    var response = await http.get(
      Uri(
          scheme: 'http',
          host: "localhost",
          path: "/hteapi/fetchcollegeinfo.php",
          queryParameters: queryParams),
      headers: {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*"
      },
    );

    if (kDebugMode) {
      log('receiving');
      log(response.statusCode.toString());
      log(response.body);
    }

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json['message'].toString().toLowerCase() == 'success') {
        if (json['data'] != null && json['data'].isNotEmpty) {
          var data = json['data'][0];
          var collegeId = data['id'];

          var headName = data['head_name'] == false ? "" : data['head_name'];

          var affliatedTo = data['univ_id'] == false ? "" : data['univ_id'][1];

          var email = data['email'] == false || data['email'] == ""
              ? ""
              : data['email'];

          var deptsCount =
              data['dept_ids'] == false ? 0 : data['dept_ids'].length;

          var deptIds = data['dept_ids'] == false ? [] : data['dept_ids'];

          var coursesCount =
              data['course_ids'] == false ? 0 : data['course_ids'].length;

          var courseIds = data['course_ids'] == false ? [] : data['course_ids'];

          var studentsCount =
              data['student_ids'] == false ? 0 : data['student_ids'].length;

          var studentIds =
              data['student_ids'] == false ? [] : data['student_ids'];

          var teachersCount =
              data['teacher_ids'] == false ? 0 : data['teacher_ids'].length;

          var teacherIds =
              data['teacher_ids'] == false ? [] : data['teacher_ids'];

          var staffsCount =
              data['staff_ids'] == false ? 0 : data['staff_ids'].length;

          var staffIds = data['staff_ids'] == false ? [] : data['staff_ids'];

          return {
            "collegeId": collegeId,
            "HoI": headName,
            "affliatedTo": affliatedTo,
            'email': email,
            "deptsCount": deptsCount,
            "depts": deptIds,
            "coursesCount": coursesCount,
            "courses": courseIds,
            "studentsCount": studentsCount,
            "studentIds": studentIds,
            "teachersCount": teachersCount,
            "teachers": teacherIds,
            "staffsCount": staffsCount,
            "staffs": staffIds
          };
        } else {
          return null;
        }
      } else {
        return null;
      }
    } else {
      return null;
    }
  } catch (e) {
    if (kDebugMode) {
      log(e.toString());
    }
    return null;
  }
}

Future<dynamic> fetchDeptInfoForCollege(int collegeId) async {
  try {
    Map<String, dynamic> body = {
      "college": collegeId,
      "permit": "deptinfo",
    };
    var requestBody = jsonEncode(body);

    if (kDebugMode) {
      log("college dept requyest sending");
    }
    var response = await http.post(
      Uri.parse("http://localhost/hteapi/fetchdeptcollege.php"),
      headers: {'Content-Type': 'application/json'},
      body: requestBody,
    );
    if (kDebugMode) {
      log("college dept requyest receiving");
    }

    if (response.statusCode == 200) {
      if (kDebugMode) {
        log('colelge dept');
        log(response.body);
      }

      var json = jsonDecode(response.body);

      if (json['message'].toString().toLowerCase() == 'success') {
        var data = json['data'];
        var collegeDP = json['dp'];

        if (data != null && data.isNotEmpty) {
          var record = [];

          data.forEach((element) {
            record.add(element[0]);
          });
          return {
            'dp': collegeDP,
            'data': record,
          };
        } else {
          return null;
        }
      }
    } else {
      return null;
    }
  } catch (e) {
    if (kDebugMode) {
      log(e.toString());
    }
    return null;
  }
}

Future<dynamic> fetchCourseInfoForCollege(int collegeId) async {
  try {
    Map<String, dynamic> body = {
      "college": collegeId,
      "permit": "courseInfo",
    };
    var requestBody = jsonEncode(body);

    if (kDebugMode) {
      log("college course requyest sending");
    }
    var response = await http.post(
      Uri.parse("http://localhost/hteapi/fetchcoursecollege.php"),
      headers: {'Content-Type': 'application/json'},
      body: requestBody,
    );
    if (kDebugMode) {
      log("college course request receiving");
    }

    if (response.statusCode == 200) {
      if (kDebugMode) {
        log('colelge dept');
        log(response.body);
      }

      var json = jsonDecode(response.body);

      if (json['message'].toString().toLowerCase() == 'success') {
        var data = json['data'];
        var collegeDP = json['dp'];
        var record = [];

        if (data != null && data.isNotEmpty) {
          data.forEach((element) {
            record.add(element[0]);
          });
          return {
            'dp': collegeDP,
            'data': record,
          };
        } else {
          return null;
        }
      }
    } else {
      return null;
    }
  } catch (e) {
    if (kDebugMode) {
      log(e.toString());
    }
    return null;
  }
}

Future<dynamic> fetchTeachingStaffSelectors(int collegeId) async {
  try {
    Map<String, dynamic> body = {
      "college": collegeId,
      "permit": "courseInfo",
    };
    var requestBody = jsonEncode(body);

    if (kDebugMode) {
      log("college selectors request sending");
    }
    var response = await http.post(
      Uri.parse("http://localhost/hteapi/fetchteachingstaffseletors.php"),
      headers: {'Content-Type': 'application/json'},
      body: requestBody,
    );
    if (kDebugMode) {
      log("college selectors request receiving");
    }

    if (response.statusCode == 200) {
      if (kDebugMode) {
        log('college selectors');
        log(response.body);
      }

      var json = jsonDecode(response.body);

      if (json['message'].toString().toLowerCase() == 'success') {
        var data = json['data'];

        if (data != null && data.isNotEmpty) {
          return data;
        } else {
          return null;
        }
      }
    } else {
      return null;
    }
  } catch (e) {
    if (kDebugMode) {
      log(e.toString());
    }
    return null;
  }
}

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ListInstitutes extends StatefulWidget {
  const ListInstitutes({Key? key}) : super(key: key);

  @override
  State<ListInstitutes> createState() => _ListInstitutesState();
}

class _ListInstitutesState extends State<ListInstitutes> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Color.fromARGB(255, 220, 215, 215),
        borderRadius: BorderRadius.circular(
          18.0,
        ),
      ),
      width: MediaQuery.of(context).size.width * 0.80,
      margin: const EdgeInsets.symmetric(
        vertical: 15.0,
      ),
      alignment: Alignment.center,
      child: Card(
        color: Color.fromARGB(255, 220, 215, 215),
        elevation: 14.0,
        child: ExpandablePanel(
          header: Center(child: Text("List of Institutes")),
          collapsed: Center(child: Text("Number of Institutes: 13")),
          expanded: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.70,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      15.0,
                    ),
                    color: Color.fromARGB(255, 234, 68, 59),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 10.0,
                  ),
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: Center(
                              child: const Text(
                                "Institute Name",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Center(
                              child: const Text(
                                "Institute Type",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Center(
                              child: const Text(
                                "No of Courses",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Center(
                              child: const Text(
                                "No of Staff",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Center(
                              child: const Text(
                                "No of Students",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.70,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      15.0,
                    ),
                    color: Color.fromARGB(255, 52, 110, 235),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 10.0,
                  ),
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: Center(
                              child: const Text(
                                "Government College Daman",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          TableCell(
                            child: Center(
                              child: const Text(
                                "Engineering",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Center(
                              child: const Text(
                                "10",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Center(
                              child: const Text(
                                "40",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Center(
                              child: const Text(
                                "300",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

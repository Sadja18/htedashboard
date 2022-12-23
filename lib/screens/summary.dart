import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
import '../views/summary_tracker.dart';
import '../views/summary_others_tracker.dart';

class SummaryScreen extends StatefulWidget {
  static const routeName = "/summary-screen";
  const SummaryScreen({Key? key}) : super(key: key);
  // static const routeName = "/summary-screen;"

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
  // static const routeName = "/summary-screen;"
}

class _SummaryScreenState extends State<SummaryScreen> {
  // static const routeName = "/summary-screen;"
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text("Summary"),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Center(
                  child: Text(""),
                ),
              ),
              // Tab(
              //   child: Center(
              //     child: Text("Medical"),
              //   ),
              // ),
              // Tab(
              //   child: Center(
              //     child: Text("Tourism"),
              //   ),
              // ),
              // Tab(
              //   child: Center(
              //     child: Text("Private"),
              //   ),
              // )
            ],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            SizedBox(
              child: SummaryTracker(),
            ),
            // SizedBox(
            //   child: SummaryOthersTracker(
            //     type: "Medical",
            //   ),
            // ),
            // SizedBox(
            //   child: SummaryOthersTracker(
            //     type: "Tourism",
            //   ),
            // ),
            // SizedBox(
            //   child: SummaryOthersTracker(
            //     type: "Private",
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

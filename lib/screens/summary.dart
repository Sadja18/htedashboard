import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
import '../views/summary_tracker.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Intakes")),
      ),
      body: const SizedBox(
        child: SummaryTracker(),
      ),
    );
  }
}

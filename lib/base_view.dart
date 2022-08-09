import 'package:flutter/material.dart';

import './views/map_view.dart';
import './screens/details.dart';
import './screens/summary.dart';
import './screens/gender_parity_index_screen.dart';

class BaseView extends StatefulWidget {
  const BaseView({Key? key}) : super(key: key);

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Home",
          ),
        ),
      ),
      drawer: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.30,
        margin: const EdgeInsets.only(
          top: kToolbarHeight,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // InkWell(
            //   onTap: () {
            //     Navigator.of(context).pushNamed(ScreenDetailTables.routeName);
            //   },
            //   child: Container(
            //     width: MediaQuery.of(context).size.width * 0.30 * 0.50,
            //     alignment: Alignment.center,
            //     margin: const EdgeInsets.symmetric(
            //       vertical: 8.0,
            //     ),
            //     padding: const EdgeInsets.symmetric(
            //       vertical: 8.0,
            //       horizontal: 3.0,
            //     ),
            //     decoration: BoxDecoration(
            //       color: const Color.fromARGB(255, 134, 11, 178),
            //       borderRadius: BorderRadius.circular(14.0),
            //     ),
            //     child: const Text(
            //       "Info",
            //       style: TextStyle(
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(GPIScreen.routeName);
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.30 * 0.50,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 3.0,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 134, 11, 178),
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: const Text(
                  "Gender Parity Index",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(SummaryScreen.routeName);
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.30 * 0.50,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 3.0,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 134, 11, 178),
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: const Text(
                  "Summary",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                width: MediaQuery.of(context).size.width * 0.30 * 0.50,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 3.0,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 134, 11, 178),
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: const Text(
                  "Attendance",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                width: MediaQuery.of(context).size.width * 0.30 * 0.50,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 3.0,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 134, 11, 178),
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: const Text(
                  "Performance",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 5.0,
          vertical: 2.0,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        child: MapViewInstitute(),
      ),
    );
  }
}

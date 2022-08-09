// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import './base_view.dart';
import './screens/details.dart';
import './screens/summary.dart';
import './screens/gender_parity_index_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HTE',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
              fontSizeFactor: 1.50,
              fontSizeDelta: 0.5,
              // fontFamily: 'Poppins',
            ),
        primarySwatch: Colors.blue,
      ),

      // home: BaseView(),
      routes: {
        "/": (ctx) => BaseView(),
        ScreenDetailTables.routeName: (ctx) => ScreenDetailTables(),
        SummaryScreen.routeName: (ctx) => SummaryScreen(),
        GPIScreen.routeName: (ctx) => GPIScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:dashboard/models/urls.dart';
import 'package:flutter/material.dart';

import '../views/gender_parity_index.dart';
import '../api/fetches.dart';

class GPIScreen extends StatelessWidget {
  static const routeName = "/gender-parity-index-screen";
  const GPIScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Center(
          child: Text("Gender Parity"),
        ),
      ),
      body: FutureBuilder(
          future: fetchGenderParityFromServer(),
          builder: (BuildContext ctx, AsyncSnapshot snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.10,
                  height: MediaQuery.of(context).size.height * 0.10,
                  child: const CircularProgressIndicator.adaptive(),
                ),
              );
            } else if (snap.hasData &&
                snap.data != null &&
                snap.data.isNotEmpty &&
                snap.data is List) {
              // var htestString = "${snap.data is List}";
              return GenderParityIndex(genderParityInfo: snap.data);
            } else {
              return const SizedBox(
                height: 0,
                width: 0,
              );
            }
          }),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/src/foundation/key.dart';

import '../views/gender_parity_index.dart';

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
      body: const GenderParityIndex(),
    );
  }
}

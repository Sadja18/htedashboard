import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Selector extends StatefulWidget {
  final List<String> optionNames;
  final Function(String) selectorCallback;
  const Selector({
    Key? key,
    required this.optionNames,
    required this.selectorCallback,
  }) : super(key: key);

  @override
  State<Selector> createState() => _SelectorState();
}

class _SelectorState extends State<Selector> {
  late List<String> optionNames = [];
  late String selectedDistrictName;

  @override
  void initState() {
    if (widget.optionNames.isNotEmpty) {
      for (var element in widget.optionNames) {
        optionNames.add(element);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        backgroundBlendMode: BlendMode.hue,
        color: Color.fromARGB(255, 0, 123, 160),
      ),
      child: SingleChildScrollView(
        child: Row(
          children: [
            Text(
              optionNames.toString(),
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            Text(
              "${MediaQuery.of(context).size.width}",
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            Text(
              "${MediaQuery.of(context).size.height}",
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

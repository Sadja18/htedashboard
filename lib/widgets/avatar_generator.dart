import 'package:flutter/material.dart';
import 'dart:convert';

class AvatarGeneratorNewTwo extends StatefulWidget {
  final String base64Code;
  const AvatarGeneratorNewTwo({Key? key, required this.base64Code})
      : super(key: key);

  @override
  State<AvatarGeneratorNewTwo> createState() => _AvatarGeneratorNewStateTwo();
}

class _AvatarGeneratorNewStateTwo extends State<AvatarGeneratorNewTwo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          // shape: BoxShape.circle,
          // border: Border.all()
          // color: Colors.blue,
          ),
      alignment: Alignment.topCenter,
      width: MediaQuery.of(context).size.width * 0.20,
      height: MediaQuery.of(context).size.height * 0.20,
      child: ClipOval(
        child: Image(
          image: Image.memory(const Base64Decoder().convert(widget.base64Code))
              .image,
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
      ),
    );
  }
}

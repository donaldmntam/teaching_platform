import 'package:flutter/material.dart';

class LineShadow extends StatelessWidget {
  final Alignment begin;
  final Alignment end;

  const LineShadow({
    super.key,
    this.begin = Alignment.topCenter,
    this.end = Alignment.bottomCenter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: const [
            Color(0x10000000),
            Color(0x00000000),
          ]
        )
      ),
    );
  }
}
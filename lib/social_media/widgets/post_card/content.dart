import 'package:flutter/material.dart';

class Content extends StatelessWidget {
  final double width;
  final double height;
  const Content({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey,
    );
  }
}
import 'package:flutter/material.dart';
import 'package:teaching_platform/common/widgets/button/selectable_text_button.dart';

class Selector extends StatelessWidget {
  const Selector({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("I'm a"),
        SelectableTextButton(
          "Student",
          selected: true,
          onPressed: () {}
        ),
        SelectableTextButton(
          "Student",
          selected: false,
          onPressed: () {}
        ),
      ]
    );
  }
}
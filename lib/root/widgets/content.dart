import 'package:flutter/material.dart';
import 'package:teaching_platform/root/widgets/selector.dart';

class Content extends StatelessWidget {
  const Content();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: _columnWidth(constraints),
          child: Column(
            children: [
              // TODO: image
              Container(
                color: Colors.red,
                height: 200,
              ),
              Selector()
            ]
          ),
        );
      }
    );
  }
}

double _columnWidth(BoxConstraints constraints) =>
  constraints.maxWidth * 0.5;
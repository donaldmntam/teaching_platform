import 'package:flutter/cupertino.dart';
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';

import 'values.dart';

class CourseText extends StatelessWidget {
  final String text;

  const CourseText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      width: double.infinity,
      height: height,
      alignment: Alignment.center,
      child: Text(
        text,
        style: theme.textStyle(
          size: 18,
          weight: FontWeight.bold,
          color: theme.colors.primary,
        ),
        overflow: TextOverflow.ellipsis,
        
      )
    );
  }
}

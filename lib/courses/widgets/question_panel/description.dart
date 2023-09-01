import 'package:flutter/material.dart';
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';
import 'package:teaching_platform/courses/values.dart';

class Description extends StatelessWidget {
  final String title;

  const Description(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    
    return Text(
      title,
      style: panelTextStyle(theme),
    );
  }
}

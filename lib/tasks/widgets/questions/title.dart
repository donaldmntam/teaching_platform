import 'package:flutter/material.dart';
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';

class Title extends StatelessWidget {
  final String title;

  const Title(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    
    return Text(
      title,
      style: theme.textStyle(
        size: 20,
        weight: FontWeight.bold,
        color: theme.colors.onSurface,
      ),
    );
  }
}
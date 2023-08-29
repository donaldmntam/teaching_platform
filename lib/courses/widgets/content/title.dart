import 'package:flutter/widgets.dart';
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';

class Title extends StatelessWidget {
  final String text;

  const Title(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    return Text(
      text,
      style: theme.textStyle(
        color: theme.colors.primary,
        size: 24,
        weight: FontWeight.bold,
      )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:teaching_platform/common/widgets/services.dart/services.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    return CircularProgressIndicator(
      color: theme.colors.primary,
    );
  }
}
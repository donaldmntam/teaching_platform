import 'package:flutter/material.dart';
import 'package:teaching_platform/common/functions/duration_functions.dart';
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';

class Timer extends StatelessWidget {
  final Duration timeRemaining;

  const Timer(this.timeRemaining, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Time Remaining: ",
            style: theme.textStyle(
              size: 14,
              color: theme.colors.primary,
              weight: FontWeight.normal,
            )
          ),
          Container(
            height: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            decoration: ShapeDecoration(
              color: theme.colors.primary.withAlpha(80),
              shape: const StadiumBorder(),
            ),
            child: AspectRatio(
              aspectRatio: 2,
              child: FittedBox(
                alignment: Alignment.center,
                child: Text(
                  timeRemaining.toTimeString(),
                  style: theme.textStyle(
                    size: 14,
                    color: theme.colors.primary,
                    weight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
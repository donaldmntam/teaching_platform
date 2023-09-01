import 'package:flutter/material.dart' hide TextButton;
import 'package:teaching_platform/courses/widgets/content/state.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';
import 'package:teaching_platform/courses/values.dart';
import 'package:teaching_platform/common/widgets/button/text_button.dart';

class ResultPanel extends StatelessWidget {
  final ShowingResult state;
  final void Function() onContinue;

  const ResultPanel({
    super.key,
    required this.state,
    required this.onContinue,
  });
  
  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(panelSpacing),
      decoration: panelDecoration(theme),
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              descriptionText(state),
              style: panelTextStyle(theme).copyWith(
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(height: panelSpacing),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              buttonText(state),
              onPressed: onContinue,
            ),
          ),
        ],
      ),
    );
  }
}

String descriptionText(ShowingResult state) {
  if (state.passed) return "Correct!";
  if (state.maxRetryCountReached) return "Incorrect!";
  return "Incorrect. Please try again!";
}

String buttonText(ShowingResult state) {
  if (state.passed) return "Continue";
  if (state.maxRetryCountReached) return "Continue";
  return "Retry";
}


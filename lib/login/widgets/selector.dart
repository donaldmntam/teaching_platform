import 'package:flutter/material.dart';
import 'package:teaching_platform/common/models/account/type.dart';
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/widgets/button/selectable_text_button.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';

class Selector extends StatelessWidget {
  final AccountType selectedType;
  final void Function(AccountType type) onTypeChanged;

  const Selector({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "I'm a",
          style: theme.textStyle(
            size: 24,
            weight: FontWeight.bold,
            color: theme.colors.primary,
          )
        ),
        const SizedBox(width: 24),
        SelectableTextButton(
          AccountType.teacher.string(),
          selected: selectedType == AccountType.teacher,
          onPressed: () {
            if (selectedType == AccountType.teacher) return;
            onTypeChanged(AccountType.teacher);
          }
        ),
        const SizedBox(width: 24),
        SelectableTextButton(
          AccountType.student.string(),
          selected: selectedType == AccountType.student,
          onPressed: () {
            if (selectedType == AccountType.student) return;
            onTypeChanged(AccountType.student);
          }
        ),
      ]
    );
  }
}

extension ExtendedAccountType on AccountType {
  String string() => switch (this) {
    AccountType.teacher => "Teacher",
    AccountType.student => "Student",
  };
}
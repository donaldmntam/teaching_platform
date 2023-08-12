import 'package:flutter/material.dart' hide TextField, TextButton;
import 'package:teaching_platform/common/models/account/type.dart';
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/widgets/button/text_button.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';
import 'package:teaching_platform/common/widgets/text_field/text_field.dart';
import 'package:teaching_platform/login/widgets/selector.dart';

class Page extends StatefulWidget {
  const Page({super.key});

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  AccountType selectedType = AccountType.teacher;

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            width: _columnWidth(constraints),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // TODO: image
                Container(
                  color: Colors.red,
                  height: 300,
                ),
                const SizedBox(height: _spacing),
                Selector(
                  selectedType: selectedType,
                  onTypeChanged: (type) => setState(() =>
                    selectedType = type
                  )
                ),
                const SizedBox(height: _spacing),
                Row(
                  children: [
                    Text(
                      "User name/Gmail: ",
                      style: theme.textStyle(
                        size: 24,
                        weight: FontWeight.normal,
                        color: theme.colors.primary,
                      )
                    ),
                    const Flexible(flex: 1, child: TextField()),
                  ],
                ),
                const SizedBox(height: _spacing),
                Row(
                  children: [
                    Text(
                      "Password: ",
                      style: theme.textStyle(
                        size: 24,
                        weight: FontWeight.normal,
                        color: theme.colors.primary,
                      )
                    ),
                    const Flexible(flex: 1, child: TextField()),
                  ],
                ),
                const SizedBox(height: _spacing),
                TextButton(
                  "Login",
                  onPressed: () {},
                )
              ]
            ),
          );
        }
      ),
    );
  }
}

double _columnWidth(BoxConstraints constraints) =>
  constraints.maxWidth * 0.5;

const _spacing = 32.0;
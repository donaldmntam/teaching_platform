import 'package:flutter/material.dart' hide TextField, TextButton;
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/widgets/button/text_button.dart';
import 'package:teaching_platform/common/widgets/services.dart/services.dart';
import 'package:teaching_platform/common/widgets/text_field/text_field.dart';
import 'package:teaching_platform/root/widgets/selector.dart';

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    return LayoutBuilder(
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
              Selector(),
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
    );
  }
}

double _columnWidth(BoxConstraints constraints) =>
  constraints.maxWidth * 0.5;

const _spacing = 32.0;
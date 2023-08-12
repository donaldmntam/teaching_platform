import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material show TextField;
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';

class LongTextField extends StatelessWidget {
  final void Function(String text)? onTextChange;

  const LongTextField({
    super.key,
    this.onTextChange,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: theme.colors.background,
      ),
      child: Material(
        color: const Color(0x00000000),
        child: material.TextField(
          onChanged: onTextChange,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4
            ), 
            hoverColor: Color(0x00000000),
            fillColor: Color(0x00000000),
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none
            ),
          ),
          cursorColor: theme.colors.onBackground,
          style: theme.textStyle(
            size: 16,
            weight: FontWeight.normal,
            color: theme.colors.onBackground,
          )
        ),
      ),
    );
  }
}
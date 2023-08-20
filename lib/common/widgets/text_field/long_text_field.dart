import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material show TextField;
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';

class LongTextField extends StatelessWidget {
  final String? hint;
  final void Function(String text)? onTextChange;
  final TextEditingController? controller;

  const LongTextField({
    super.key,
    this.hint,
    this.onTextChange,
    this.controller,
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
          controller: controller,
          onChanged: onTextChange,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4
            ), 
            hoverColor: const Color(0x00000000),
            fillColor: const Color(0x00000000),
            filled: true,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none
            ),
            hintText: hint,
            hintStyle: theme.textStyle(
              size: 16,
              weight: FontWeight.normal,
              color: theme.colors.onBackground.withAlpha(80),
            )
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
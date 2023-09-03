import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material show TextField;
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';

class TextField extends StatelessWidget {
  final bool obscureText;
  final void Function(String value)? onTextChange;
  
  const TextField({
    super.key,
    this.obscureText = false,
    this.onTextChange,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: theme.colors.primary.withAlpha(50),
      ),
      child: Material(
        color: const Color(0x00000000),
        child: material.TextField(
          obscureText: obscureText,
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
            )
          ),
          style: theme.textStyle(
            size: 16,
            weight: FontWeight.normal,
            color: theme.colors.primary,
          )
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:teaching_platform/common/widgets/tappable/tappable.dart';

class Button extends StatelessWidget {
  final Color color;
  final void Function() onPressed;
  final Widget child;

  const Button({
    super.key,
    required this.color,
    required this.onPressed,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return Tappable(
      onTap: onPressed,
      child: Container(
        decoration: ShapeDecoration(
          shape: const StadiumBorder(),
          color: color,
        ),
        child: child,
      )
    );
  }
}
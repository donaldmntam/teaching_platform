import 'package:flutter/material.dart' hide Theme;
import 'package:teaching_platform/common/functions/iterable_functions.dart';
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/widgets/services.dart/services.dart';

class TabBar extends StatelessWidget {
  final List<String> titles;
  final int selectedIndex;
  final void Function(int) onTap;

  const TabBar({
    super.key,
    required this.titles,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: titles.mapIndexed((i, title) =>
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: GestureDetector(
            onTap: () => onTap(i),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Transform.scale(
                scale: selectedIndex == i ? 1 : 0.7,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    title,
                    maxLines: 1,
                    style: theme.textStyle(
                      size: 30,
                      color: theme.colors.primary,
                      weight: selectedIndex == i
                        ? FontWeight.bold
                        : FontWeight.normal,
                    )
                  ),
                ),
              ),
            )
          ),
        )
      ).toList(),
    );
  }
}
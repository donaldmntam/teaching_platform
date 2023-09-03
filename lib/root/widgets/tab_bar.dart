import 'package:flutter/material.dart' hide Theme;
import 'package:teaching_platform/common/functions/iterable_functions.dart';
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';
import 'package:teaching_platform/common/widgets/tappable/tappable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

typedef Tab = ({
  String title,
  bool enabled,
});
class TabBar extends StatelessWidget {
  final IList<Tab> tabs;
  final int selectedIndex;
  final void Function(int) onTap;

  const TabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: tabs.mapIndexed((i, tab) =>
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Tappable(
            onTap: tab.enabled ? () => onTap(i) : null,
            child: Opacity(
              opacity: tab.enabled ? 1.0 : 0.2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Transform.scale(
                  scale: selectedIndex == i ? 1 : 0.7,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      tab.title,
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
              ),
            ),
          ),
        )
      ).toList(),
    );
  }
}

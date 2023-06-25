import 'package:flutter/material.dart' hide TabBar, Theme, TextButton;
import 'package:teaching_platform/common/widgets/button/text_button.dart';
import 'package:teaching_platform/common/widgets/services.dart/services.dart';
import 'package:teaching_platform/login/page.dart' as login;
import 'package:teaching_platform/courses/page.dart' as courses;

import 'widgets/tab_bar.dart';

const _titles = [
  "HOME",
  "COURSES",
  "MISSION",
  "MY STUDIO",
  "SOCIAL MEDIA",
  "CHAT ROOM",
];

// TODO: breakpoints

class Page extends StatefulWidget {
  const Page({
    super.key,
  });

  @override
  State<Page> createState() => _State();
}

class _State extends State<Page> {
  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Text(
              "FUTVENTURELAB",
            ),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              width: _tabBarWidth(constraints),
              height: _tabBarHeight,
              child: TabBar(
                titles: _titles,
                selectedIndex: currentTabIndex,
                onTap: (index) => setState(() => currentTabIndex = index)
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: constraints.maxWidth,
              height: 1,
              color: theme.colors.primary,
            ),
            Flexible(
              flex: 1,
              child: IndexedStack(
                index: currentTabIndex,
                children: const [
                  login.Page(),
                  courses.Page(),
                ]
              ),
            )
          ]
        );
      }
    );
  }
}

double _tabBarWidth(BoxConstraints constraints) =>
  constraints.maxWidth * 0.9;

const _tabBarHeight = 50.0;
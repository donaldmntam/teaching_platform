import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart' hide TabBar, Theme, TextButton, Tab;
import 'package:teaching_platform/common/widgets/services/services.dart';
import 'package:teaching_platform/courses/page.dart' as courses;
import 'package:teaching_platform/tasks/page.dart' as page_tasks;
import 'package:teaching_platform/social_media/page.dart' as social_media;

import 'widgets/tab_bar.dart';

// const _initialTabs = IListConst(<Tab>[
//   (title: "HOME", enabled: true),
//   (title: "COURSES", enabled: false),
//   (title: "MISSION", enabled: false),
//   (title: "SOCIAL MEDIA", enabled: false),
// ]);
// 
// const _tabsAfterLoggingIn = IListConst(<Tab>[
//   (title: "HOME", enabled: true),
//   (title: "COURSES", enabled: true),
//   (title: "MISSION", enabled: true),
//   (title: "SOCIAL MEDIA", enabled: true),
// ]);
const _tabs = IListConst(<Tab>[
  (title: "COURSES", enabled: true),
  (title: "MISSION", enabled: true),
  (title: "SOCIAL MEDIA", enabled: true),
]);

class Page extends StatefulWidget {
  const Page({
    super.key,
  });

  @override
  State<Page> createState() => _State();
}

class _State extends State<Page> {
  int currentTabIndex = 0;
  IList<Tab> tabs = _tabs;

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            const SizedBox(height: 24),
            Image.asset(
              "assets/images/logo.png",
              width: 500,
              height: 80,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              width: _tabBarWidth(constraints),
              height: _tabBarHeight,
              child: TabBar(
                tabs: tabs,
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
                  courses.Page(),
                  page_tasks.Page(),
                  social_media.Page(),
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

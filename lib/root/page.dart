import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart' hide TabBar, Theme, TextButton, Tab;
import 'package:teaching_platform/common/models/social_media/content.dart';
import 'package:teaching_platform/common/models/social_media/post.dart';
import 'package:teaching_platform/common/models/task/input.dart';
import 'package:teaching_platform/common/models/task/question.dart';
import 'package:teaching_platform/common/models/task/task.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';
import 'package:teaching_platform/login/page.dart' as login;
import 'package:teaching_platform/courses/page.dart' as courses;
import 'package:teaching_platform/tasks/page.dart' as page_tasks;
import 'package:teaching_platform/social_media/page.dart' as social_media;
import 'package:teaching_platform/common/models/social_media/user.dart';

import 'widgets/tab_bar.dart';

import 'dart:ui' as ui;

const _initialTabs = IListConst(<Tab>[
  (title: "HOME", enabled: true),
  (title: "COURSES", enabled: false),
  (title: "MISSION", enabled: false),
  (title: "SOCIAL MEDIA", enabled: false),
]);

const _tabsAfterLoggingIn = IListConst(<Tab>[
  (title: "HOME", enabled: true),
  (title: "COURSES", enabled: true),
  (title: "MISSION", enabled: true),
  (title: "SOCIAL MEDIA", enabled: true),
]);

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
  IList<Tab> tabs = _initialTabs;

  void didLogIn(User user) {
    final services = Services.of(context);
    services.listener.didLogIn(user);
    setState(() =>
      tabs = _tabsAfterLoggingIn,
    );
  }

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
                children: [
                  login.Page(
                    listener: (
                      didLogIn: didLogIn,
                    ),
                  ),
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

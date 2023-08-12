import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart' hide TabBar, Theme, TextButton;
import 'package:teaching_platform/common/models/social_media/content.dart';
import 'package:teaching_platform/common/models/social_media/post.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';
import 'package:teaching_platform/login/page.dart' as login;
import 'package:teaching_platform/courses/page.dart' as courses;
import 'package:teaching_platform/tasks/page.dart' as tasks;
import 'package:teaching_platform/social_media/page.dart' as social_media;

import 'widgets/tab_bar.dart';

const _titles = [
  "HOME",
  "COURSES",
  "MISSION",
  // "MY STUDIO",
  "SOCIAL MEDIA",
  // "CHAT ROOM",
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
                children: [
                  login.Page(),
                  courses.Page(),
                  tasks.Page(),
                  social_media.Page(
                    posts: <Post>[
                      const (
                        creator: (userName: "donaldtam", picture: NetworkImage("https://picsum.photos/100")),
                        content: TextContent("This is my first post ever!"),
                        liked: true,
                      ),
                      const (
                        creator: (userName: "jackson123", picture: NetworkImage("https://picsum.photos/100")),
                        content: ImageContent(NetworkImage("https://picsum.photos/200")),
                        liked: false,
                      ),
                    ].lock
                  ),
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
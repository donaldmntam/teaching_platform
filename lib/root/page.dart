import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart' hide TabBar, Theme, TextButton, Tab;
import 'package:teaching_platform/common/widgets/services/services.dart';
import 'package:teaching_platform/courses/page.dart' as courses;
import 'package:teaching_platform/tasks/page.dart' as page_tasks;
import 'package:teaching_platform/social_media/page.dart' as social_media;
import 'package:teaching_platform/common/models/course/course_group.dart';
import 'package:flutter/services.dart';
import 'package:teaching_platform/common/functions/json_functions.dart';
import 'package:teaching_platform/common/monads/try.dart';
import 'package:teaching_platform/common/models/social_media/post.dart';
import 'package:teaching_platform/common/models/task/task.dart';

import 'widgets/tab_bar.dart';

typedef _Data = ({
  IList<Task> tasks,
  IList<CourseGroup> courseGroups,
  IList<Post> posts,
});

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
  _Data? data;

  @override 
  void initState() {
    initData();
    super.initState();
  }
  
  void initData() async {
    final tasksString =
      await rootBundle.loadString("assets/data/tasks.json");
    final courseGroupsString = 
      await rootBundle.loadString("assets/data/course_groups.json");
    final postsString =
      await rootBundle.loadString("assets/data/posts.json");

    final encodedTasks = tryJsonDecode(tasksString);
    final encodedCourseGroups = tryJsonDecode(courseGroupsString);
    final encodedPosts = tryJsonDecode(postsString);

    final tasks = jsonToTasks(encodedTasks.unwrap());
    final courseGroups = jsonToCourseGroups(encodedCourseGroups.unwrap());
    final posts = jsonToPosts(encodedPosts.unwrap());

    if (tasks == null) throw "Json to tasks failed!";
    if (courseGroups == null) throw "Json to course groups failed!";
    if (posts == null) throw "Json to posts failed!";

    setState(() => data = (
      tasks: tasks,
      courseGroups: courseGroups,
      posts: posts,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    final data = this.data;
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
              child: data == null
                ? const Center(child: CircularProgressIndicator())
                : IndexedStack(
                index: currentTabIndex,
                children: [
                  courses.Page(courseGroups: data.courseGroups),
                  page_tasks.Page(tasks: data.tasks),
                  social_media.Page(initialPosts: data.posts),
                ],
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

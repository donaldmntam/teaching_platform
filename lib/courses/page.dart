import 'package:flutter/material.dart' hide TextButton, State, Theme;
import 'package:flutter/widgets.dart' as widgets show State;
import 'package:teaching_platform/courses/widgets/content.dart';
import 'package:teaching_platform/courses/widgets/course_column.dart';
import 'package:teaching_platform/courses/widgets/video_bar/video_bar.dart';

const _courseColumnRelativeWidth = 0.2;
const _contentRelativeWidth = 0.6;

class Page extends StatefulWidget {
  const Page({super.key});

  @override
  widgets.State<Page> createState() => _State();
}

class _State extends widgets.State<Page> {
  Data? data;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: Row(
            children: [
              SizedBox(
                width: constraints.maxWidth * _courseColumnRelativeWidth,
                height: constraints.maxHeight,
                child: CourseColumn(                  
                  List.generate(10, (_) => List.generate(5, (i) => "course $i"))
                )
              ),
              SizedBox(
                width: constraints.maxWidth * _contentRelativeWidth,
                height: constraints.maxHeight,
                child: const Content(),
              ),
            ]
          ),
        );
      }
    );
  }
}


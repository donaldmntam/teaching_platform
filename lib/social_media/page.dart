import 'package:flutter/material.dart' hide State;
import 'package:flutter/widgets.dart' as widgets show State;
import 'package:teaching_platform/common/models/social_media/content.dart';
import 'package:teaching_platform/social_media/widgets/post_card/post_card.dart';

class Page extends StatefulWidget {
  const Page({
    super.key,
  });

  @override
  widgets.State<Page> createState() => _State();
}

class _State extends widgets.State<Page> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: 500,
            child: PostCard((
              content: ImageContent(
                image: NetworkImage("https://picsum.photos/200/300")
              )
            ))
          )
        ]
      )
    );
  }
}
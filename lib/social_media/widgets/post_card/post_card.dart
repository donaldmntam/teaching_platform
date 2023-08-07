import 'package:flutter/material.dart';
import 'package:teaching_platform/common/widgets/services.dart/services.dart';
import 'package:teaching_platform/social_media/widgets/post_card/button_row.dart';
import 'package:teaching_platform/social_media/widgets/post_card/content.dart';

const _shadow = BoxShadow(
  color: Color(0x11000000),
  blurRadius: 2,
  spreadRadius: 2,
  offset: Offset(0, 1),
);

double _contentWidth(BoxConstraints constraints) =>
  constraints.maxWidth * 0.9;
double _contentHeight(BoxConstraints constraints) =>
  constraints.maxHeight * 0.8;

double _buttonRowWidth(BoxConstraints constraints) =>
  constraints.maxWidth * 0.9;
double _buttonRowHeight(BoxConstraints constraints) =>
  constraints.maxHeight * 0.1;

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
  });

  // TODO: use constants (not relative for padding?)

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    return Container(
      decoration: BoxDecoration(
        color: theme.colors.surface,
        boxShadow: const [_shadow],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              const Spacer(),
              Content(
                width: _contentWidth(constraints),
                height: _contentHeight(constraints),
              ),
              const Spacer(),
              ButtonRow(
                width: _buttonRowWidth(constraints), 
                height: _buttonRowHeight(constraints),
                liked: true,
                bookmarked: false,
                onLikePressed: () {}, 
                onCommentPressed: () {},
                onSharePressed: () {},
                onBookmarkPressed: () {}
              ),
              const Spacer(),
            ]
          );
        }
      )
    );
  }
}

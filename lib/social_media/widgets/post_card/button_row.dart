import 'package:flutter/material.dart' hide Theme;
import 'package:flutter/widgets.dart';
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/widgets/services.dart/services.dart';

Color _buttonColor(Theme theme) => theme.colors.onSurface.withAlpha(125);
double _spacing(double height) => height * 0.3;

class ButtonRow extends StatelessWidget {
  final double width;
  final double height; 
  final bool liked;
  final bool bookmarked;
  final void Function() onLikePressed;
  final void Function() onCommentPressed; 
  final void Function() onSharePressed;
  final void Function() onBookmarkPressed;

  const ButtonRow({
    super.key,
    required this.width,
    required this.height,
    required this.liked,
    required this.bookmarked,
    required this.onLikePressed,
    required this.onCommentPressed,
    required this.onSharePressed,
    required this.onBookmarkPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;

    return SizedBox(
      width: width,
      height: height,
      child: Row(
        children: [
          Icon(
            liked ? Icons.favorite : Icons.favorite_outline,
            color: liked ? Colors.red : _buttonColor(theme),
            size: height,
          ),
          SizedBox(width: _spacing(height)),
          Icon(
            Icons.comment_outlined,
            color: _buttonColor(theme),
            size: height,
          ),
          SizedBox(width: _spacing(height)),
          Icon(
            Icons.send_outlined,
            color: _buttonColor(theme),
            size: height,
          ),
          const Spacer(),
          Icon(
            Icons.bookmark_outline,
            color: _buttonColor(theme),
            size: height,
          )
        ]
      ),
    );
  }
}

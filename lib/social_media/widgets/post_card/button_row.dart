import 'package:flutter/material.dart' hide Theme;
import 'package:flutter/widgets.dart';
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/widgets/services.dart/services.dart';

Color _buttonColor(Theme theme) => theme.colors.onSurface.withAlpha(125);
const _spacing = 12.0;
const _iconSize = 32.0;

class ButtonRow extends StatelessWidget {
  final bool liked;
  final bool bookmarked;
  final void Function() onLikePressed;
  final void Function() onCommentPressed; 
  final void Function() onSharePressed;
  final void Function() onBookmarkPressed;

  const ButtonRow({
    super.key,
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

    return Row(
      children: [
        Icon(
          liked ? Icons.favorite : Icons.favorite_outline,
          color: liked ? Colors.red : _buttonColor(theme),
          size: _iconSize,
        ),
        const SizedBox(width: _spacing),
        Icon(
          Icons.comment_outlined,
          color: _buttonColor(theme),
          size: _iconSize,
        ),
        const SizedBox(width: _spacing),
        Icon(
          Icons.send_outlined,
          color: _buttonColor(theme),
          size: _iconSize,
        ),
        const Spacer(),
        Icon(
          Icons.bookmark_outline,
          color: _buttonColor(theme),
          size: _iconSize,
        )
      ]
    );
  }
}

import 'package:flutter/material.dart' hide Theme, Listener;
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';
import 'package:teaching_platform/social_media/widgets/values.dart';
import 'package:teaching_platform/common/widgets/tappable/tappable.dart';
import '../post_card/listener.dart';

Color _buttonColor(Theme theme) => theme.colors.onSurface.withAlpha(125);

class ButtonRow extends StatelessWidget {
  final int index;
  final bool liked;
  final bool bookmarked;
  final Listener listener;

  const ButtonRow({
    super.key,
    required this.index,
    required this.liked,
    required this.bookmarked,
    required this.listener,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;

    return Row(
      children: [
        Tappable(
          onTap: () => listener.onLikePressed(index),
          child: Icon(
            liked ? Icons.favorite : Icons.favorite_outline,
            color: liked ? Colors.red : _buttonColor(theme),
            size: buttonRowHeight,
          ),
        ),
        const SizedBox(width: buttonRowSpacing),
        Tappable(
          onTap: () => listener.onCommentPressed(index),
          child: Icon(
            Icons.comment_outlined,
            color: _buttonColor(theme),
            size: buttonRowHeight,
          )
        ),
        const SizedBox(width: buttonRowSpacing),
        Icon(
          Icons.send_outlined,
          color: _buttonColor(theme),
          size: buttonRowHeight,
        ),
        const Spacer(),
        Icon(
          Icons.bookmark_outline,
          color: _buttonColor(theme),
          size: buttonRowHeight,
        )
      ]
    );
  }
}

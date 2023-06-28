// import 'package:flutter/widgets.dart' hide State;
// import 'package:flutter/widgets.dart' as widgets show State;
// import 'package:teaching_platform/common/functions/error_functions.dart';
// import 'package:teaching_platform/common/widgets/services.dart/services.dart';
// import 'package:teaching_platform/courses/widgets/video_bar.dart';
// import 'package:video_player/video_player.dart' as video_player;

// class VideoPlayer extends StatefulWidget {
//   final Duration duration;

//   const VideoPlayer({
//     super.key,
//     required this.duration,
//   });

//   @override
//   widgets.State<VideoPlayer> createState() => _State();
// }

// class _State extends widgets.State<VideoPlayer> {
//   late final video_player.VideoPlayerController controller;

//   late State state;

//   @override
//   void initState() {
//     controller = video_player.VideoPlayerController.network(
//       'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
//     );
//     controller.initialize().then((_) {
//       play();
//     });

//     super.initState();
//     controller.dispose();
//   }

//   void play() {
//     final now = Services.of(context).clock.now();
//     final state = this.state;
//     switch (state) {
//       case Paused(position: final position):
//         setState(() {
//           this.state = Playing(
//             startingPosition: position,
//             reference: now
//           );
//         });
//         controller.play();
//       case Playing():
//         badTransition(state, "play");
//     }
//   }

//   void pause() {
//     final now = Services.of(context).clock.now();
//     final state = this.state;
//     switch (state) {
//       case Playing(
//         startingPosition: final position,
//         reference: final reference
//       ):
//         setState(() {
//           this.state = Paused(
//             position: position + now.difference(reference)
//           );
//         });
//         controller.pause();
//       case Paused():
//         badTransition(state, "pause");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         VideoBar(
//           duration: widget.duration,
//           state: state,
//           onToggle: () {},
//           onChange: (_) {},
//         ),
//       ]
//     );
//   }
// }

// sealed class State {}

// final class Paused implements State {
//   final Duration position;

//   const Paused({required this.position});
// }

// final class Playing implements State {
//   final DateTime reference;
//   final Duration startingPosition;

//   const Playing({
//     required this.reference,
//     required this.startingPosition,
//   });
// }

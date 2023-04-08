import 'package:android/views/video%20feed%20page/content.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:video_player/video_player.dart';

class VideoFeed extends StatefulWidget {
  const VideoFeed({super.key});

  @override
  State<VideoFeed> createState() => _VideoFeedState();
}

class _VideoFeedState extends State<VideoFeed> {
  late VideoPlayerController videoPlayerController;
  final List<String> videos = [
    'https://assets.mixkit.co/videos/preview/mixkit-taking-photos-from-different-angles-of-a-model-34421-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-young-mother-with-her-little-daughter-decorating-a-christmas-tree-39745-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-mother-with-her-little-daughter-eating-a-marshmallow-in-nature-39764-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-girl-in-neon-sign-1232-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-winter-fashion-cold-looking-woman-concept-video-39874-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-womans-feet-splashing-in-the-pool-1261-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4'
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: PageView.builder(
            scrollDirection: Axis.vertical,
            itemBuilder: (_, i) {
              return Content(
                url: videos[i],
              );
            },
            itemCount: videos.length,
          )),
    );
  }
}








// class VideoApp extends StatefulWidget {
//   final String url;
//   const VideoApp({Key? key, required this.url}) : super(key: key);

//   @override
//   VideoAppState createState() => VideoAppState();
// }

// class VideoAppState extends State<VideoApp> {
//   late VideoPlayerController _controller;
//   bool _isPlaying = false;
//   Duration _duration = const Duration();
//   Duration _position = const Duration();

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.url)
//       ..addListener(() {
//         final bool isPlaying = _controller.value.isPlaying;
//         if (isPlaying != _isPlaying) {
//           setState(() {
//             _isPlaying = isPlaying;
//           });
//         }
//         final duration = _controller.value.duration;
//         if (duration != _duration) {
//           setState(() {
//             _duration = duration;
//           });
//         }
//         final position = _controller.value.position;
//         if (position != _position) {
//           setState(() {
//             _position = position;
//           });
//         }
//       })
//       ..initialize().then((_) {
//         setState(() {});
//       });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Video Demo',
//       home: Scaffold(
//         backgroundColor: Colors.black,
//         body: Center(
//           child: _controller.value.isInitialized
//               ? Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     AspectRatio(
//                       aspectRatio: _controller.value.aspectRatio,
//                       child: VideoPlayer(
//                         _controller,
//                       ),
//                     ),
//                     Slider(
//                       value: _position.inSeconds.toDouble(),
//                       min: 0.0,
//                       max: _duration.inSeconds.toDouble(),
//                       onChanged: (value) {
//                         setState(() {
//                           final duration = Duration(seconds: value.toInt());
//                           _controller.seekTo(duration);
//                         });
//                       },
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         IconButton(
//                           onPressed: () {
//                             setState(() {
//                               _controller.seekTo(const Duration(seconds: 5));
//                             });
//                           },
//                           icon: const Icon(
//                             Icons.arrow_forward,
//                             color: Colors.white,
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: _isPlaying
//                               ? () => _controller.pause()
//                               : () => _controller.play(),
//                           icon: _isPlaying
//                               ? const Icon(
//                                   Icons.pause,
//                                   color: Colors.white,
//                                 )
//                               : const Icon(
//                                   Icons.play_arrow,
//                                   color: Colors.white,
//                                 ),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             setState(() {
//                               _controller.seekTo(const Duration(seconds: -5));
//                             });
//                           },
//                           icon: const Icon(
//                             Icons.arrow_back,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 )
//               : const CircularProgressIndicator(),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
// }
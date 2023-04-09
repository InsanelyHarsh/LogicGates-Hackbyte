
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Content extends StatefulWidget {
  final String url;
  const Content({
    super.key,
    required this.url,
  });

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  late VideoPlayerController cont;
  bool _isPlaying = false;
  Duration _duration = const Duration();
  Duration _position = const Duration();
  bool isLiked = false;
  @override
  void dispose() {
    cont.dispose();
    debugPrint('dispose content page');
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    cont = VideoPlayerController.network(widget.url)
      ..addListener(() {
        final bool isPlaying = cont.value.isPlaying;
        if (isPlaying != _isPlaying) {
          setState(() {
            _isPlaying = isPlaying;
          });
        }
        final duration = cont.value.duration;
        if (duration != _duration) {
          setState(() {
            _duration = duration;
          });
        }
        final position = cont.value.position;
        if (position != _position) {
          setState(() {
            _position = position;
          });
        }
      })
      ..initialize().then((_) {
        setState(() {
          cont.play();
          cont.setLooping(true);
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: cont.value.isInitialized
          ? Stack(
              fit: StackFit.expand,
              children: [
                AspectRatio(
                  aspectRatio: size.width / (size.height),
                  child: GestureDetector(
                    onTap: () {
                      if (_isPlaying) {
                        cont.pause();
                      } else {
                        cont.play();
                      }
                    },
                    onDoubleTap: () {
                      setState(() {
                        isLiked = !isLiked;
                      });

                    },
                    child: VideoPlayer(
                      cont,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  width: size.width,
                  height: size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            isLiked=!isLiked;
                          });
                        },
                        child: Icon(
                          Icons.favorite,
                          color: isLiked ? Colors.red : Colors.white,
                          size: 35,
                        ),
                      ),
                      const Text(
                        '100',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Icon(
                        Icons.whatshot,
                        color: Colors.white,
                        size: 35,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Icon(
                        Icons.bookmark,
                        color: Colors.white,
                        size: 35,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Icon(
                        Icons.share,
                        color: Colors.white,
                        size: 35,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.person,color: Colors.white,size: 30,),
                                Text(
                                  'amHarsh_',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const Text(
                              'dassssss',
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            const Text(
                              'adsssssss',
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(color: Colors.white70, fontSize: 17),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          : const CircularProgressIndicator(),
    );
  }
}

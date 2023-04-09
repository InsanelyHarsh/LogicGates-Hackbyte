import 'dart:io';
import 'package:android/api/store_video_firebase.dart';
import 'package:android/views/post_preview.dart';
import 'package:android/views/tab_bars/home.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:art_sweetalert/art_sweetalert.dart';

class VideoPreview extends StatefulWidget {
  final String path;
  const VideoPreview({Key? key, required this.path}) : super(key: key);

  @override
  State<VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  late VideoPlayerController cont;
  final isVisibleAfterVideoOptions = true;
  bool _isPlaying = false;
  bool isVideoUploading = false;
  Duration _duration = const Duration();
  Duration _position = const Duration();
  @override
  void dispose() {
    cont.dispose();
    debugPrint('dispose video priview');
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    cont = VideoPlayerController.file(File(widget.path))
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
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: cont.value.isInitialized
              ? SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * 0.8,
                        child: AspectRatio(
                          aspectRatio: cont.value.aspectRatio,
                          child: VideoPlayer(
                            cont,
                          ),
                        ),
                      ),
                      Slider(
                        thumbColor: Colors.white,
                        activeColor: Colors.white70,
                        inactiveColor: Colors.white30,
                        value: _position.inSeconds.toDouble(),
                        min: 0.0,
                        max: _duration.inSeconds.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            final duration = Duration(seconds: value.toInt());
                            cont.seekTo(duration);
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                cont.seekTo(const Duration(seconds: 5));
                              });
                            },
                            icon: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: _isPlaying
                                ? () => cont.pause()
                                : () => cont.play(),
                            icon: _isPlaying
                                ? const Icon(
                                    Icons.pause,
                                    color: Colors.white,
                                  )
                                : const Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                  ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                cont.seekTo(const Duration(seconds: -5));
                              });
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ), // save logic
                          IconButton(
                            onPressed: () async {
                              ArtDialogResponse response =
                                  await ArtSweetAlert.show(
                                barrierDismissible: false,
                                context: context,
                                artDialogArgs: ArtDialogArgs(
                                  denyButtonText: "Cancel",
                                  title: 'Are You Sure',
                                  text: 'You cant undo this action!',
                                  confirmButtonText: 'Yes, Delete it',
                                  type: ArtSweetAlertType.warning,
                                ),
                              );
                              if (response.isTapCancelButton ||
                                  response.isTapDenyButton) {
                                return;
                              }
                              if (response.isTapConfirmButton) {
                                // ignore: use_build_context_synchronously
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      fullscreenDialog: true,
                                      builder: (_) => const Home(),
                                    ),
                                    (route) => false);
                              } else {}
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              setState(() {
                                isVideoUploading = true;
                              });
                              await uploadFile(File(widget.path))
                                  .then((value) async {
                                setState(() {
                                  isVideoUploading = false;
                                });
                                await ArtSweetAlert.show(
                                  barrierDismissible: false,
                                  context: context,
                                  artDialogArgs: ArtDialogArgs(
                                    title: 'Video Upload Success',
                                    text: 'Almost There',
                                    confirmButtonText: 'Ok',
                                    type: ArtSweetAlertType.success,
                                  ),
                                );
                                // ignore: use_build_context_synchronously
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      fullscreenDialog: true,
                                      builder: (_) =>
                                          PostPreview(downloadUrl: value),
                                    ),
                                    (route) => false);
                              });
                            }, 
                            icon: isVideoUploading
                                ? const CircularProgressIndicator()
                                : const Icon(
                                    Icons.save,
                                    color: Colors.white,
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
   
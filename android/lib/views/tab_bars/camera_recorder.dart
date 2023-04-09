import 'package:android/views/video_preview.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraRecorder extends StatefulWidget {
  const CameraRecorder({
    Key? key,
  }) : super(key: key);

  @override
  State<CameraRecorder> createState() => _CameraRecorderState();
}

class _CameraRecorderState extends State<CameraRecorder> {
  final globalKey = GlobalKey<ScaffoldState>();
  int ellipseState = 0;
  bool isRecording = false;

  String? filePath;
  bool isrecording = false;
  bool isFrontCamera = true;
  List<CameraDescription>? cameras;
  CameraController? controller;
  XFile? image;

  @override
  void initState() {
    debugPrint('initialize started');
    loadCamera();

    debugPrint('initialize done');
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    debugPrint('dispose camera recorder');
    super.dispose();
  }

  loadCamera() async {
    debugPrint('Hello');
    cameras = await availableCameras();
    if (cameras != null) {
      if (isFrontCamera) {
        controller = CameraController(cameras![0], ResolutionPreset.max);
      } else {
        controller = CameraController(cameras![1], ResolutionPreset.max);
      }
      controller!.initialize().then((value) {
        if (!mounted) {
          return;
        }
        setState(() {
          debugPrint('initialize done 1');
        });
      });
    } else {
      debugPrint('No Camera found');
    }
  }

  recordVideo() async {
    if (isRecording) {
      final file = await controller?.stopVideoRecording();
      filePath = file?.path;
      debugPrint('path:${file?.path}');
      setState(() {
        isRecording = false;
        final route = MaterialPageRoute(
          fullscreenDialog: true,
          builder: ((context) => VideoPreview(path: filePath.toString())),
        );
        Navigator.pushAndRemoveUntil(context, route, ((route) => false));
      });
    } else {
      await controller?.prepareForVideoRecording();
      await controller?.startVideoRecording();
      setState(() {
        isRecording = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (controller == null || !controller!.value.isInitialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            AspectRatio(
              aspectRatio: size.width / (size.height-20),
              child: CameraPreview(controller!),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 100,
                width: size.height,
                color: Colors.black38,
                child: Center(
                  child: GestureDetector(
                    onTap: recordVideo,
                    child: Icon(
                      isRecording ? Icons.stop_circle : Icons.play_circle,
                      color: Colors.white,size: 50,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

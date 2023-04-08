// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';

// class CameraApp extends StatefulWidget {
//   final List<CameraDescription> cameras;
//   const CameraApp({Key? key, required this.cameras}) : super(key: key);

//   @override
//   State<CameraApp> createState() => _CameraAppState();
// }

// class _CameraAppState extends State<CameraApp> {
//   late CameraController controller;

//   @override
//   void initState() {
//     super.initState();
//     controller = CameraController(widget.cameras[0], ResolutionPreset.max);
//     controller.initialize().then((_) {
//       if (!mounted) {
//         return;
//       }
//       setState(() {});
//     }).catchError((Object e) {
//       if (e is CameraException) {
//         switch (e.code) {
//           case 'CameraAccessDenied':
//             // Handle access errors here.
//             break;
//           default:
//             // Handle other errors here.
//             break;
//         }
//       }
//     });
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     if (!controller.value.isInitialized) {
//       return Container();
//     }
//     return Scaffold(
//       // home: CameraPreview(
//       //       controller,
//       //     ),
//       body: Stack(
//         children: [
//           CameraPreview(
//             controller,
//           ),
//           Positioned(
//             bottom: 0,
//             child: SizedBox(
//               height: 100,
//               width: size.width,
//               //decoration: BoxDecoration(color: Colors.black),
//               child: const Icon(
//                 Icons.camera,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

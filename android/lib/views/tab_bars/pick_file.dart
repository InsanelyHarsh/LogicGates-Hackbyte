
import 'package:android/views/video_preview.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class PickFile extends StatefulWidget {
  const PickFile({super.key});

  @override
  State<PickFile> createState() => _PickFileState();
}

class _PickFileState extends State<PickFile> {
  TextEditingController title = TextEditingController();
  TextEditingController tags = TextEditingController();
  TextEditingController description = TextEditingController();
  pickFileFunction(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );
    if (result == null) {
      return;
    }
    final file = result.files.first;
    final route = MaterialPageRoute(
      fullscreenDialog: true,
      builder: ((context) => VideoPreview(
            path: file.path.toString(),
          )),
    );
    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
      context,
      route,
      ((route) => false),
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Show Your Talent',
            style: TextStyle(
              color: Colors.black,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/camera', (route) => false);
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Capture Media',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => pickFileFunction(context),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  child: const Text(
                    'Upload Media',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          
        ],
      ),
    );
  }


}

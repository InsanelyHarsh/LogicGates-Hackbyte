import 'package:android/api/upload_posts.dart';
import 'package:android/models/local_db.dart';
import 'package:android/views/tab_bars/home.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostPreview extends StatefulWidget {
  final String downloadUrl;
  const PostPreview({super.key, required this.downloadUrl});

  @override
  State<PostPreview> createState() => _PostPreviewState();
}

class _PostPreviewState extends State<PostPreview> {
  TextEditingController title = TextEditingController();
  TextEditingController tags = TextEditingController();
  TextEditingController description = TextEditingController();
  final key = GlobalKey<FormState>();
  final sendPost = PostsGetAndUpload();
  submit() async {
    //print('submit pressed');
    if (key.currentState!.validate()) {
      //print('validate');
      final localDb = Provider.of<LocalDb>(context, listen: false);
      Map<String, dynamic> mp = {
        'title': title.text,
        'link': widget.downloadUrl,
        'tags': [tags.text],
        'description': description.text
      };
      //print('called');
      final ans = await sendPost.sendPost(mp, localDb.user!.token);
      //print(ans);
      if (ans['success']) {
        // ignore: use_build_context_synchronously
        await ArtSweetAlert.show(
          barrierDismissible: false,
          context: context,
          artDialogArgs: ArtDialogArgs(
            title: 'Success',
            text: 'Return back',
            confirmButtonText: 'Ok',
            type: ArtSweetAlertType.success,
          ),
        );
        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } else {
        // ignore: use_build_context_synchronously
        await ArtSweetAlert.show(
          barrierDismissible: false,
          context: context,
          artDialogArgs: ArtDialogArgs(
            title: 'Faild to upload',
            text: 'Return back',
            confirmButtonText: 'Ok',
            type: ArtSweetAlertType.danger,
          ),
        );
      }
    }
   // print('end');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            child: Form(
              key: key,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Finalize The Post',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    textFormField(title, false, 'Title', (x) {
                      if (x == null || x.isEmpty) {
                        return 'Please enter valid string';
                      }
                      return null;
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    textFormField(tags, false, 'Tags', (x) {
                      if (x == null || x.isEmpty) {
                        return 'Please enter valid string';
                      }
                      return null;
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    textFormField(description, false, 'Description...', (x) {
                      if (x == null || x.isEmpty) {
                        return 'Please enter valid string';
                      }
                      return null;
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: submit,
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12)),
                            child: const Text(
                              'Submit Post',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
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
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1.2),
                                borderRadius: BorderRadius.circular(12)),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  textFormField(TextEditingController cont, bool showText, String text,
      String? Function(String?) f) {
    return TextFormField(
      controller: cont,
      obscureText: showText,
      decoration: InputDecoration(
        labelText: text,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      validator: f,
    );
  }
}

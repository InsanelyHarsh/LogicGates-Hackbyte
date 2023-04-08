// import 'dart:io';

// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:path/path.dart';

// Future<String> uploadFile(File file) async {
//   // Create a reference to the location where you want to upload the file.
//   final Reference ref = FirebaseStorage.instance.ref().child('posts/test');
//   UploadTask uploadTask = ref.putFile(file);

//   final snapshot = await uploadTask.whenComplete(() => {});
//   final downloadUrl = await snapshot.ref.getDownloadURL();
//   debugPrint('Download url: $downloadUrl');

//   return downloadUrl;
// }

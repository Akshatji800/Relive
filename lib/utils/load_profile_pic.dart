import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

Future<Uint8List?> loadProfilePic(String uId) async {
  Uint8List? imageBytes;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instanceFor(
      bucket: "gs://mental-health-e175a.appspot.com");
  await firebaseStorage
      .ref()
      .child("user/profile/$uId")
      .getData(100000000)
      .then((value) => {imageBytes = value!});
  return imageBytes;
}
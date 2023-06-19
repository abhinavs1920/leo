import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class Storage {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  ///Uploading Raise Emergency Images to storage bucket
  Future<String> uploadImage(String path, File image) async {
    Reference ref = _storage.ref('/eventImages').child(path);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(
      () {
        debugPrint('Uploaded');
      },
    );
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }
}

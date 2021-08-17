import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class MyStorage {
  final String folder;

  MyStorage(this.folder);
  Future<String> loadImage(String path) async {
    final ref =
        FirebaseStorage.instance.ref().child(folder.toLowerCase()).child(path);
    // print(ref.getData());
    var url = await ref.getDownloadURL();

    return url;
  }
}

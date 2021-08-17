import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mypage/app/data/fb_storage.dart';
import 'package:mypage/app/data/my_image_model.dart';
import 'package:octo_image/octo_image.dart';

class MyImage extends StatelessWidget {
  final MyImageModel model;
  final String folder;
  const MyImage({Key? key, required this.model, required this.folder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: convertAndSign(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return OctoImage(
            image: CachedNetworkImageProvider(snapshot.data!),
            placeholderBuilder: OctoPlaceholder.blurHash(
              model.blurhash ?? 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
            ),
            errorBuilder: (context, error, stackTrace) =>
                Text(error.toString()),
            fit: BoxFit.cover,
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  Future<String> convertAndSign() async {
    // var snapshot = await model.get();
    // MyImageModel imageModel = snapshot.data()!;
    var image = await MyStorage(folder).loadImage(model.image!);
    return image;
  }
}



class MyImageModel {
  String? image;
  String? blurhash;

  MyImageModel({required this.image, required this.blurhash});

  MyImageModel.fromJson(Map<dynamic, dynamic> json) {
    image = json["image"];
    blurhash = json["blurhash"];
  }

  // MyImageModel.fromSnapShot(DocumentReference<Map<String, dynamic>> doc) {
  //   doc.get().then((data) {
  //     print(data.data());
  //     image = data.data()!["image"].toString();
  //     blurhash = data.data()!["blurhash"].toString();
  //   });
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["image"] = image;
    data["blurhash"] = blurhash;
    return data;
  }
}

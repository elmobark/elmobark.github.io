import 'package:mypage/app/data/my_image_model.dart';

class Project {
  late int id;
  late String name;
  late MyImageModel icon;
  late String owner;
  late String description;
  late String shotDescription;
  late int likes;
  late List<MyImageModel> images;
  late Links links;

  Project(
      {required this.id,
      required this.name,
      required this.icon,
      required this.owner,
      required this.description,
      required this.shotDescription,
      required this.likes,
      required this.images,
      required this.links});

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    owner = json['owner'];
    description = json['description'];
    shotDescription = json['shotDescription'];
    likes = json['likes'];
    images = json['images'];
    if (json['images'] != null) {
      // json.
      images = json['images'].map((image) =>
          MyImageModel(image: image['image'], blurhash: image['blurhash']));
    }
    links = Links.fromJson(json['links']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['owner'] = this.owner;
    data['description'] = this.description;
    data['shotDescription'] = this.shotDescription;
    data['likes'] = this.likes;
    data['images'] = this.images;
    data['links'] = this.links.toJson();
    return data;
  }
}

class Links {
  String? android;
  String? iOS;
  String? web;

  Links({this.android, this.iOS, this.web});

  Links.fromJson(List json) {
    android = json.elementAt(0);
    iOS = json.elementAt(1);
    web = json.elementAt(2);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['android'] = this.android;
    data['iOS'] = this.iOS;
    data['web'] = this.web;
    return data;
  }
}

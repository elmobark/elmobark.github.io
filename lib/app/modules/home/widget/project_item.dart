import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:mypage/app/data/projects.dart';
import 'package:mypage/app/modules/home/widget/my_image.dart';

import 'like.dart';

class ProjectItem extends StatelessWidget {
  ProjectItem(this.project, this.reference);

  final Project project;
  final DocumentReference<Project> reference;

  /// Returns the project poster.
  Widget get poster {
    return SizedBox(
      height: 100,
      width: 100,
      child: MyImage(
        model: project.icon,
        folder: project.name,
      ),
    );
  }

  Widget get imageList {
    return SizedBox(
      height: 300,
      child: CarouselSlider(
          items: project.images.map((e) {
            
            return MyImage(model: e, folder: project.name);
          }).toList(),
          options: CarouselOptions(
            height: 300,

            aspectRatio: 1 / 2,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,

            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.easeInOut,

            enlargeCenterPage: false,
            // onPageChanged: callbackFunction,
            scrollDirection: Axis.horizontal,
          )),
    );
  }

  /// Returns project details.
  Widget get details {
    return Parent(
      style: ParentStyle(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          title,
          metadata,
          // genres,
          Likes(
            reference: reference,
            currentLikes: project.likes,
          )
        ],
      ),
    );
  }

  /// Return the project title.
  Widget get title {
    return Text(
      '${project.name} (${project.owner})',
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  /// Returns metadata about the project.
  Widget get metadata {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Text(project.shotDescription),
    );
  }

  /// Returns a list of genre project tags.
  List<Widget> get genreItems {
    var links = project.links;
    return [
      if (links.android!.isNotEmpty)
        Padding(
          padding: const EdgeInsets.only(right: 2),
          child: Chip(
            backgroundColor: Colors.lightBlue,
            avatar: CircleAvatar(
              child: Icon(Icons.android_rounded),
            ),
            label: Text(
              'Android',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      if (links.iOS!.isNotEmpty)
        Padding(
          padding: const EdgeInsets.only(right: 2),
          child: Chip(
            backgroundColor: Colors.lightBlue,
            avatar: CircleAvatar(
              child: Icon(Icons.phone_iphone_rounded),
            ),
            label: Text(
              'iOS',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      if (links.web!.isNotEmpty)
        Padding(
          padding: const EdgeInsets.only(right: 2),
          child: Chip(
            backgroundColor: Colors.lightBlue,
            avatar: CircleAvatar(
              child: Icon(Icons.code),
            ),
            label: Text(
              'Web',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        )
    ];
  }

  /// Returns all genres.
  Widget get genres {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Wrap(
        children: genreItems,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..background.color(Colors.grey)
        ..margin(all: 16)
        ..borderRadius(all: 16),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          imageList,
          details,
        ],
      ),
    );
  }
}

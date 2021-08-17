import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mypage/app/data/projects.dart';
import 'package:mypage/app/modules/home/widget/project_item.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Firestore Example: Movies'),

            // This is a example use for 'snapshots in sync'.
            // The view reflects the time of the last Firestore sync; which happens any time a field is updated.
            StreamBuilder(
              stream: FirebaseFirestore.instance.snapshotsInSync(),
              builder: (context, _) {
                return Text(
                  'Latest Snapshot: ${DateTime.now()}',
                  style: Theme.of(context).textTheme.caption,
                );
              },
            )
          ],
        ),
        actions: <Widget>[
          PopupMenuButton<ProjectQuery>(
            onSelected: controller.updateMoviesQuery,
            icon: const Icon(Icons.sort),
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: ProjectQuery.year,
                  child: Text('Sort by Year'),
                ),
                const PopupMenuItem(
                  value: ProjectQuery.score,
                  child: Text('Sort by Score'),
                ),
                const PopupMenuItem(
                  value: ProjectQuery.likesAsc,
                  child: Text('Sort by Likes ascending'),
                ),
                const PopupMenuItem(
                  value: ProjectQuery.likesDesc,
                  child: Text('Sort by Likes descending'),
                ),
                const PopupMenuItem(
                  value: ProjectQuery.fantasy,
                  child: Text('Filter genre Fantasy'),
                ),
                const PopupMenuItem(
                  value: ProjectQuery.sciFi,
                  child: Text('Filter genre Sci-Fi'),
                ),
              ];
            },
          ),
          PopupMenuButton<String>(
            onSelected: (_) => controller.resetLikes(),
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'reset_likes',
                  child: Text('Reset like counts (WriteBatch)'),
                ),
              ];
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Project>>(
        stream: controller.projects.value,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.requireData;

          return SizedBox(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: CarouselSlider(
                items: data.docs
                    .map((e) => ProjectItem(e.data(), e.reference))
                    .toList(),
                options: CarouselOptions(
                  height: 300,

                  aspectRatio: 1 / 2,
                  viewportFraction: 0.2,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  reverse: false,
                  autoPlay: true,

                  autoPlayInterval: Duration(milliseconds: 20),
                  disableCenter: true,

                  autoPlayAnimationDuration: Duration(milliseconds: 500),
                  autoPlayCurve: Curves.linear,
                  pageSnapping: false,

                  enlargeCenterPage: false,
                  // onPageChanged: callbackFunction,
                  scrollDirection: Axis.horizontal,
                )),
          );
        },
      ),
    );
  }
}

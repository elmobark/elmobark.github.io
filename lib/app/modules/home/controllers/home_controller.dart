import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mypage/app/data/my_image_model.dart';
import 'package:mypage/app/data/projects.dart';

class HomeController extends GetxController {
  Rx<Query<Project>?> _moviesQuery = Rx<Query<Project>?>(null);
  Rx<Stream<QuerySnapshot<Project>>?> projects =
      Rx<Stream<QuerySnapshot<Project>>?>(null);
  @override
  void onInit() {
    super.onInit();
    updateMoviesQuery(ProjectQuery.year);
  }

  Future<void> resetLikes() async {
    final movies = await moviesRef.get();
    WriteBatch batch = FirebaseFirestore.instance.batch();

    for (final movie in movies.docs) {
      batch.update(movie.reference, {'likes': 0});
    }
    await batch.commit();
  }

  void updateMoviesQuery(ProjectQuery query) {
    _moviesQuery(moviesRef);
    projects(_moviesQuery.value!.snapshots());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

final moviesRef =
    FirebaseFirestore.instance.collection('projects').withConverter<Project>(
          fromFirestore: (snapshots, _) {
            var data = snapshots.data()!;
            // DocumentReference iconRef = data["icon"];
            // data["icon"] = iconRef.withConverter<MyImageModel>(
            //   fromFirestore: (iconSnapshot, _) =>
            //       MyImageModel.fromJson(iconSnapshot.data()!),
            //   toFirestore: (value, _) => value.toJson(),
            // );

            // data["images"] = (data["images"] as List)
            //     .cast<DocumentReference>()
            //     .map((e) => e.withConverter<MyImageModel>(
            //           fromFirestore: (imagesSnapshot, _) {
            //             // print(imagesSnapshot.data()!);
            //             return MyImageModel.fromJson(imagesSnapshot.data()!);
            //           },
            //           toFirestore: (value, _) => value.toJson(),
            //         ))
            //     .toList();

            return Project.fromJson(data);
          },
          toFirestore: (movie, _) => movie.toJson(),
        );

/// The different ways that we can filter/sort movies.
enum ProjectQuery {
  year,
  likesAsc,
  likesDesc,
  score,
  sciFi,
  fantasy,
}

extension on Query<Project> {
  /// Create a firebase query from a [ProjectQuery]
  Query<Project> queryBy(ProjectQuery query) {
    switch (query) {
      case ProjectQuery.fantasy:
        return where('genre', arrayContainsAny: ['Fantasy']);

      case ProjectQuery.sciFi:
        return where('genre', arrayContainsAny: ['Sci-Fi']);

      case ProjectQuery.likesAsc:
      case ProjectQuery.likesDesc:
        return orderBy('likes', descending: query == ProjectQuery.likesDesc);

      case ProjectQuery.year:
        return orderBy('year', descending: true);

      case ProjectQuery.score:
        return orderBy('score', descending: true);
    }
  }
}

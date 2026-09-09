import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:validacao/data/api_models/story.dart';

Future<List<Story>> listStories() async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Story> stories = [];
  await db.collection("stories").get().then((event) {
    for (var doc in event.docs) {
      Story story = Story.fromMap(doc.data(), id: doc.id);
      stories.add(story);
    }
  });
  return stories;
}

Future<bool> updateStoryDB({required Story story}) async {
  return FirebaseFirestore.instance
      .collection("stories")
      .doc(story.id)
      .update(story.toMap())
      .then((_) => true)
      .onError((_, _) => false);
}

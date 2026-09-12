import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:validacao/data/api_models/story.dart';

Future<List<Story>> listStories({FirebaseFirestore? firestore}) async {
  final FirebaseFirestore db = firestore ?? FirebaseFirestore.instance;
  final List<Story> stories = [];
  await db.collection('stories').get().then((event) {
    for (final doc in event.docs) {
      final story = Story.fromMap(doc.data(), id: doc.id);
      stories.add(story);
    }
  });
  return stories;
}

Future<bool> updateStoryDB({
  required Story story,
  FirebaseFirestore? firestore,
}) async {
  final FirebaseFirestore db = firestore ?? FirebaseFirestore.instance;
  return db
      .collection('stories')
      .doc(story.id)
      .update(story.toMap())
      .then((_) => true)
      .onError((_, _) => false);
}

Future<bool> addStoryDB({
  required Story story,
  FirebaseFirestore? firestore,
}) async {
  final FirebaseFirestore db = firestore ?? FirebaseFirestore.instance;
  try {
    final docRef = story.id.isNotEmpty
        ? db.collection('stories').doc(story.id)
        : db.collection('stories').doc();
    final storyData = story.toMap();
    storyData['id'] = docRef.id;
    await docRef.set(storyData);
    return true;
  } catch (_) {
    return false;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:validacao/data/api_models/story.dart';
import 'package:validacao/data/repositories/stories_repository.dart';
import 'package:validacao/data/services/database.dart';
import 'package:validacao/utils/result.dart';

class RemoteStoriesRepository implements StoriesRepository {
  RemoteStoriesRepository({FirebaseFirestore? firestore})
    : _firestore = firestore;

  final FirebaseFirestore? _firestore;

  @override
  Future<Result<List<Story>>> getStories() async {
    final List<Story> stories = await listStories(firestore: _firestore);
    return Result.ok(stories);
  }

  @override
  Future<Result<bool>> updateStory({required Story story}) async {
    final result = await updateStoryDB(story: story, firestore: _firestore);
    return Result.ok(result);
  }

  @override
  Future<Result<bool>> addStory({required Story story}) async {
    final result = await addStoryDB(story: story, firestore: _firestore);
    return Result.ok(result);
  }
}

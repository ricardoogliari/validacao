import 'package:validacao/data/api_models/story.dart';
import 'package:validacao/utils/result.dart';

abstract class StoriesRepository {
  Future<Result<List<Story>>> getStories();

  Future<Result<bool>> updateStory({required Story story});
}

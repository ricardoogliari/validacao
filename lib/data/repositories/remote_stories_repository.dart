import 'package:validacao/data/api_models/story.dart';
import 'package:validacao/data/repositories/stories_repository.dart';
import 'package:validacao/data/services/database.dart';
import 'package:validacao/utils/result.dart';

//injeção de dependências
class RemoteStoriesRepository implements StoriesRepository {
  @override
  Future<Result<List<Story>>> getStories() async {
    List<Story> stories = await listStories();
    return Result.ok(stories);
  }
}

import 'package:flutter/material.dart';
import 'package:validacao/data/api_models/story.dart';
import 'package:validacao/data/repositories/stories_repository.dart';
import 'package:validacao/utils/constants.dart';
import 'package:validacao/utils/result.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({required StoriesRepository repository})
    : _repository = repository;

  final StoriesRepository _repository;

  final List<Story> _stories = [];
  List<Story> get stories => _stories;

  Future<Result<List<Story>>> getStories() async {
    try {
      final stories = await _repository.getStories();
      switch (stories) {
        case Ok<List<Story>>():
          _stories.clear();
          for (final story in stories.value) {
            _stories.add(story);
          }
        case Error<List<Story>>():
          debugPrint('Failed to load stories');
      }
      return stories;
    } finally {
      notifyListeners();
    }
  }

  List<Story> filter({
    required String selectedCategory,
    required String searchQuery,
  }) {
    return _stories.where((story) {
      final matchesCategory =
          selectedCategory == allNeeds || story.category == selectedCategory;
      final matchesSearch =
          story.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          story.description.toLowerCase().contains(searchQuery.toLowerCase()) ||
          story.category.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }
}

import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:validacao/data/api_models/story.dart';
import 'package:validacao/data/repositories/stories_repository.dart';
import 'package:validacao/ui/view_models/home_view_model.dart';
import 'package:validacao/utils/constants.dart';
import 'package:validacao/utils/result.dart';

class MockStoriesRepository implements StoriesRepository {
  final List<Story> stories = [];
  bool shouldSucceed = true;

  @override
  Future<Result<List<Story>>> getStories() async {
    if (shouldSucceed) {
      return Result.ok(List.from(stories));
    }
    return Result.error(Exception('Failed to get stories'));
  }

  @override
  Future<Result<bool>> updateStory({required Story story}) async {
    if (shouldSucceed) {
      final index = stories.indexWhere((s) => s.id == story.id);
      if (index != -1) {
        stories[index] = story;
      }
      return const Result.ok(true);
    }
    return Result.error(Exception('Failed to update story'));
  }

  @override
  Future<Result<bool>> addStory({required Story story}) async {
    if (shouldSucceed) {
      stories.add(story);
      return const Result.ok(true);
    }
    return Result.error(Exception('Failed to add story'));
  }
}

void main() {
  group('HomeViewModel', () {
    late MockStoriesRepository mockRepository;
    late HomeViewModel viewModel;

    final testStory = Story(
      id: 'story-1',
      category: food,
      tag: 'FOOD',
      tagColor: const Color(0xFF112233),
      tagBgColor: const Color(0xFF445566),
      title: 'Food Donation',
      description: 'Need groceries',
      imageUrl: 'https://example.com/food.jpg',
      likes: [],
      reports: [],
    );

    setUp(() {
      mockRepository = MockStoriesRepository();
      viewModel = HomeViewModel(repository: mockRepository);
    });

    test('initial stories list is empty', () {
      expect(viewModel.stories, isEmpty);
    });

    group('getStories', () {
      test('populates stories when repository returns Ok', () async {
        mockRepository.stories.add(testStory);

        final result = await viewModel.getStories();

        expect(result, isA<Ok<List<Story>>>());
        expect(viewModel.stories.length, 1);
        expect(viewModel.stories.first.title, 'Food Donation');
      });

      test(
        'clears and does not populate stories when repository fails',
        () async {
          mockRepository.shouldSucceed = false;

          final result = await viewModel.getStories();

          expect(result, isA<Error<List<Story>>>());
          expect(viewModel.stories, isEmpty);
        },
      );
    });

    group('addStory', () {
      test('adds story and refreshes list on success', () async {
        final result = await viewModel.addStory(story: testStory);

        expect(result, isA<Ok<bool>>());
        expect((result as Ok<bool>).value, isTrue);
        expect(viewModel.stories.length, 1);
        expect(viewModel.stories.first.title, 'Food Donation');
      });

      test('notifies listeners when addStory is called', () async {
        var notified = false;
        viewModel.addListener(() {
          notified = true;
        });

        await viewModel.addStory(story: testStory);

        expect(notified, isTrue);
      });

      test('returns Error when repository fails', () async {
        mockRepository.shouldSucceed = false;

        final result = await viewModel.addStory(story: testStory);

        expect(result, isA<Error<bool>>());
        expect(viewModel.stories, isEmpty);
      });
    });

    group('updateStory', () {
      test('updates story and notifies listeners', () async {
        mockRepository.stories.add(testStory);
        await viewModel.getStories();

        final updated = Story(
          id: 'story-1',
          category: food,
          tag: 'FOOD',
          tagColor: const Color(0xFF112233),
          tagBgColor: const Color(0xFF445566),
          title: 'Food Donation Updated',
          description: 'Need groceries',
          imageUrl: 'https://example.com/food.jpg',
          likes: ['user-1'],
          reports: [],
        );

        final result = await viewModel.updateStory(story: updated);

        expect(result, isA<Ok<bool>>());
      });
    });

    group('filter', () {
      test('filters by category and query correctly', () async {
        final story1 = Story(
          id: '1',
          category: food,
          tag: 'FOOD',
          tagColor: const Color(0xFF112233),
          tagBgColor: const Color(0xFF445566),
          title: 'Soup Kitchen',
          description: 'Serving hot soup',
          imageUrl: 'https://example.com/1.jpg',
          likes: [],
          reports: [],
        );

        final story2 = Story(
          id: '2',
          category: medical,
          tag: 'MED',
          tagColor: const Color(0xFF112233),
          tagBgColor: const Color(0xFF445566),
          title: 'First Aid Kit',
          description: 'Bandages and alcohol',
          imageUrl: 'https://example.com/2.jpg',
          likes: [],
          reports: [],
        );

        mockRepository.stories.addAll([story1, story2]);
        await viewModel.getStories();

        final filteredAll = viewModel.filter(
          selectedCategory: allNeeds,
          searchQuery: '',
        );
        expect(filteredAll.length, 2);

        final filteredFood = viewModel.filter(
          selectedCategory: food,
          searchQuery: '',
        );
        expect(filteredFood.length, 1);
        expect(filteredFood.first.id, '1');

        final filteredSearch = viewModel.filter(
          selectedCategory: allNeeds,
          searchQuery: 'soup',
        );
        expect(filteredSearch.length, 1);
        expect(filteredSearch.first.id, '1');
      });
    });
  });
}

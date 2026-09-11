import 'dart:ui';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:validacao/data/api_models/story.dart';
import 'package:validacao/data/repositories/remote_stories_repository.dart';
import 'package:validacao/data/repositories/stories_repository.dart';
import 'package:validacao/utils/result.dart';

void main() {
  group('RemoteStoriesRepository', () {
    late FakeFirebaseFirestore fakeFirestore;
    late RemoteStoriesRepository repository;

    setUp(() {
      fakeFirestore = FakeFirebaseFirestore();
      repository = RemoteStoriesRepository(firestore: fakeFirestore);
    });

    test('implements StoriesRepository interface', () {
      expect(repository, isA<StoriesRepository>());
    });

    test('can be instantiated with default constructor without arguments', () {
      final defaultRepo = RemoteStoriesRepository();
      expect(defaultRepo, isA<StoriesRepository>());
    });

    group('getStories', () {
      test('returns Result.ok with empty list when no stories exist', () async {
        final result = await repository.getStories();

        expect(result, isA<Ok<List<Story>>>());
        final stories = (result as Ok<List<Story>>).value;
        expect(stories, isEmpty);
      });

      test(
        'returns Result.ok with list of stories fetched from database',
        () async {
          final testStory = Story(
            id: 'story-1',
            category: 'Medical',
            tag: 'HEALTH',
            tagColor: const Color(0xFF112233),
            tagBgColor: const Color(0xFF445566),
            title: 'Title 1',
            description: 'Desc 1',
            imageUrl: 'https://example.com/1.jpg',
            likes: ['user-1'],
            reports: [],
          );

          await fakeFirestore
              .collection('stories')
              .doc('story-1')
              .set(testStory.toMap());

          final result = await repository.getStories();

          expect(result, isA<Ok<List<Story>>>());
          final stories = (result as Ok<List<Story>>).value;
          expect(stories.length, 1);
          expect(stories.first.id, 'story-1');
          expect(stories.first.title, 'Title 1');
        },
      );
    });

    group('updateStory', () {
      test('returns Result.ok(true) when story update succeeds', () async {
        final testStory = Story(
          id: 'story-2',
          category: 'Food',
          tag: 'FOOD',
          tagColor: const Color(0xFF112233),
          tagBgColor: const Color(0xFF445566),
          title: 'Title 2',
          description: 'Desc 2',
          imageUrl: 'https://example.com/2.jpg',
          likes: [],
          reports: [],
        );

        await fakeFirestore
            .collection('stories')
            .doc('story-2')
            .set(testStory.toMap());

        final updatedStory = Story(
          id: 'story-2',
          category: 'Food',
          tag: 'FOOD',
          tagColor: const Color(0xFF112233),
          tagBgColor: const Color(0xFF445566),
          title: 'Title 2 Updated',
          description: 'Desc 2',
          imageUrl: 'https://example.com/2.jpg',
          likes: ['liked_user'],
          reports: [],
        );

        final result = await repository.updateStory(story: updatedStory);

        expect(result, isA<Ok<bool>>());
        expect((result as Ok<bool>).value, isTrue);

        final doc = await fakeFirestore
            .collection('stories')
            .doc('story-2')
            .get();
        expect(doc.data()?['title'], 'Title 2 Updated');
        expect(doc.data()?['likes'], ['liked_user']);
      });

      test('returns Result.ok(false) when story update fails', () async {
        final nonExistentStory = Story(
          id: 'missing-doc',
          category: 'Food',
          tag: 'FOOD',
          tagColor: const Color(0xFF112233),
          tagBgColor: const Color(0xFF445566),
          title: 'Missing',
          description: 'Missing',
          imageUrl: 'https://example.com/missing.jpg',
          likes: [],
          reports: [],
        );

        final result = await repository.updateStory(story: nonExistentStory);

        expect(result, isA<Ok<bool>>());
        expect((result as Ok<bool>).value, isFalse);
      });
    });
  });
}

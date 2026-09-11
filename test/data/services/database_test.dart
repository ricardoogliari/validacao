import 'dart:ui';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:validacao/data/api_models/story.dart';
import 'package:validacao/data/services/database.dart';

void main() {
  group('database services', () {
    late FakeFirebaseFirestore fakeFirestore;

    setUp(() {
      fakeFirestore = FakeFirebaseFirestore();
    });

    group('listStories', () {
      test(
        'returns an empty list when the stories collection is empty',
        () async {
          final result = await listStories(firestore: fakeFirestore);

          expect(result, isEmpty);
        },
      );

      test(
        'returns mapped Story instances when stories exist in collection',
        () async {
          final storyData1 = {
            'category': 'Medical',
            'tag': 'HEALTH',
            'tagColor': const Color(0xFF00FF00).toARGB32(),
            'tagBgColor': const Color(0xFF003300).toARGB32(),
            'title': 'Clinic Support',
            'description': 'Medicines needed',
            'imageUrl': 'https://example.com/clinic.jpg',
            'likes': ['user1'],
            'reports': <String>[],
            'isUrgent': true,
          };

          final storyData2 = {
            'category': 'Food',
            'tag': 'MEALS',
            'tagColor': const Color(0xFFFF0000).toARGB32(),
            'tagBgColor': const Color(0xFF330000).toARGB32(),
            'title': 'Food Basket',
            'description': 'Daily meals',
            'imageUrl': 'https://example.com/food.jpg',
            'likes': <String>[],
            'reports': ['user2'],
            'isUrgent': false,
          };

          await fakeFirestore
              .collection('stories')
              .doc('doc-1')
              .set(storyData1);
          await fakeFirestore
              .collection('stories')
              .doc('doc-2')
              .set(storyData2);

          final result = await listStories(firestore: fakeFirestore);

          expect(result.length, 2);

          final firstStory = result.firstWhere((s) => s.id == 'doc-1');
          expect(firstStory.title, 'Clinic Support');
          expect(firstStory.category, 'Medical');
          expect(firstStory.isUrgent, isTrue);
          expect(firstStory.likes, ['user1']);

          final secondStory = result.firstWhere((s) => s.id == 'doc-2');
          expect(secondStory.title, 'Food Basket');
          expect(secondStory.category, 'Food');
          expect(secondStory.isUrgent, isFalse);
          expect(secondStory.reports, ['user2']);
        },
      );
    });

    group('updateStoryDB', () {
      test('updates existing document and returns true', () async {
        final initialStory = Story(
          id: 'story-123',
          category: 'Clothes',
          tag: 'WARMTH',
          tagColor: const Color(0xFF112233),
          tagBgColor: const Color(0xFF445566),
          title: 'Winter Coats',
          description: 'Coats for winter',
          imageUrl: 'https://example.com/coats.jpg',
          likes: [],
          reports: [],
          isUrgent: false,
        );

        await fakeFirestore
            .collection('stories')
            .doc(initialStory.id)
            .set(initialStory.toMap());

        final updatedStory = Story(
          id: 'story-123',
          category: 'Clothes',
          tag: 'WARMTH',
          tagColor: const Color(0xFF112233),
          tagBgColor: const Color(0xFF445566),
          title: 'Winter Coats Updated',
          description: 'Coats and gloves for winter',
          imageUrl: 'https://example.com/coats.jpg',
          likes: ['user-10'],
          reports: [],
          isUrgent: true,
        );

        final success = await updateStoryDB(
          story: updatedStory,
          firestore: fakeFirestore,
        );

        expect(success, isTrue);

        final docSnapshot = await fakeFirestore
            .collection('stories')
            .doc('story-123')
            .get();

        expect(docSnapshot.exists, isTrue);
        expect(docSnapshot.data()?['title'], 'Winter Coats Updated');
        expect(docSnapshot.data()?['likes'], ['user-10']);
        expect(docSnapshot.data()?['isUrgent'], isTrue);
      });

      test('returns false when document does not exist to update', () async {
        final story = Story(
          id: 'non-existing-id',
          category: 'Shelter',
          tag: 'REPAIR',
          tagColor: const Color(0xFF000000),
          tagBgColor: const Color(0xFFFFFFFF),
          title: 'Roof Repair',
          description: 'Fixing leaks',
          imageUrl: 'https://example.com/roof.jpg',
          likes: [],
          reports: [],
        );

        final result = await updateStoryDB(
          story: story,
          firestore: fakeFirestore,
        );

        expect(result, isFalse);
      });
    });
  });
}

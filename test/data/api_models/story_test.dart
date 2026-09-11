import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:validacao/data/api_models/story.dart';

void main() {
  group('Story', () {
    const defaultColorValue = 0xFF123456;
    const defaultBgColorValue = 0xFFAABBCC;

    final sampleStory = Story(
      id: 'story-1',
      category: 'Medical',
      tag: 'HEALTH',
      tagColor: const Color(defaultColorValue),
      tagBgColor: const Color(defaultBgColorValue),
      title: 'Medical Aid Request',
      description: 'Help with medicine supplies',
      imageUrl: 'https://example.com/image.jpg',
      likes: ['user-1', 'user-2'],
      reports: ['user-3'],
      isUrgent: true,
    );

    test('instantiates with provided properties correctly', () {
      expect(sampleStory.id, 'story-1');
      expect(sampleStory.category, 'Medical');
      expect(sampleStory.tag, 'HEALTH');
      expect(sampleStory.tagColor, const Color(defaultColorValue));
      expect(sampleStory.tagBgColor, const Color(defaultBgColorValue));
      expect(sampleStory.title, 'Medical Aid Request');
      expect(sampleStory.description, 'Help with medicine supplies');
      expect(sampleStory.imageUrl, 'https://example.com/image.jpg');
      expect(sampleStory.likes, ['user-1', 'user-2']);
      expect(sampleStory.reports, ['user-3']);
      expect(sampleStory.isUrgent, isTrue);
    });

    test('defaults isUrgent to false when not provided', () {
      final story = Story(
        id: 'story-2',
        category: 'Food',
        tag: 'FOOD',
        tagColor: const Color(defaultColorValue),
        tagBgColor: const Color(defaultBgColorValue),
        title: 'Food Drive',
        description: 'Providing meals',
        imageUrl: 'https://example.com/food.jpg',
        likes: [],
        reports: [],
      );

      expect(story.isUrgent, isFalse);
    });

    group('isLiked', () {
      test('returns true if user is in likes list', () {
        expect(sampleStory.isLiked(user: 'user-1'), isTrue);
        expect(sampleStory.isLiked(user: 'user-2'), isTrue);
      });

      test('returns false if user is not in likes list', () {
        expect(sampleStory.isLiked(user: 'user-999'), isFalse);
        expect(sampleStory.isLiked(user: ''), isFalse);
      });
    });

    group('isReported', () {
      test('returns true if user is in reports list', () {
        expect(sampleStory.isReported(user: 'user-3'), isTrue);
      });

      test('returns false if user is not in reports list', () {
        expect(sampleStory.isReported(user: 'user-1'), isFalse);
        expect(sampleStory.isReported(user: 'other-user'), isFalse);
      });
    });

    group('toMap', () {
      test('correctly converts Story instance to map', () {
        final map = sampleStory.toMap();

        expect(map['id'], 'story-1');
        expect(map['category'], 'Medical');
        expect(map['tag'], 'HEALTH');
        expect(map['tagColor'], const Color(defaultColorValue).toARGB32());
        expect(map['tagBgColor'], const Color(defaultBgColorValue).toARGB32());
        expect(map['title'], 'Medical Aid Request');
        expect(map['description'], 'Help with medicine supplies');
        expect(map['imageUrl'], 'https://example.com/image.jpg');
        expect(map['likes'], ['user-1', 'user-2']);
        expect(map['reports'], ['user-3']);
        expect(map['isUrgent'], isTrue);
      });
    });

    group('fromMap', () {
      test('correctly constructs Story from complete map', () {
        final map = {
          'id': 'story-3',
          'category': 'Education',
          'tag': 'BOOKS',
          'tagColor': defaultColorValue,
          'tagBgColor': defaultBgColorValue,
          'title': 'School Books Needed',
          'description': 'Textbooks for children',
          'imageUrl': 'https://example.com/books.jpg',
          'likes': ['user-1'],
          'reports': ['user-5'],
          'isUrgent': true,
        };

        final story = Story.fromMap(map);

        expect(story.id, 'story-3');
        expect(story.category, 'Education');
        expect(story.tag, 'BOOKS');
        expect(
          story.tagColor.toARGB32(),
          const Color(defaultColorValue).toARGB32(),
        );
        expect(
          story.tagBgColor.toARGB32(),
          const Color(defaultBgColorValue).toARGB32(),
        );
        expect(story.title, 'School Books Needed');
        expect(story.description, 'Textbooks for children');
        expect(story.imageUrl, 'https://example.com/books.jpg');
        expect(story.likes, ['user-1']);
        expect(story.reports, ['user-5']);
        expect(story.isUrgent, isTrue);
      });

      test('overrides map id when explicit id is provided in parameter', () {
        final map = {
          'id': 'original-id',
          'category': 'Education',
          'tag': 'BOOKS',
          'title': 'School Books Needed',
        };

        final story = Story.fromMap(map, id: 'custom-id-123');

        expect(story.id, 'custom-id-123');
      });

      test('uses fallback defaults when map values are null or missing', () {
        final emptyMap = <String, dynamic>{};

        final story = Story.fromMap(emptyMap);

        expect(story.id, '');
        expect(story.category, '');
        expect(story.tag, '');
        expect(story.tagColor, const Color(0x00000000));
        expect(story.tagBgColor, const Color(0x00000000));
        expect(story.title, '');
        expect(story.description, '');
        expect(story.imageUrl, '');
        expect(story.likes, isEmpty);
        expect(story.reports, isEmpty);
        expect(story.isUrgent, isFalse);
      });
    });
  });
}

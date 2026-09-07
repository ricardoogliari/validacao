import 'dart:ui';

class Story {
  final String id;
  final String category;
  final String tag;
  final Color tagColor;
  final Color tagBgColor;
  final String title;
  final String description;
  final String imageUrl;
  int likesCount;
  int reportsCount;
  final bool isUrgent;

  bool get isLiked => likesCount > 0;

  bool get isReported => reportsCount > 0;

  Story({
    required this.id,
    required this.category,
    required this.tag,
    required this.tagColor,
    required this.tagBgColor,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.likesCount,
    required this.reportsCount,
    this.isUrgent = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'tag': tag,
      'tagColor': tagColor.toARGB32(),
      'tagBgColor': tagBgColor.toARGB32(),
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'likesCount': likesCount,
      'reportsCount': reportsCount,
      'isUrgent': isUrgent,
    };
  }

  factory Story.fromMap(Map<String, dynamic> map, {String? id}) {
    return Story(
      id: id ?? (map['id'] as String? ?? ''),
      category: map['category'] as String? ?? '',
      tag: map['tag'] as String? ?? '',
      tagColor: Color((map['tagColor'] as num?)?.toInt() ?? 0),
      tagBgColor: Color((map['tagBgColor'] as num?)?.toInt() ?? 0),
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      imageUrl: map['imageUrl'] as String? ?? '',
      likesCount: (map['likesCount'] as num?)?.toInt() ?? 0,
      reportsCount: (map['reportsCount'] as num?)?.toInt() ?? 0,
      isUrgent: map['isUrgent'] as bool? ?? false,
    );
  }
}

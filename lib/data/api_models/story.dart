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
  final bool isUrgent;
  final List<String> likes;
  final List<String> reports;

  bool isLiked({required String user}) => likes.contains(user);

  bool isReported({required String user}) => reports.contains(user);

  Story({
    required this.id,
    required this.category,
    required this.tag,
    required this.tagColor,
    required this.tagBgColor,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.likes,
    required this.reports,
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
      'likes': likes,
      'reports': reports,
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
      likes:
          (map['likes'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          [],
      reports:
          (map['reports'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      isUrgent: map['isUrgent'] as bool? ?? false,
    );
  }
}

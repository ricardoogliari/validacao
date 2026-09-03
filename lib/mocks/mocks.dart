import 'dart:ui';

import 'package:validacao/data/api_models/story.dart';

final List<Story> mockStories = [
  // Featured Card (Urgent)
  Story(
    id: 'featured-1',
    category: 'Food',
    tag: 'URGENT: FOOD & WATER',
    tagColor: const Color(0xFFDC2626), // Red 600
    tagBgColor: const Color(0xFFFEE2E2), // Red 100
    title: 'Support the Al-Saeed Family Relief',
    description:
        'Displaced by recent floods in the coastal region, the family has lost their primary source of clean water. They urgently require food supplies and filtration kits for 5 children.',
    imageUrl:
        'https://images.unsplash.com/photo-1488521787991-ed7bbaae773c?auto=format&fit=crop&w=800&q=80',
    likesCount: 242,
    isUrgent: true,
  ),
  // Story Card 1
  Story(
    id: 'story-1',
    category: 'Medical',
    tag: 'MEDICAL SUPPORT',
    tagColor: const Color(0xFF3B82F6), // Blue 500
    tagBgColor: const Color(0xFFEFF6FF), // Blue 500 light
    title: 'Healing Old Elias',
    description:
        'Elias needs continuous medication for his chronic respiratory condition which has worsened this winter.',
    imageUrl:
        'https://images.unsplash.com/photo-1581056771107-24ca5f033842?auto=format&fit=crop&w=500&q=80',
    likesCount: 128,
  ),
  // Story Card 2
  Story(
    id: 'story-2',
    category: 'Education',
    tag: 'EDUCATION',
    tagColor: const Color(0xFFA855F7), // Purple 500
    tagBgColor: const Color(0xFFF3E8FF), // Purple 500 light
    title: 'Books for Hope Academy',
    description:
        'Help us provide stationery and textbooks for 30 orphaned students starting their spring semester.',
    imageUrl:
        'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?auto=format&fit=crop&w=500&q=80',
    likesCount: 95,
  ),
  // Story Card 3
  Story(
    id: 'story-3',
    category: 'Clothes',
    tag: 'WINTER CLOTHES',
    tagColor: const Color(0xFFEC4899), // Pink 500
    tagBgColor: const Color(0xFFFCE7F3), // Pink 500 light
    title: 'Warmth for Sara',
    description:
        'Sara\'s family arrived with only summer clothes. They need winter coats and sturdy boots for the coming months.',
    imageUrl:
        'https://images.unsplash.com/photo-1513829096999-49786022943b?auto=format&fit=crop&w=500&q=80',
    likesCount: 167,
  ),
  // Story Card 4
  Story(
    id: 'story-4',
    category: 'Shelter',
    tag: 'SHELTER REPAIR',
    tagColor: const Color(0xFF22C55E), // Green 500
    tagBgColor: const Color(0xFFDCFCE7), // Green 500 light
    title: 'A Roof Over Their Heads',
    description:
        'The Mamba family\'s roof was damaged in a storm. They need materials to make it leak-proof before rains start.',
    imageUrl:
        'https://images.unsplash.com/photo-1504307651254-35680f356dfd?auto=format&fit=crop&w=500&q=80',
    likesCount: 84,
  ),
];

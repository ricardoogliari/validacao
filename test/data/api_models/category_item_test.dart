import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:validacao/data/api_models/category_item.dart';

void main() {
  group('CategoryItem', () {
    test('instantiates with label and icon correctly', () {
      const item = CategoryItem(label: 'Food', icon: Icons.fastfood);

      expect(item.label, 'Food');
      expect(item.icon, Icons.fastfood);
    });

    test('supports const construction', () {
      const item1 = CategoryItem(label: 'Medical', icon: Icons.local_hospital);
      const item2 = CategoryItem(label: 'Medical', icon: Icons.local_hospital);

      expect(identical(item1, item2), isTrue);
    });
  });
}

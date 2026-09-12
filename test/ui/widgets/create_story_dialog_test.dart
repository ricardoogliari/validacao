import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:validacao/data/api_models/story.dart';
import 'package:validacao/ui/widgets/create_story_dialog.dart';
import 'package:validacao/utils/constants.dart';

void main() {
  Widget createTestWidget(Future<bool> Function(Story story) onSubmit) {
    return MaterialApp(
      home: Scaffold(body: CreateStoryDialog(onSubmit: onSubmit)),
    );
  }

  group('CreateStoryDialog', () {
    testWidgets('renders all form fields and submit button', (tester) async {
      tester.view.physicalSize = const Size(1200, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(createTestWidget((story) async => true));

      expect(find.text('Nova História'), findsOneWidget);
      expect(find.text('Título'), findsOneWidget);
      expect(find.text('Categoria'), findsOneWidget);
      expect(find.text('Tag'), findsOneWidget);
      expect(find.text('Descrição'), findsOneWidget);
      expect(find.text('URL da Imagem'), findsOneWidget);
      expect(find.text('Pedido Urgente'), findsOneWidget);
      expect(find.text('Publicar História'), findsOneWidget);
    });

    testWidgets('shows validation errors when submitting empty form', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1200, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(createTestWidget((story) async => true));

      await tester.tap(find.text('Publicar História'));
      await tester.pumpAndSettle();

      expect(find.text('Por favor, informe o título.'), findsOneWidget);
      expect(find.text('Por favor, informe a descrição.'), findsOneWidget);
      expect(
        find.text('Por favor, informe uma URL de imagem.'),
        findsOneWidget,
      );
    });

    testWidgets('submits story with valid input', (tester) async {
      tester.view.physicalSize = const Size(1200, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      Story? submittedStory;

      await tester.pumpWidget(
        createTestWidget((story) async {
          submittedStory = story;
          return true;
        }),
      );

      // Enter Title
      await tester.enterText(
        find.widgetWithText(TextFormField, '').first,
        'Cestas para a Comunidade',
      );

      // Enter Description
      final textFields = find.byType(TextFormField);
      // textFields: 0: Title, 1: Tag, 2: Description, 3: ImageUrl
      await tester.enterText(
        textFields.at(2),
        'Distribuição de 50 cestas básicas.',
      );

      // Enter Image URL
      await tester.enterText(textFields.at(3), 'https://example.com/img.jpg');

      // Toggle Urgent
      await tester.tap(find.byType(SwitchListTile));
      await tester.pumpAndSettle();

      // Submit
      await tester.tap(find.text('Publicar História'));
      await tester.pumpAndSettle();

      expect(submittedStory, isNotNull);
      expect(submittedStory!.title, 'Cestas para a Comunidade');
      expect(submittedStory!.category, food);
      expect(submittedStory!.description, 'Distribuição de 50 cestas básicas.');
      expect(submittedStory!.imageUrl, 'https://example.com/img.jpg');
      expect(submittedStory!.isUrgent, isTrue);
    });
  });
}

// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:project0/main.dart';

void main() {
  testWidgets('My widget is a list of image and titles',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CocktailDetail(
      name: "Margarita",
      instructions: "Lorem ipsum...",
      imageURL:
          "https://www.thecocktaildb.com/images/media/drink/5noda61589575158.jpg",
    ));

    // Verify that our counter starts at 0.
    expect(find.text('Margarita'), findsOneWidget);
    expect(find.text('Lorem ipsum...'), findsOneWidget);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:project0/main.dart';

void main() {
  testWidgets('My widget displays a title, image and instructions',
      (WidgetTester tester) async {
    await mockNetworkImagesFor(
        () async => await tester.pumpWidget(const CocktailDetail(
              name: "Margarita",
              instructions: "Lorem ipsum...",
              imageURL:
                  "https://www.thecocktaildb.com/images/media/drink/5noda61589575158.jpg",
            )));

    expect(find.text('Margarita'), findsOneWidget);
    expect(find.text('Lorem ipsum...'), findsOneWidget);
  });
}

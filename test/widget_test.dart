import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'widget_test.mocks.dart';
import 'package:project0/main.dart';

@GenerateMocks([http.Client])
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

  testWidgets('My list of cocktails is displayed', (widgetTester) async {
    final client = MockClient();

    when(client.get(Uri.parse(
            'https://www.thecocktaildb.com/api/json/v1/1/search.php?f=a')))
        .thenAnswer((_) async => http.Response(
            '{"drinks":[{"idDrink": "11007","strDrink": "Margarita","strInstructions": "Rub the rim of the glass with the lime slice to make the salt stick to it. Take care to moisten only the outer rim and sprinkle the salt on it. The salt should present to the lips of the imbiber and never mix into the cocktail. Shake the other ingredients with ice, then carefully pour into the glass.","strDrinkThumb": "https://www.thecocktaildb.com/images/media/drink/5noda61589575158.jpg"}]}',
            200));

    await widgetTester
        .pumpWidget(MaterialApp(home: Scaffold(body: const CocktailList())));
    await widgetTester.pumpAndSettle();

    expect(find.text('An error occurred'), findsOneWidget);
  });
}

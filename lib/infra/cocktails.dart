import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<Cocktail>> fetchCocktails() async {
  final response = await http.get(
      Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/search.php?f=a'));

  if (response.statusCode == 200) {
    final cocktails = jsonDecode(response.body)['drinks'] as List<dynamic>;

    final adaptedCocktails =
        cocktails.map((cocktail) => Cocktail.fromJson(cocktail)).toList();

    return adaptedCocktails;
  } else {
    throw Exception('Failed to load cocktails');
  }
}

class Cocktail {
  final String id;
  final String name;
  final String imageURL;
  final String instructions;

  const Cocktail(
      {required this.name,
      required this.imageURL,
      required this.id,
      required this.instructions});

  factory Cocktail.fromJson(dynamic json) {
    return Cocktail(
      id: json['idDrink'].toString(),
      name: json['strDrink'].toString(),
      imageURL: json['strDrinkThumb'].toString(),
      instructions: json['strInstructions'].toString(),
    );
  }
}

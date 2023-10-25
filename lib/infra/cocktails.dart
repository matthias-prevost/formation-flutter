import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<Cocktail>> fetchCocktails([String? searchValue]) async {
  http.Response response;
  if (searchValue == null || searchValue.isEmpty) {
    response = await http.get(Uri.parse(
        'https://www.thecocktaildb.com/api/json/v1/1/search.php?f=a'));
  } else {
    response = await http.get(Uri.parse(
        'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=$searchValue'));
  }

  if (response.statusCode == 200 && response.body.isNotEmpty) {
    final data = jsonDecode(response.body)['drinks'];
    if (data == null) return [];

    final cocktails = data as List<dynamic>;

    final adaptedCocktails =
        cocktails.map((cocktail) => Cocktail.fromJson(cocktail)).toList();

    return adaptedCocktails;
  } else {
    throw Exception('Failed to load cocktails');
  }
}

Future<Cocktail> fetchCocktail(String id) async {
  final response = await http.get(Uri.parse(
      'https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=$id'));

  if (response.statusCode == 200 && response.body.isNotEmpty) {
    final data = jsonDecode(response.body)['drinks'][0];
    if (data == null) {
      throw Exception('Failed to load cocktails');
    }

    final cocktail = data as dynamic;

    final adaptedCocktail = Cocktail.fromJson(cocktail);

    return adaptedCocktail;
  } else {
    throw Exception('Failed to load cocktails');
  }
}

Future<List<Cocktail>> getFavorites(List<String> ids) async {
  final cocktails = await Future.wait(ids.map((id) => fetchCocktail(id)));
  return cocktails;
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
      id: json['idDrink'] as String,
      name: json['strDrink'].toString(),
      imageURL: json['strDrinkThumb'].toString(),
      instructions: json['strInstructions'].toString(),
    );
  }
}

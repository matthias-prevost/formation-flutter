import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project0/infra/cocktails.dart';
import 'package:project0/widgets/ListItem.widget.dart';

class CocktailList extends StatefulWidget {
  const CocktailList({super.key});

  @override
  State<CocktailList> createState() => _CocktailListState();
}

class _CocktailListState extends State<CocktailList> {
  late Future<List<Cocktail>> futureCocktails;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    futureCocktails = fetchCocktails();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            onChanged: (value) {
              if (_timer?.isActive ?? false) _timer?.cancel();
              _timer = Timer(const Duration(milliseconds: 500), () {
                setState(() {
                  futureCocktails = fetchCocktails(value);
                });
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Chercher un cocktail',
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder(
              future: futureCocktails,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: const CircularProgressIndicator());
                }
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return Center(child: Text('No cocktails found'));
                  }
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Cocktail cocktail = snapshot.data![index];
                        return ListItem(
                            id: cocktail.id,
                            name: cocktail.name,
                            imageURL: cocktail.imageURL);
                      });
                }
                if (snapshot.hasError) {
                  return Center(child: Text('An error occurred'));
                }
                return Center(child: const CircularProgressIndicator());
              }),
        ),
      ],
    );
  }
}

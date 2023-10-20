import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project0/infra/cocktails.dart';

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
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
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
                          return Container(
                              child: ListTile(
                                title: Text(snapshot.data![index].name),
                                leading: Image.network(
                                    snapshot.data![index].imageURL),
                              ),
                              padding: EdgeInsets.only(top: 12, bottom: 12));
                        });
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('An error occurred'));
                  }
                  return Center(child: const CircularProgressIndicator());
                }),
          ),
        ],
      ),
    );
  }
}

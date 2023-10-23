import 'dart:async';
import 'package:go_router/go_router.dart';
import 'package:flutter/cupertino.dart';
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
    return Column(
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
                        Cocktail cocktail = snapshot.data![index];
                        return Padding(
                          padding: const EdgeInsets.only(
                              bottom: 8.0, left: 16.0, right: 16.0, top: 8.0),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(0)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0)))),
                              onPressed: () {
                                context.go(
                                    Uri(path: '/cocktail', queryParameters: {
                                  'id': cocktail.id,
                                }).toString());
                              },
                              child: ListTile(
                                contentPadding: EdgeInsets.all(0),
                                title: Text(cocktail.name),
                                leading: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        bottomLeft: Radius.circular(4.0)),
                                    child: Image.network(
                                      cocktail.imageURL,
                                    )),
                              )),
                        );
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

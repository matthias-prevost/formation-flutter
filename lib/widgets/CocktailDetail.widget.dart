import 'package:flutter/material.dart';
import 'package:project0/infra/cocktails.dart';

class CocktailDetail extends StatefulWidget {
  const CocktailDetail({super.key, required this.id});

  final String id;

  @override
  State<CocktailDetail> createState() => _CocktailDetailState();
}

class _CocktailDetailState extends State<CocktailDetail> {
  late Future<Cocktail> futureCocktail;

  @override
  void initState() {
    super.initState();
    futureCocktail = fetchCocktail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureCocktail,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(24),
                  child: Text(
                    snapshot.data!.name,
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  )),
              Image.network(
                snapshot.data!.imageURL,
                width: 200,
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  snapshot.data!.instructions,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              )
            ],
          );
        }
        if (snapshot.hasError) {
          return Center(child: Text("Une erreur s'est produite"));
        }
        return Center(child: const CircularProgressIndicator());
      },
    );
  }
}

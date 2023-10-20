import 'package:flutter/material.dart';
import 'package:project0/infra/cocktails.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'La banque des cocktails'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(child: CocktailList()),
    );
  }
}

class CocktailList extends StatefulWidget {
  const CocktailList({super.key});

  @override
  State<CocktailList> createState() => _CocktailListState();
}

class _CocktailListState extends State<CocktailList> {
  late Future<List<Cocktail>> futureCocktails;

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
              onChanged: (value) => setState(() {
                futureCocktails = fetchCocktails(value);
              }),
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

class CocktailDetail extends StatefulWidget {
  const CocktailDetail(
      {super.key,
      required this.name,
      required this.instructions,
      required this.imageURL});

  final String name;
  final String instructions;
  final String imageURL;

  @override
  State<CocktailDetail> createState() => _CocktailDetailState();
}

class _CocktailDetailState extends State<CocktailDetail> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                widget.name,
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              )),
          Image.network(widget.imageURL),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              widget.instructions,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          )
        ],
      ),
    );
  }
}

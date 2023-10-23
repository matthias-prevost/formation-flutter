import 'package:flutter/material.dart';

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
    return Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              widget.name,
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.center,
            )),
        Image.network(
          widget.imageURL,
          width: 200,
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            widget.instructions,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ListItem extends StatelessWidget {
  const ListItem(
      {super.key,
      required this.id,
      required this.name,
      required this.imageURL});

  final String id;
  final String name;
  final String imageURL;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 8.0, left: 16.0, right: 16.0, top: 8.0),
      child: ElevatedButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0)))),
          onPressed: () {
            context.go(Uri(path: '/cocktail', queryParameters: {
              'id': id,
            }).toString());
          },
          child: ListTile(
            contentPadding: EdgeInsets.all(0),
            title: Text(name),
            leading: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    bottomLeft: Radius.circular(4.0)),
                child: Image.network(
                  imageURL,
                )),
          )),
    );
  }
}

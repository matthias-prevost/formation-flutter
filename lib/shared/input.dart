import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({super.key, required this.placeholder, this.onChanged});

  final String placeholder;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: placeholder == "Mot de passe",
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      cursorColor: Colors.orange,
      onChanged: (value) {
        onChanged!(value);
      },
      decoration: InputDecoration(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
          labelText: placeholder,
          labelStyle: TextStyle(color: Colors.white)),
    );
  }
}

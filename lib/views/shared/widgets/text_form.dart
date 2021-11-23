import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  final String labelText;
  final bool isObscured;
  final Function(String) onChanged;

  const TextForm(
      {Key? key,
      required this.labelText,
      required this.onChanged,
      this.isObscured = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      obscureText: isObscured,
      decoration: InputDecoration(
        label: Text(labelText),
        labelStyle: const TextStyle(fontSize: 14, color: Colors.blueAccent),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
  }
}

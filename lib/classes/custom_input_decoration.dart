import 'package:flutter/material.dart';

//Decoration for all text fields in this app.
InputDecoration customInputDecoration(String label, BuildContext context) {
  return InputDecoration(
    labelText: label,
    labelStyle: Theme.of(context).textTheme.body2,
    alignLabelWithHint: true,
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).primaryColorDark,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    counterText:
        "", //Removes the character counter under each text field with a limit
  );
}

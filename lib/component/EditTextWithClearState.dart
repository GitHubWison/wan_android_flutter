import 'package:flutter/material.dart';

class EditTextWithClear extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType inputType;
  final bool obscureText;

  EditTextWithClear(this.controller, this.hint,
      {this.inputType = TextInputType.emailAddress, this.obscureText = false});

  @override
  EditTextWithClearState createState() {
    return EditTextWithClearState();
  }
}

class EditTextWithClearState extends State<EditTextWithClear> {
  bool isClearVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onTextChanged,
//      focusNode: focusNode,
      style: TextStyle(fontSize: 25),
      obscureText: widget.obscureText,
      keyboardType: widget.inputType,
      decoration: InputDecoration(
          suffixIcon: Visibility(
            visible: isClearVisible,
            child: GestureDetector(
              onTap: () {
                widget.controller.clear();
                onTextChanged("");
              },
              child: Icon(Icons.clear),
            ),
          ),
          labelText: widget.hint),
      controller: widget.controller,
    );
  }

  void onTextChanged(String value) {
    setState(() {
      isClearVisible = '' != value;
    });
  }
}

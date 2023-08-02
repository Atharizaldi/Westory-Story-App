import 'package:flutter/material.dart';

class InputTextFieldWidget extends StatefulWidget {
  final TextEditingController textEditingController;
  final String hintText;

  InputTextFieldWidget(this.textEditingController, this.hintText);

  @override
  State<InputTextFieldWidget> createState() => _InputTextFieldWidgetState();
}

class _InputTextFieldWidgetState extends State<InputTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textEditingController,
      decoration: InputDecoration(
        icon: const Icon(Icons.email),
        labelText: widget.hintText,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF6200EE)),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {Key? key,
      this.textDefault,
      required this.labelText,
      this.onChanged,
      this.helperText,
      this.errorText})
      : super(key: key);
  final String? textDefault;
  final String labelText;
  final Function(String)? onChanged;
  final String? helperText;
  final String? errorText;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _textEditingController;
  @override
  void initState() {
    _textEditingController = TextEditingController(text: widget.textDefault);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: TextField(
        controller: _textEditingController,
        cursorColor: Colors.black,
        decoration: InputDecoration(
            errorText: widget.errorText,
            focusColor: Colors.black,
            labelText: widget.labelText,
            helperText: widget.helperText,
            border: _outlineInputBorder(),
            enabledBorder: _outlineInputBorder(),
            focusedBorder: _outlineInputBorder()),
        onChanged: widget.onChanged,
      ),
    );
  }

  OutlineInputBorder _outlineInputBorder() {
    return const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black54));
  }
}

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
    this.textController,
    this.labelText,
    this.hintText,
    this.hideText,
    this.validator, {
    Key? key,
  }) : super(key: key);

  final dynamic validator;
  final bool hideText;
  final String hintText;
  final String labelText;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final IconData icon;
  final int? maxLength;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const InputTextField(
      {required this.hintText,
      required this.labelText,
      required this.icon,
      this.controller,
      this.validator,
      this.maxLength,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      // initialValue: 'initValue',
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        label: Text(labelText),
        prefixIcon: Icon(icon),
        hintText: hintText,
      ),
      maxLength: maxLength,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leo/utils/constants.dart';

class CustomFormInput extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final List<TextInputFormatter> listOfTextInputFormatters;
  final bool isNumber;
  const CustomFormInput({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.listOfTextInputFormatters,
    required this.isNumber,
  });

  @override
  State<CustomFormInput> createState() => _CustomFormInputState();
}

class _CustomFormInputState extends State<CustomFormInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.controller,
          keyboardType:
              widget.isNumber ? TextInputType.number : TextInputType.text,
          textInputAction: TextInputAction.done,
          inputFormatters: widget.listOfTextInputFormatters,
          decoration: InputDecoration(
            hintText: widget.hintText,
            labelText: widget.labelText,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
        const SizedBox(height: defaultPadding),
      ],
    );
  }
}

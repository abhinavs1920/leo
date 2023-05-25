import 'package:flutter/material.dart';
import 'package:leo/utils/constants.dart';

class ChipInput extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final List<String> nameList;
  final Function(String) onFieldSubmitted;
  final Function(String) onDeleted;
  const ChipInput({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.nameList,
    required this.onFieldSubmitted,
    required this.onDeleted,
  });

  @override
  State<ChipInput> createState() => _ChipInputState();
}

class _ChipInputState extends State<ChipInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          onFieldSubmitted: (String value) {
            widget.onFieldSubmitted(value);
          },
          decoration: InputDecoration(
            hintText: widget.hintText,
            labelText: widget.labelText,
          ),
        ),
        const SizedBox(height: defaultPadding),
        Wrap(
          children: widget.nameList.map((String chip) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(
                defaultPadding / 8,
                defaultPadding / 8,
                defaultPadding / 8,
                0,
              ),
              child: Chip(
                label: Text(chip),
                onDeleted: () {
                  widget.onDeleted(chip);
                },
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

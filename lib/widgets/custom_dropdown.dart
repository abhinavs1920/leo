import 'package:flutter/material.dart';
import 'package:leo/utils/constants.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> list;
  final String dropdownValue;
  final Function setDropdownValue;
  const CustomDropdown({
    super.key,
    required this.list,
    required this.setDropdownValue,
    required this.dropdownValue,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton<String>(
          value: widget.dropdownValue,
          icon: const Icon(
            Icons.arrow_drop_down,
          ),
          elevation: 16,
          style: const TextStyle(
            color: primaryColor,
          ),
          onChanged: (String? value) {
            setState(
              () {
                widget.setDropdownValue(value);
              },
            );
          },
          items: widget.list.map<DropdownMenuItem<String>>(
            (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}

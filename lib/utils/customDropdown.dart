import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String hints;
  final List<dynamic> items;
  final String? value;
  final String Function(dynamic)? itemLabel;
  final Function(dynamic)? onChanged;
  final String? Function(dynamic)? validator;
  final EdgeInsetsGeometry padding;
  final double borderRadius;

  const CustomDropdown({
    super.key,
   required this.hints,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
    this.value,
    this.validator,
    this.padding = const EdgeInsets.symmetric(vertical: 8),
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: DropdownButtonFormField(
        value: value,
        decoration: InputDecoration(
       hintText: hints,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
        items:
            items.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(itemLabel!(item)),
                ),
              );
            }).toList(),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}

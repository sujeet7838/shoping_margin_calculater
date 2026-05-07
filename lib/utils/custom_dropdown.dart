import 'package:flutter/material.dart';

class CustomDropdownRow<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> items;
  final Function(T?) onChanged;
  final String hint;

  const CustomDropdownRow({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          /// LABEL
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          /// DROPDOWN
          Expanded(
            child: DropdownButtonFormField<T>(
              isExpanded: true,
              hint: Text(hint),
              value: value,

              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              items: items.map((e) {
                return DropdownMenuItem<T>(
                  value: e,
                  child: Text("$e"),
                );
              }).toList(),

              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
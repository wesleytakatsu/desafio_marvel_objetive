import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const CustomTextField({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 31,
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          isCollapsed: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: const BorderSide(
              color: Color(0xFFD42026),
              width: 1,
            ),
          ),
        ),
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}

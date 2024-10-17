import 'package:flutter/material.dart';

class CustomDropdownInput extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final IconData? icon;
  final Map<String, String> options;

  const CustomDropdownInput({
    super.key,
    required this.label,
    required this.controller,
    this.icon,
    required this.options,
  });

  @override
  _CustomDropdownInputState createState() => _CustomDropdownInputState();
}

class _CustomDropdownInputState extends State<CustomDropdownInput> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: FocusScope(
        onFocusChange: (focus) {
          setState(() {
            _isFocused = focus;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: _isFocused ? Colors.transparent : Color(0xFFFFFFFF),
            boxShadow: [
              BoxShadow(
                offset: Offset(4, 4),
                blurRadius: 4,
                color: _isFocused ? Colors.transparent : Color(0xFF1CFFFF),
              ),
            ],
            borderRadius: BorderRadius.circular(30),
          ),
          child: DropdownButtonFormField<String>(
            value: widget.controller.text.isNotEmpty ? widget.controller.text : null,
            items: widget.options.entries
                .map((entry) => DropdownMenuItem(
                      value: entry.key,
                      child: Text(entry.value), // Display text
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                widget.controller.text = value!; // Stores the value
              });
            },
            decoration: InputDecoration(
              labelText: widget.label,
              labelStyle: const TextStyle(color: Color(0xFF000000)),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(30.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFF1CFFFF)),
                borderRadius: BorderRadius.circular(30.0),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              prefixIcon: widget.icon != null ? Icon(widget.icon, color: Color(0xFF000000)) : null,
            ),
            iconEnabledColor: Color(0xFF000000),
            dropdownColor: Color(0xFFFFFFFF),
          ),
        ),
      ),
    );
  }
}

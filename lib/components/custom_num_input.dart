import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomNumberInput extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final IconData? icon;

  const CustomNumberInput({
    super.key,
    required this.label,
    required this.controller,
    this.icon,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomNumberInputState createState() => _CustomNumberInputState();
}

class _CustomNumberInputState extends State<CustomNumberInput> {
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
            color: _isFocused ? Colors.transparent : const Color(0xFFFFFFFF),
            boxShadow: [
              BoxShadow(
                offset: const Offset(4, 4),
                blurRadius: 4,
                color: _isFocused ? Colors.transparent : const Color(0xFF1CFFFF),
              ),
            ],
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextFormField(
            controller: widget.controller,
            style: const TextStyle(color: Color(0xFF000000)),
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
              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              prefixIcon: widget.icon != null ? Icon(widget.icon, color: const Color(0xFF000000)) : null,
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),
      ),
    );
  }
}

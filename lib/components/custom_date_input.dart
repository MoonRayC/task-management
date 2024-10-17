import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateInput extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final IconData? icon;

  const CustomDateInput({
    super.key,
    required this.label,
    required this.controller,
    this.icon,
  });

  @override
  _CustomDateInputState createState() => _CustomDateInputState();
}

class _CustomDateInputState extends State<CustomDateInput> {
  bool _isFocused = false;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      widget.controller.text = formattedDate;
    }
  }

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
        child: GestureDetector(
          onTap: () => _selectDate(context),
          child: AbsorbPointer(
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
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  prefixIcon: widget.icon != null ? Icon(widget.icon, color: Color(0xFF000000)) : null,
                ),
                keyboardType: TextInputType.datetime,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

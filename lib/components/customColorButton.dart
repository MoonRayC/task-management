import 'package:flutter/material.dart';

class CustomColorButton extends StatelessWidget {
  final double width;
  final double height;
  final Icon icon;
  final VoidCallback onPressed;
  final double fontSize;
  final FontWeight fontWeight;
  final Color startColor;
  final Color endColor;

  const CustomColorButton({
    super.key,
    required this.width,
    required this.height,
    required this.icon,
    required this.onPressed,
    required this.fontSize,
    required this.fontWeight,
    required this.startColor,
    required this.endColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            startColor,
            endColor,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Color(0xFFFFFFFF), width: 1.5),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero, // Removes padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: onPressed,
        child: Center(
          child: FittedBox(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(
                icon: icon, 
                onPressed: onPressed,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

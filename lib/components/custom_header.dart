// task_list_header.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomHeader extends StatelessWidget {
  final String title;

  const CustomHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            fontFamily: GoogleFonts.cabin().fontFamily,
          ),
        ),
        SizedBox(width: 10),
        SvgPicture.asset('assets/images/vector1.svg'),
      ],
    );
  }
}
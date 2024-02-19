import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pretest/presentation/constants/color_constant.dart';

class StyleConstant {
  static final titleStyle = GoogleFonts.poppins(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: blue,
  );

  static final subTitleStyle = GoogleFonts.raleway(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static final bodyBoldStyle = GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const buttonStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const textButtonStyle = TextStyle(
    decoration: TextDecoration.underline,
    decorationColor: lighterBlue,
    decorationThickness: 2,
    color: lighterBlue,
  );
}

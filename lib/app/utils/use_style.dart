import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle useStyle(TextStyle style) {
  return GoogleFonts.getFont(
    'Poppins',
    textStyle: style,
  );
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextLogo extends StatelessWidget {
  final double logoSize;

  const TextLogo({
    Key key,
    this.logoSize = 15,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'TribeSeed',
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        fontSize: logoSize,
      ),
    );
  }
}

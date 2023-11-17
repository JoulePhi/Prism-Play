import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:another_flushbar/flushbar.dart';

const bg = Color(0xff15141f);
const gray = Color(0xffBCBCBC);
const lightGray = Color(0xff201f29);
final hint = const Color(0xffBBBBBB).withOpacity(.5);
const lightOrange = Color(0xffFF8F71);
const darkOrange = Color(0xffEF2D1A);

final whiteText = GoogleFonts.lato(color: Colors.white);
final orangeText = GoogleFonts.lato(color: lightOrange);
final grayText = GoogleFonts.lato(color: gray);
final hintText = GoogleFonts.lato(color: hint);

flushbar(BuildContext context, String msg) {
  return Flushbar(
    title: 'Error',
    message: msg,
    duration: const Duration(seconds: 1),
    backgroundColor: darkOrange,
  )..show(context);
}

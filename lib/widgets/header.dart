// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar header(context,
    {bool isAppTitle = false,
    required String titleText,
    removeBackButton = false}) {

  return AppBar(
      automaticallyImplyLeading: removeBackButton ? false : true,
      //false for removing back button

      title: Text(
        isAppTitle ? "PicShare" : titleText,
        style: GoogleFonts.dancingScript(
          fontSize: isAppTitle ? 30 : 25,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      centerTitle: true,
      flexibleSpace: Container(
      decoration: BoxDecoration(
       gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: const [Colors.cyan, Colors.indigo],
        ),
      ),
      ),
    
  );
}

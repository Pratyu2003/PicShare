// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

circularProgress() {
  return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 10),
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Color.fromARGB(255, 255, 230, 0)),
      ));
}

linearProgress() {
  return Container(
    padding: EdgeInsets.only(bottom: 10),
    child: LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.redAccent),
    ),
  );
}

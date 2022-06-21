import "package:flutter/material.dart";

const textInputDecoration = InputDecoration(
  fillColor: Color.fromARGB(255, 22, 22, 22),
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black)
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color.fromARGB(255, 35, 14, 126)),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red)
  )
);

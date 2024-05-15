import 'package:festi_planner/screen/Homepage.dart';
import 'package:festi_planner/screen/details.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomePage(),
        'details': (context) => const DetailPage(),
      },
    ),
  );
}

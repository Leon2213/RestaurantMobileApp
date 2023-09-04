import 'package:flutter/material.dart';
import 'package:pvt_v1/main.dart';
import 'package:pvt_v1/screens/custom_marker_info_window.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CustomMarkerInfoWindow(),
    );
  }
}
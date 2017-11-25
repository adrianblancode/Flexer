import 'package:Flexer/flex/flex_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new FlexerApp());
}

class FlexerApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flexer',
      theme: new ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.white,
      ),
      home: new FlexView(),
    );
  }
}
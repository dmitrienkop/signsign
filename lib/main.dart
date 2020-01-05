import 'package:flutter/material.dart';
import './main_screen.dart';

void main() => runApp(SignSign());

class SignSign extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
    MaterialApp(
      key: Key('1234'),
      title: 'SignSign',
      home: MainScreen(),
    );
}

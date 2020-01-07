import 'package:flutter/material.dart';
import 'package:signsign/screens/map_screen.dart';

void main() => runApp(SignSign());

class SignSign extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
    MaterialApp(
      key: Key('1'),
      title: 'SignSign',
      home: MapScreen(),
    );
}

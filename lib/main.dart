import 'package:flutter/material.dart';
import 'package:signsign/components/signsign_constants.dart';
import 'package:signsign/screens/map_screen.dart';

void main() => runApp(SignSign());

class SignSign extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
    SignSignConstants(
      child: MaterialApp(
        key: Key('222'),
        title: 'SignSign',
        home: MapScreen(),
      ),
    );
}

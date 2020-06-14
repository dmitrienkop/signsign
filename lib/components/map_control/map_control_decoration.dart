import 'package:flutter/material.dart';
import 'package:signsign/components/signsign_constants.dart';

class MapControlDecoration extends StatelessWidget {
  final Widget mapControl;

  MapControlDecoration({
    this.mapControl
  });

  // @override
  Widget build(BuildContext context) {
    final constants = SignSignConstants.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(constants.elementBorderRadius)
        ),
        boxShadow: [BoxShadow(
          blurRadius: 8.0,
          color: Color.fromRGBO(0, 0, 0, 0.17),
          offset: Offset(1, 1),
        )],
        color: Colors.white,
      ),
      child: mapControl,
    );
  }
}

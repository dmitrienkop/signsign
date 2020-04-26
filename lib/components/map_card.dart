import 'package:flutter/material.dart';

class MapCard extends StatelessWidget {
  final List<Widget> children;
  
  MapCard({ this.children });
  
  // @override
  Widget build(BuildContext context) =>
    IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
}

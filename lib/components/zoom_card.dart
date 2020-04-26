import 'package:flutter/material.dart';
import 'package:signsign/components/map_card.dart';

const zoomSnapBarText = 'Для отображения дорожных знаков выберите более крупный масштаб';

class ZoomCard extends StatelessWidget {
  // @override
  Widget build(BuildContext context) =>
    MapCard(
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Text(zoomSnapBarText),
          ),
        ),
      ],
    );
}

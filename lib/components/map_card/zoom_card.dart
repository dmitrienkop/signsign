import 'package:flutter/material.dart';
import 'package:signsign/components/map_card/map_card.dart';
import 'package:signsign/components/signsign_constants.dart';

const zoomSnapBarText = 'Для отображения дорожных знаков выберите более крупный масштаб';

class ZoomCard extends StatelessWidget {
  // @override
  Widget build(BuildContext context) {
    final constants = SignSignConstants.of(context);
    return MapCard(
      children: [
        Flexible(
          child: Container(
            height: constants.zoomCardHeight,
            padding: EdgeInsets.all(constants.cardPadding),
            child: Text(zoomSnapBarText),
          ),
        ),
      ],
    );
  }
}

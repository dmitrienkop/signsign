import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
            decoration: BoxDecoration(
              color: Color.fromRGBO(52, 52, 52, 1),
            ),
            height: constants.zoomCardHeight,
            padding: EdgeInsets.all(constants.cardPadding),
            child: Row(
              children: <Widget>[
                Flexible(
                  flex: 0,
                  child: Container(
                    margin: EdgeInsets.only(right: 16.0),
                    child: SvgPicture.asset(
                      'assets/controls/exclamation.svg',
                      height: 20.0,
                      width: 20.0,
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    child: Text(
                      zoomSnapBarText,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

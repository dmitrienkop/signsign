import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:signsign/components/signsign_constants.dart';
import 'package:signsign/models/sign.dart';
import 'package:signsign/components/map_card/map_card.dart';

class SignCard extends StatelessWidget {
  final Sign signMarkerModel;

  SignCard({ this.signMarkerModel });
  
  // @override
  Widget build(BuildContext context) {
    final constants = SignSignConstants.of(context);
    return MapCard(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(constants.cardPadding),
          child: SvgPicture.asset(
            'assets/signs/${signMarkerModel.css}.svg',
            width: 100,
            height: 100,
          ),
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.only(
              top: constants.cardPadding,
              right: constants.cardPadding,
              bottom: constants.cardPadding,
              left: 2.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${signMarkerModel.code} «${signMarkerModel.title}»',
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
                Expanded(
                  child: Html(
                    data: signMarkerModel.description
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

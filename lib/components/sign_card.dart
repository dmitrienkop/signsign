import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:signsign/models/sign.dart';
import 'package:signsign/components/map_card.dart';

class SignCard extends StatelessWidget {
  final Sign signMarkerModel;

  SignCard({ this.signMarkerModel });
  
  // @override
  Widget build(BuildContext context) =>
    MapCard(
      children: <Widget>[
        SvgPicture.asset(
          'assets/signs/${signMarkerModel.code}.svg',
          width: 100,
          height: 100,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                signMarkerModel.title,
                softWrap: true,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500
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
      ],
    );
}

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:signsign/markers/sign_marker.dart';

class SignCard extends StatelessWidget {
  final SignModel signMarkerModel;

  SignCard(this.signMarkerModel);
  
  // @override
  Widget build(BuildContext context) =>
    IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                ]
              ),
            ),
          ],
        ),
      );
}

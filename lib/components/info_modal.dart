import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:signsign/components/signsign_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoModal extends StatelessWidget {
  final bool isVisible;
  final Function onClose;

  InfoModal({
    this.isVisible,
    this.onClose,
  });

  // @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final constants = SignSignConstants.of(context);
    return Visibility(
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
            child: GestureDetector(
              onTap: onClose,
              child: Container(
                color: Color.fromRGBO(255, 255, 255, 0.45),
              ),
            ),
          ),
          Positioned(
            top: mediaQuery.size.height / 2 - (constants.infoModalHeight / 2),
            left: constants.screenEdgeOffset,
            child: Container(
              width: mediaQuery.size.width - (constants.screenEdgeOffset * 2),
              height: constants.infoModalHeight,
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(constants.elementBorderRadius)
                ),
                boxShadow: [BoxShadow(
                  blurRadius: 14.0,
                  color: Color.fromRGBO(0, 0, 0, 0.19),
                  offset: Offset(1, 1),
                )],
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 4.0,
                    right: 0,
                    child: GestureDetector(
                      onTap: onClose,
                      child: SvgPicture.asset(
                        'assets/controls/close.svg',
                        width: 16.0,
                        height: 16.0,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                          bottom: 15.0,
                        ),
                        padding: EdgeInsets.only(
                          right: 16.0 * 2,
                        ),
                        child: Text(
                          'Информация о приложении',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                            letterSpacing: -0.5
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: 15.0,
                        ),
                        child: Text('Прежде всего это карта дорожных знаков Российской Федерации и соседних государств.'),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: 15.0,
                        ),
                        child: Text('Данный проект может быть интересен как начинающим, так и опытным автолюбителям, а также туристам, путешествующим на автомобиле или автостопом, водителям большегрузов…'),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            new TextSpan(
                              text: 'Добавляйте знаки на ',
                              style: new TextStyle(color: Colors.black),
                            ),
                            new TextSpan(
                              text: 'signsign.ru',
                              style: new TextStyle(color: Colors.blue),
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () =>
                                  launch('https://signsign.ru'),
                            ),
                          ]
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      visible: isVisible,
    );
  }
}

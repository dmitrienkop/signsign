import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  _mapListener() {
    print('_mapListener 12334234234');
  }

  @override
  Widget build(BuildContext context) {
    YandexMapController controller;
    
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) =>
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: YandexMap(
                    key: Key('11111'),
                    onMapCreated: (YandexMapController yandexMapController) async {
                      controller = yandexMapController;

                      await controller.move(
                        point: Point(
                          latitude: 55.030163,
                          longitude: 82.925245,
                        ),
                        zoom: 16,
                      );

                      controller.addListener(_mapListener);

                      Scaffold.of(context).hideCurrentSnackBar(); // TODO rm debug
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Для отображения дорожных знаков выберите более крупный масштаб'),
                          duration: Duration(days: 1),
                        )
                      );
                    },
                  ),
                ),
              ],
            )
          )
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import './api/signsign.dart';
import './geo/crs.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final mapboxId = 'mapbox.streets';
  final mapboxToken = 'pk.eyJ1IjoiZG1pdHJpZW5rb3AiLCJhIjoiY2s1MHZvNWR6MDZrZjNzbXJkaHFkNTB4YSJ9.SHarKiCoS7pZLswCo52ACQ';
  final tilesUrlTemplate = 'http://vec{s}.maps.yandex.net/tiles?l=map&v=4.55.2&z={z}&x={x}&y={y}&scale=2&lang=ru_RU';
  MapController _mapController;
  double _zoom = 17.0;
  LatLng _center = LatLng(55.030938, 82.923751);
  SignSignApi _api;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _api = new SignSignApi();
  }

  _mapChangeHandler(MapPosition position, bool hasGesture) {
    _centerChangeHandler(position.center, position.bounds);
    _zoomChangeHandler(position.zoom);
  }

  _centerChangeHandler(LatLng newCenter, LatLngBounds newBounds) async {
    // print('_centerChangeHandler: ' + newBounds.northWest.toString() + ' / ' + newBounds.southEast.toString());
    // print('bounds: ' + newBounds.isValid.toString() + ' / ' + newBounds.);
    final res = await _api.get(newBounds);
    print('1res: ' + res.toString());
    // TODO signs request
  }

  _zoomChangeHandler(double newZoom) {
    print('_zoomChangeHandler: ' + newZoom.toString());

    // TODO show/hide zoom snackbar
  }

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      body: Builder(
        builder: (BuildContext context) =>
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: FlutterMap(
                    key: Key('123'), // TODO rm debug key
                    options: MapOptions(
                      center: _center,
                      zoom: _zoom,
                      crs: Epsg3395(),
                      onPositionChanged: _mapChangeHandler
                    ),
                    layers: [
                      TileLayerOptions(
                        urlTemplate: tilesUrlTemplate,
                      )
                    ],
                  ),
                ),
              ],
            )
          )
      ),
    );
  }

//     Scaffold.of(context).hideCurrentSnackBar(); // TODO rm debug
//     Scaffold.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Для отображения дорожных знаков выберите более крупный масштаб'),
//         duration: Duration(days: 1),
//       )
//     );
//   },
// ),

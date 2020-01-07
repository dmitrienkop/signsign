import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:throttling/throttling.dart';
import 'package:signsign/api/signsign.dart';
import 'package:signsign/widgets/sign.dart';
import 'package:signsign/geo/crs.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const _tilesUrlTemplate = 'http://vec{s}.maps.yandex.net/tiles?l=map&v=4.55.2&z={z}&x={x}&y={y}&scale=2&lang=ru_RU';
  static const _requestDebounceTimeoutMs = 600;

  final _requestDebounce = new Debouncing(duration: Duration(milliseconds: _requestDebounceTimeoutMs));
  double _zoom = 17.0;
  LatLng _center = LatLng(55.021516, 82.917521);
  SignSignApi _api;
  List<Sign> _signsList = [];

  @override
  void initState() {
    super.initState();
    _api = new SignSignApi();
  }

  _mapChangeHandler(MapPosition position, bool hasGesture) {
    _centerChangeHandler(position.center, position.bounds);
    _zoomChangeHandler(position.zoom);
  }

  _centerChangeHandler(LatLng newCenter, LatLngBounds newBounds) async {
    _center = newCenter;
    _requestDebounce.debounce(() => _updateSignsList(newBounds));
  }

  _updateSignsList(LatLngBounds newBounds) async {
    final newSignsList = await _api.get(newBounds);
    setState(() {
      _signsList = newSignsList;
    });
  }

  _zoomChangeHandler(double newZoom) {
    _zoom = newZoom;
    // TODO show/hide zoom snackbar
  }

  @override
  Widget build(BuildContext context) {
    final markers = _signsList.map((sign) => sign.toMarker()).toList();
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) =>
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: FlutterMap(
                    key: Key('1234'), // TODO rm debug key
                    options: MapOptions(
                      center: _center,
                      zoom: _zoom,
                      crs: Epsg3395(),
                      onPositionChanged: _mapChangeHandler
                    ),
                    layers: [
                      TileLayerOptions(
                        urlTemplate: _tilesUrlTemplate,
                      ),
                      MarkerLayerOptions(
                        markers: markers
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

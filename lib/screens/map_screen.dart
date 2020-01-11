import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:throttling/throttling.dart';
import 'package:signsign/api/signsign.dart';
import 'package:signsign/geo/crs.dart';
import 'package:signsign/helpers/location.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const zoomSnapBarText = 'Для отображения дорожных знаков выберите более крупный масштаб';
  static const _tilesUrlTemplate = 'http://vec{s}.maps.yandex.net/tiles?l=map&v=4.55.2&z={z}&x={x}&y={y}&scale=2&lang=ru_RU';
  static const _requestDebounceTimeoutMs = 600;

  final _requestDebounce = new Debouncing(duration: Duration(milliseconds: _requestDebounceTimeoutMs));
  final _minZoom = 5.0;
  final _maxZoom = 19.0;
  final _minVisibleSignsZoom = 17.0;
  double _zoom = 15.0;
  LatLng _center = LatLng(55.021516, 82.917521);
  SignSignApi _api;
  List<Marker> _markersList = [];
  BuildContext _buildContext;
  SnackBar _zoomSnackBar = SnackBar(
    content: Text(zoomSnapBarText),
    duration: Duration(days: 1),
  );
  bool _isShownZoomSnackBar = false;
  MapController _mapController;

  @override
  void initState() {
    super.initState();
    _api = new SignSignApi();
    _mapController = MapController();
    _moveToCurrentLocation(); // TODO restore previous state if available
  }

  _moveToCurrentLocation() async {
    final location = await getCurrentLocation();
    if (location != null) {
      _mapController.move(LatLng(location.latitude, location.longitude), _zoom);
    }
  }

  _mapChangeHandler(MapPosition position, bool hasGesture) {
    _centerChangeHandler(position.center);
    _zoomChangeHandler(position.zoom);
    _optionallyUpdateSignsList(position.zoom, position.bounds);
  }

  _optionallyUpdateSignsList(double zoom, LatLngBounds bounds) {
    if (zoom >= _minVisibleSignsZoom) {
      _requestDebounce.debounce(() async {
        final signsList = await _api.get(bounds);
        _safelySetStateWith(() {
          _markersList = signsList.map((sign) => sign.toMarker()).toList();
        });
      });
    }
  }

  _centerChangeHandler(LatLng center) {
    _center = center;
  }

  _zoomChangeHandler(double zoom) {
    _zoom = zoom;
    
    final isNeedToHideSigns = _zoom < _minVisibleSignsZoom;
    if (isNeedToHideSigns) {
      _safelySetStateWith(() {
        _markersList = [];
      });
    }
    _toggleZoomSnackBar(isNeedToHideSigns);
  }

  _toggleZoomSnackBar(bool isSignsAreHidden) {
    final isNeedToShow = isSignsAreHidden && !_isShownZoomSnackBar;
    if (isNeedToShow) {
      _safelySetStateWith(() {
        Scaffold.of(_buildContext).showSnackBar(_zoomSnackBar);
        _isShownZoomSnackBar = true;
      });
    }

    final isNeedToHide = !isSignsAreHidden && _isShownZoomSnackBar;
    if (isNeedToHide) {
      _safelySetStateWith(() {
        Scaffold.of(_buildContext).hideCurrentSnackBar();
        _isShownZoomSnackBar = false;
      });
    }
  }

  _safelySetStateWith(Function cb) =>
    SchedulerBinding.instance.addPostFrameCallback((_) => setState(cb));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          _buildContext = context;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      center: _center,
                      zoom: _zoom,
                      crs: Epsg3395(),
                      onPositionChanged: _mapChangeHandler,
                      minZoom: _minZoom,
                      maxZoom: _maxZoom,
                    ),
                    layers: [
                      TileLayerOptions(
                        urlTemplate: _tilesUrlTemplate,
                      ),
                      MarkerLayerOptions(
                        markers: _markersList,
                      ),
                    ],
                  ),
                ),
              ],
            )
          );
        }
      ),
    );
  }
}

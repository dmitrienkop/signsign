import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:signsign/markers/sign_marker.dart';
import 'package:signsign/markers/sign_markers_manager.dart';
import 'package:signsign/widgets/sign_card.dart';
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
  LatLng _center = LatLng(56.454658, 84.976087);
  LatLngBounds _bounds;
  SignSignApi _api;
  BuildContext _buildContext;
  SnackBar _zoomSnackBar = SnackBar(
    content: Text(
      zoomSnapBarText,
      style: TextStyle(
        color: Colors.black
      ),
    ),
    duration: Duration(days: 1),
    backgroundColor: Colors.white
  );
  bool _isShownZoomSnackBar = false;
  MapController _mapController;
  SignMarkersManager _markersManager;
  SignModel _activeSignModel;

  @override
  void initState() {
    super.initState();
    _api = new SignSignApi();
    _mapController = MapController();
    _markersManager = SignMarkersManager(_markerTapHandler);
    _moveToCurrentLocation();
  }

  _markerTapHandler(SignModel markerModel) =>
    _toggleSignCard(markerModel);

  _toggleSignCard([SignModel markerModel]) =>
      setState(() {
        _activeSignModel = markerModel;
      });

  _moveToCurrentLocation() async {
    final location = await getCurrentLocation();
    if (location != null) {
      _mapController.move(LatLng(location.latitude, location.longitude), _zoom);
    }
  }

  _mapChangeHandler(MapPosition position, bool hasGesture) {
    _center = position.center;
    _zoom = position.zoom;
    _bounds = position.bounds;

    _zoomChangeHandler();
    _optionallyUpdateSignsList();
  }

  _mapTapHandler(LatLng point) {
    if (_activeSignModel != null) {
      _toggleSignCard();
    }
  }

  _optionallyUpdateSignsList() {
    if (_zoom >= _minVisibleSignsZoom) {
      _requestDebounce.debounce(() async {
        final markersAPIResponse = await _api.get(_bounds);
        setState(() {
          _markersManager.updateFromAPIResponse(markersAPIResponse);
        });
      });
    }
  }

  _zoomChangeHandler() {
    final isNeedToHideSigns = _zoom < _minVisibleSignsZoom;

    if (isNeedToHideSigns) {
      if (_isShownZoomSnackBar) {
        _toggleSignCard();
      }

      if (!_markersManager.isEmpty()) {
        setState(() {
          _markersManager.clean();
        });
      }
    }

    _toggleZoomSnackBar(isNeedToHideSigns);
  }

  _toggleZoomSnackBar(bool isSignsAreHidden) {
    final isNeedToShow = isSignsAreHidden && !_isShownZoomSnackBar;
    if (isNeedToShow) {
      _isShownZoomSnackBar = true;
      _safelySetStateWith(() {
        Scaffold.of(_buildContext).showSnackBar(_zoomSnackBar);
      });
    }

    final isNeedToHide = !isSignsAreHidden && _isShownZoomSnackBar;
    if (isNeedToHide) {
      _isShownZoomSnackBar = false;
      setState(() {
        Scaffold.of(_buildContext).hideCurrentSnackBar();
      });
    }
  }

  _safelySetStateWith(Function cb) =>
    SchedulerBinding.instance.addPostFrameCallback((_) => setState(cb));
    
  @override
  Widget build(BuildContext context) =>
    Scaffold(
      body: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            _buildContext = context;
            double height = MediaQuery.of(context).size.height;

            return Column(
              children: <Widget>[
                Expanded(
                  child: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      center: _center,
                      zoom: _zoom,
                      crs: Epsg3395(),
                      onPositionChanged: _mapChangeHandler,
                      onTap: _mapTapHandler,
                      minZoom: _minZoom,
                      maxZoom: _maxZoom,
                    ),
                    layers: [
                      TileLayerOptions(
                        urlTemplate: _tilesUrlTemplate,
                      ),
                      MarkerLayerOptions(
                        markers: _markersManager.getMarkersList(),
                      ),
                    ],
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: height / 3,
                  ),
                  child: SingleChildScrollView(
                    child: _activeSignModel == null
                      ? null
                      : SignCard(_activeSignModel),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
}

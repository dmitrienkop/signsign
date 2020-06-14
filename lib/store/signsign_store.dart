import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:mobx/mobx.dart';
import 'package:signsign/helpers/location.dart';
import 'package:signsign/models/sign.dart';
import 'package:signsign/services/signsignapi.dart';
import 'package:throttling/throttling.dart';

part 'signsign_store.g.dart';

const minVisibleSignsZoom = 17.0;
const requestDebounceTimeoutMs = 150;
final requestDebounce = new Debouncing(duration: Duration(milliseconds: requestDebounceTimeoutMs));

class SignSignStore = _SignSignStore with _$SignSignStore;

abstract class _SignSignStore with Store {
  bool initialLocationWasSet = false;
  bool initialPositionSetWasHandled = false;

  Location location = new Location();

  @observable
  MapController mapController = MapController();

  @observable
  LatLng center = LatLng(56.454658, 84.976087);

  @observable
  double zoom = 15.0;

  @observable
  LatLngBounds bounds;

  @observable
  bool isNeedToShowZoomCard = false;

  @observable
  List<Marker> markers = [];

  @observable
  Sign activeSign;

  @observable
  bool hasLocationPermission = false;

  @observable
  bool showInfoModal = false;

  @action
  toggleInfoModalVisibility() {
    showInfoModal = !showInfoModal;
  }

  @action
  moveMapToCurrentLocation([TickerProvider tickerProvider]) async {
    final currentLocation = await location.getLocation();
    hasLocationPermission = await location.hasPermission();
    if (currentLocation == null) {
      return false;
    }

    final newCenter = LatLng(currentLocation.latitude, currentLocation.longitude);
    if (tickerProvider == null) {
      mapController.move(newCenter, zoom);
    } else {
      animatedMapMove(newCenter, zoom, tickerProvider);
    }
    center = newCenter;
  }

  @action
  handleMapChange(MapPosition position, bool hasGesture) {
    if (!initialLocationWasSet) {
      initialLocationWasSet = true;
      return mapController.onReady
        .then((_) => moveMapToCurrentLocation());
    }

    if (!hasGesture && !initialPositionSetWasHandled) {
      initialPositionSetWasHandled = true;
      return false;
    }

    center = position.center;
    zoom = position.zoom;
    bounds = position.bounds;

    actualizeSignsState();
  }

  @action animatedMapMove(LatLng newCenter, double newZoom, TickerProvider tickerProvider) {
    final newNormZoom = newZoom.roundToDouble();
    final latTween = Tween(begin: center.latitude, end: newCenter.latitude);
    final lonTween = Tween(begin: center.longitude, end: newCenter.longitude);
    final zoomTween = Tween(begin: zoom, end: newNormZoom);
    final animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: tickerProvider
    );
    zoom = newNormZoom;
    Animation<double> animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.linear,
    );
    animationController.addListener(() {
      mapController.move(
        LatLng(latTween.evaluate(animation), lonTween.evaluate(animation)),
        zoomTween.evaluate(animation),
      );
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.dispose();
      } else if (status == AnimationStatus.dismissed) {
        animationController.dispose();
      }
    });
    animationController.forward();
  }

  @action
  actualizeSignsState() {
    final showSigns = zoom >= minVisibleSignsZoom;
    isNeedToShowZoomCard = !showSigns;
    activeSign = showSigns ? activeSign : null;

    actualizeMarkersList(showSigns, bounds);
  }

  @action
  actualizeMarkersList(bool showSigns, LatLngBounds bounds) {
    if (!showSigns) {
      return markers.clear();
    }

    requestDebounce.debounce(() async {
      final signsListResponse = await getSignsList(bounds);
      final parsedResponse = json.decode(signsListResponse);
      if (!isNeedToShowZoomCard) {
        // zoom may already change at this moment
        markers = parsedResponse['result']
          .map<Marker>((json) =>
            Sign
              .fromJSON(json)
              .toMarker((sign) {
                activeSign = sign;
              })
          )
          .toList();
      }
    });
  }

  @action
  handleMapTap(LatLng point) {
    activeSign = null;
  }
}

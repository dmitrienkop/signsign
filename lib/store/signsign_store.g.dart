// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signsign_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignSignStore on _SignSignStore, Store {
  final _$mapControllerAtom = Atom(name: '_SignSignStore.mapController');

  @override
  MapController get mapController {
    _$mapControllerAtom.context.enforceReadPolicy(_$mapControllerAtom);
    _$mapControllerAtom.reportObserved();
    return super.mapController;
  }

  @override
  set mapController(MapController value) {
    _$mapControllerAtom.context.conditionallyRunInAction(() {
      super.mapController = value;
      _$mapControllerAtom.reportChanged();
    }, _$mapControllerAtom, name: '${_$mapControllerAtom.name}_set');
  }

  final _$centerAtom = Atom(name: '_SignSignStore.center');

  @override
  LatLng get center {
    _$centerAtom.context.enforceReadPolicy(_$centerAtom);
    _$centerAtom.reportObserved();
    return super.center;
  }

  @override
  set center(LatLng value) {
    _$centerAtom.context.conditionallyRunInAction(() {
      super.center = value;
      _$centerAtom.reportChanged();
    }, _$centerAtom, name: '${_$centerAtom.name}_set');
  }

  final _$zoomAtom = Atom(name: '_SignSignStore.zoom');

  @override
  double get zoom {
    _$zoomAtom.context.enforceReadPolicy(_$zoomAtom);
    _$zoomAtom.reportObserved();
    return super.zoom;
  }

  @override
  set zoom(double value) {
    _$zoomAtom.context.conditionallyRunInAction(() {
      super.zoom = value;
      _$zoomAtom.reportChanged();
    }, _$zoomAtom, name: '${_$zoomAtom.name}_set');
  }

  final _$boundsAtom = Atom(name: '_SignSignStore.bounds');

  @override
  LatLngBounds get bounds {
    _$boundsAtom.context.enforceReadPolicy(_$boundsAtom);
    _$boundsAtom.reportObserved();
    return super.bounds;
  }

  @override
  set bounds(LatLngBounds value) {
    _$boundsAtom.context.conditionallyRunInAction(() {
      super.bounds = value;
      _$boundsAtom.reportChanged();
    }, _$boundsAtom, name: '${_$boundsAtom.name}_set');
  }

  final _$isNeedToShowZoomCardAtom =
      Atom(name: '_SignSignStore.isNeedToShowZoomCard');

  @override
  bool get isNeedToShowZoomCard {
    _$isNeedToShowZoomCardAtom.context
        .enforceReadPolicy(_$isNeedToShowZoomCardAtom);
    _$isNeedToShowZoomCardAtom.reportObserved();
    return super.isNeedToShowZoomCard;
  }

  @override
  set isNeedToShowZoomCard(bool value) {
    _$isNeedToShowZoomCardAtom.context.conditionallyRunInAction(() {
      super.isNeedToShowZoomCard = value;
      _$isNeedToShowZoomCardAtom.reportChanged();
    }, _$isNeedToShowZoomCardAtom,
        name: '${_$isNeedToShowZoomCardAtom.name}_set');
  }

  final _$markersAtom = Atom(name: '_SignSignStore.markers');

  @override
  List<Marker> get markers {
    _$markersAtom.context.enforceReadPolicy(_$markersAtom);
    _$markersAtom.reportObserved();
    return super.markers;
  }

  @override
  set markers(List<Marker> value) {
    _$markersAtom.context.conditionallyRunInAction(() {
      super.markers = value;
      _$markersAtom.reportChanged();
    }, _$markersAtom, name: '${_$markersAtom.name}_set');
  }

  final _$activeSignAtom = Atom(name: '_SignSignStore.activeSign');

  @override
  Sign get activeSign {
    _$activeSignAtom.context.enforceReadPolicy(_$activeSignAtom);
    _$activeSignAtom.reportObserved();
    return super.activeSign;
  }

  @override
  set activeSign(Sign value) {
    _$activeSignAtom.context.conditionallyRunInAction(() {
      super.activeSign = value;
      _$activeSignAtom.reportChanged();
    }, _$activeSignAtom, name: '${_$activeSignAtom.name}_set');
  }

  final _$_SignSignStoreActionController =
      ActionController(name: '_SignSignStore');

  @override
  dynamic handleMapChange(MapPosition position, bool hasGesture) {
    final _$actionInfo = _$_SignSignStoreActionController.startAction();
    try {
      return super.handleMapChange(position, hasGesture);
    } finally {
      _$_SignSignStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic actualizeMarkersList(bool showSigns, LatLngBounds bounds) {
    final _$actionInfo = _$_SignSignStoreActionController.startAction();
    try {
      return super.actualizeMarkersList(showSigns, bounds);
    } finally {
      _$_SignSignStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic handleMapTap(LatLng point) {
    final _$actionInfo = _$_SignSignStoreActionController.startAction();
    try {
      return super.handleMapTap(point);
    } finally {
      _$_SignSignStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'mapController: ${mapController.toString()},center: ${center.toString()},zoom: ${zoom.toString()},bounds: ${bounds.toString()},isNeedToShowZoomCard: ${isNeedToShowZoomCard.toString()},markers: ${markers.toString()},activeSign: ${activeSign.toString()}';
    return '{$string}';
  }
}

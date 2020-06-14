import 'package:flutter/material.dart';

class SignSignConstants extends InheritedWidget {
  static SignSignConstants of(BuildContext context) => context. dependOnInheritedWidgetOfExactType<SignSignConstants>();
  const SignSignConstants({Widget child, Key key}): super(key: key, child: child);

  // layout constants
  final zoomCardHeight = 80.0;
  final screenEdgeOffset = 16.0;
  final cardPadding = 20.0;
  final mapControlSize = 38.0;
  final zoomControlHeight = 100.0;
  final elementBorderRadius = 8.0;
  final infoModalHeight = 214.0;

  // map constants
  final tilesUrlTemplate = 'http://vec{s}.maps.yandex.net/tiles?l=map&v=4.55.2&z={z}&x={x}&y={y}&scale=2&lang=ru_RU';
  final minZoom = 5.0;
  final maxZoom = 19.0;

  @override
  bool updateShouldNotify(SignSignConstants oldWidget) => false;
}

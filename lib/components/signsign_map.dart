import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';
import 'package:signsign/components/signsign_constants.dart';
import 'package:signsign/models/crs.dart';

class SignSignMap extends StatelessWidget {
  final MapController mapController;
  final LatLng center;
  final double zoom;
  final PositionCallback handleMapChange;
  final TapCallback handleMapTap;
  final List<Marker> markers;
  final bool isShownSignCard;

  SignSignMap({
    this.mapController,
    this.center,
    this.zoom,
    this.handleMapChange,
    this.handleMapTap,
    this.markers,
    this.isShownSignCard,
  });

  @override
  Widget build(BuildContext context) {
    final constants = SignSignConstants.of(context);
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: center,
        zoom: zoom,
        crs: Epsg3395(),
        onPositionChanged: handleMapChange,
        onTap: handleMapTap,
        minZoom: constants.minZoom,
        maxZoom: constants.maxZoom,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: constants.tilesUrlTemplate,
        ),
        MarkerLayerOptions(
          markers: markers,
        ),
      ],
    );
  }
}

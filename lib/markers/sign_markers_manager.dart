import 'dart:math' as math;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong/latlong.dart';
import 'package:signsign/markers/icons.dart';
import 'package:signsign/markers/sign_marker.dart';

typedef SignMarkerTapHandler = void Function(SignModel markerModel);

class SignMarkersManager {
  List<SignModel> _markersDataCollection = [];
  SignMarkerTapHandler _onMarkerTap;

  SignMarkersManager(SignMarkerTapHandler onMarkerTap) {
    _onMarkerTap = onMarkerTap;
  }

  List<Marker> getMarkersList() =>
    _markersDataCollection.map((signMarkerModel) =>
      _modelToMarker(signMarkerModel)).toList();

  updateFromAPIResponse(String responseBody) {
    _markersDataCollection = _parseAPIResponse(responseBody);
  }

  isEmpty() => _markersDataCollection.length == 0;

  clean() {
    _markersDataCollection = [];
  }

  List<SignModel> _parseAPIResponse(String responseBody) {
    final parsedBody = json.decode(responseBody);
    return parsedBody['result']
      .map<SignModel>((json) => SignModel.fromJSON(json)).toList();
  }

  SignIconParams _getMarkerIconParams(String code) {
    SignIconParams iconParams = supportedIcons[code];
    if (iconParams == null) {
      code = 'default';
      iconParams = supportedIcons['default'];

      print("Marker image not found (code: \"$code\")");
    }

    iconParams.iconPath = 'assets/signs/$code.svg';
    return iconParams;
  }
  
  Marker _modelToMarker(SignModel signMarkerModel) {
    final iconParams = _getMarkerIconParams(signMarkerModel.code);

    return Marker(
      width: iconParams.width,
      height: iconParams.height,
      point: LatLng(
        signMarkerModel.coords.lat,
        signMarkerModel.coords.lon
      ),
      builder: (BuildContext context) => Container(
        child: Transform.rotate(
          angle: signMarkerModel.angle.toDouble() * math.pi / 180,
          child: GestureDetector(
            onTap: () {
              _onMarkerTap(signMarkerModel);
            },
            child: SvgPicture.asset(
              iconParams.iconPath,
              width: iconParams.width,
              height: iconParams.height,
            ),
          ),
        ),
      ),
    );
  }
}

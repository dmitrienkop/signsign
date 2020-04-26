import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong/latlong.dart';
import 'package:signsign/models/sign_icon.dart';

class SignMarkerCoords {
  double lon;
  double lat;

  SignMarkerCoords({
    this.lon,
    this.lat
  });
}

typedef SignMarkerTapHandler = void Function(Sign sign);

class Sign {
  String id;
  String code;
  String title;
  String description;
  SignMarkerCoords coords;
  int angle;
  bool isActive = false;

  Sign({
    this.id,
    this.code,
    this.title,
    this.description,
    this.coords,
    this.angle,
    this.isActive
  });

  Sign.fromJSON(Map<String, dynamic> json)
    : id = json['id'],
      code = json['css'],
      title = json['title'],
      description = json['description'],
      coords = SignMarkerCoords(
        lat: json['coords']['lat'],
        lon: json['coords']['lon'],
      ),
      angle = int.parse(json['angle']);
  
  Marker toMarker(SignMarkerTapHandler tapHandler) {
    final iconParams = getMarkerIconParams(code);

    return Marker(
      width: iconParams.width,
      height: iconParams.height,
      point: LatLng(
        coords.lat,
        coords.lon
      ),
      builder: (BuildContext context) => Container(
        child: Transform.rotate(
          angle: angle.toDouble() * math.pi / 180,
          child: GestureDetector(
            onTap: () {
              tapHandler(this);
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

  SignIcon getMarkerIconParams(String code) {
    SignIcon iconParams = supportedIcons[code];
    if (iconParams == null) {
      code = 'default';
      iconParams = supportedIcons['default'];
    }
    iconParams.iconPath = 'assets/signs/$code.svg';
    return iconParams;
  }
}

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong/latlong.dart';
import 'package:signsign/models/sign_icon.dart';

typedef SignMarkerTapHandler = void Function(Sign sign);

class SignCoords {
  double lon;
  double lat;

  SignCoords({
    this.lon,
    this.lat
  });
}

class Sign {
  String id;
  String code;
  String title;
  String description;
  SignCoords coords;
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
      coords = SignCoords(
        lat: json['coords']['lat'],
        lon: json['coords']['lon'],
      ),
      angle = int.parse(json['angle']);
  
  Marker toMarker(SignMarkerTapHandler tapHandler) {
    final icon = getSignIcon(code);
    return Marker(
      width: icon.width,
      height: icon.height,
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
              icon.iconPath,
              width: icon.width,
              height: icon.height,
            ),
          ),
        ),
      ),
    );
  }

  SignIcon getSignIcon(String code) {
    SignIcon iconParams = supportedIcons[code];
    if (iconParams == null) {
      code = 'default';
      iconParams = supportedIcons['default'];
    }
    iconParams.iconPath = 'assets/signs/$code.svg';
    return iconParams;
  }
}

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';
import 'package:signsign/icons/icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignCoords {
  double lon;
  double lat;

  SignCoords({
    this.lon,
    this.lat
  });
}

class Sign {
  final String id;
  final String code;
  final String title;
  final SignCoords coords;
  final int angle;

  Sign({
    this.id,
    this.code,
    this.title,
    this.coords,
    this.angle
  });

  Sign.fromJSON(Map<String, dynamic> json)
    : id = json['id'],
      code = json['css'],
      title = json['title'],
      coords = SignCoords(
        lat: json['coords']['lat'],
        lon: json['coords']['lon'],
      ),
      angle = int.parse(json['angle']);
    
  SignIconParams _getIconParams(String code) {
    SignIconParams iconParams = supportedIcons[code];
    if (iconParams == null) {
      code = 'default';
      iconParams = supportedIcons['default'];

      print("$code not found");
    }

    iconParams.iconPath = 'assets/signs/$code.svg';
    return iconParams;
  }
  
  Marker toMarker() {
    final iconParams = _getIconParams(code);
    return Marker(
      width: iconParams.width,
      height: iconParams.height,
      point: LatLng(coords.lat, coords.lon),
      builder: (ctx) => Container(
        child: Transform.rotate(
          angle: angle.toDouble() * math.pi / 180,
          child: SvgPicture.asset(
            iconParams.iconPath,
            width: iconParams.width,
            height: iconParams.height,
          ),
        ),
      ),
    );
  }
}

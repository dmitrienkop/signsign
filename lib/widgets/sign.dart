import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';

class SignCoords {
  double lon;
  double lat;

  SignCoords({
    this.lon,
    this.lat
  });
}

class SignIconParams {
  final double width;
  final double height;
  final String iconPath;

  SignIconParams({
    this.width,
    this.height,
    this.iconPath
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

  final Map<String, SignIconParams> supportedIcons = {
    'default': SignIconParams(width: 20, height: 20, iconPath: 'lib/icons/default.png'),
    '2.1': SignIconParams(width: 25.0, height: 25.0, iconPath: 'lib/icons/2-1.png'),
    '3.27': SignIconParams(width: 25.0, height: 26.0, iconPath: 'lib/icons/3-27.png'),
    '5.14': SignIconParams(width: 25.0, height: 25.0, iconPath: 'lib/icons/5-14.png'),
    '5.19.2': SignIconParams(width: 25.0, height: 25.0, iconPath: 'lib/icons/5-19-2.png'),
    '8.13': SignIconParams(width: 25.0, height: 25.0, iconPath: 'lib/icons/8-13.png'),
    '8.2.3': SignIconParams(width: 14.0, height: 25.0, iconPath: 'lib/icons/8-2-3.png'),
    '8.2.4': SignIconParams(width: 14.0, height: 25.0, iconPath: 'lib/icons/8-2-4.png'),
    '8.24': SignIconParams(width: 25.0, height: 12.0, iconPath: 'lib/icons/8-24.png'),
  };

  Sign.fromJSON(Map<String, dynamic> json)
    : id = json['id'],
      code = json['code'],
      title = json['title'],
      coords = SignCoords(
        lat: json['coords']['lat'],
        lon: json['coords']['lon'],
      ),
      angle = int.parse(json['angle']);
    
  SignIconParams _getIconParams(String code) {
    final icon = supportedIcons[code];
    return icon == null
      ? supportedIcons['default']
      : icon;
  }
  
  Marker toMarker() {
    final iconParams = _getIconParams(code);
    // print('code: ' + code);

    return Marker(
      width: iconParams.width,
      height: iconParams.height,
      point: LatLng(coords.lat, coords.lon),
      builder: (ctx) => Container(
        child: Transform.rotate(
          angle: angle.toDouble() * math.pi / 180,
          child: Image.asset(
            iconParams.iconPath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

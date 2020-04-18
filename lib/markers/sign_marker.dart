class SignMarkerCoords {
  double lon;
  double lat;

  SignMarkerCoords({
    this.lon,
    this.lat
  });
}

class SignModel {
  String id;
  String code;
  String title;
  String description;
  SignMarkerCoords coords;
  int angle;
  bool isActive = false;

  SignModel({
    this.id,
    this.code,
    this.title,
    this.description,
    this.coords,
    this.angle,
    this.isActive
  });

  SignModel.fromJSON(Map<String, dynamic> json)
    : id = json['id'],
      code = json['css'],
      title = json['title'],
      description = json['description'],
      coords = SignMarkerCoords(
        lat: json['coords']['lat'],
        lon: json['coords']['lon'],
      ),
      angle = int.parse(json['angle']);
}

class SignIconParams {
  final double width;
  final double height;
  String iconPath;

  SignIconParams({
    this.width,
    this.height,
    this.iconPath
  });
}

class SignMarker {
  SignModel markerModel;

  SignMarker({ this.markerModel });
}

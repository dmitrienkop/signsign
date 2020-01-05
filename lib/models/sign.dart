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
      code = json['code'],
      title = json['title'],
      coords = SignCoords(
        lat: json['coords']['lat'],
        lon: json['coords']['lon'],
      ),
      angle = json['angle'].toInt();
}

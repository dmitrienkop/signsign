import 'package:location/location.dart';

Future<LocationData> getCurrentLocation() async {
  final location = new Location();
  return location.getLocation();
}
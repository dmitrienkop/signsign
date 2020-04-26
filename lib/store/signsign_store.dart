import 'dart:convert';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';
import 'package:mobx/mobx.dart';
import 'package:signsign/helpers/location.dart';
import 'package:signsign/models/sign.dart';
import 'package:signsign/services/signsignapi.dart';
import 'package:throttling/throttling.dart';

part 'signsign_store.g.dart';

const minVisibleSignsZoom = 17.0;
const requestDebounceTimeoutMs = 150;
final requestDebounce = new Debouncing(duration: Duration(milliseconds: requestDebounceTimeoutMs));

class SignSignStore = _SignSignStore with _$SignSignStore;

abstract class _SignSignStore with Store {
  /* State */

  bool initialized = false;

  // Map
  @observable
  MapController mapController = MapController();

  @observable
  LatLng center = LatLng(56.454658, 84.976087);

  @observable
  double zoom = 15.0;

  @observable
  LatLngBounds bounds;

  // UI
  @observable
  bool isNeedToShowZoomCard = false;

  // Signs
  @observable
  List<Marker> markers = [];

  @observable
  Sign activeSign;

  /* Actions */

  @action
  handleMapChange(MapPosition position, bool hasGesture) {
    if (!initialized) {
      initialized = true;
      mapController.onReady.then((_) async {
        final location = await getCurrentLocation();
        if (location != null) {
          mapController.move(LatLng(location.latitude, location.longitude), zoom);
        }
      });
    }

    if (!hasGesture) {
      // skip initial/programatical map change
      return false;
    }

    center = position.center;
    zoom = position.zoom;
    bounds = position.bounds;

    final showSigns = zoom >= minVisibleSignsZoom;
    isNeedToShowZoomCard = !showSigns;
    activeSign = showSigns ? activeSign : null;

    actualizeMarkersList(showSigns, bounds);
  }

  @action
  actualizeMarkersList(bool showSigns, LatLngBounds bounds) {
    if (!showSigns) {
      return markers.clear();
    }

    requestDebounce.debounce(() async {
      final signsListResponse = await getSignsList(bounds);
      final parsedResponse = json.decode(signsListResponse);
      if (!isNeedToShowZoomCard) {
        // zoom may already change at this moment
        markers = parsedResponse['result']
          .map<Marker>((json) =>
            Sign
              .fromJSON(json)
              .toMarker((sign) {
                activeSign = sign;
              })
          )
          .toList();
      }
    });
  }

  @action
  handleMapTap(LatLng point) {
    activeSign = null;
  }
}

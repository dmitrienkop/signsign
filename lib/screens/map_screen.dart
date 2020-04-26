import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:signsign/components/sign_card.dart';
import 'package:signsign/models/crs.dart';
import 'package:signsign/store/signsign_store.dart';
import 'package:signsign/components/zoom_card.dart';

final store = SignSignStore();

const tilesUrlTemplate = 'http://vec{s}.maps.yandex.net/tiles?l=map&v=4.55.2&z={z}&x={x}&y={y}&scale=2&lang=ru_RU';
const minZoom = 5.0;
const maxZoom = 19.0;

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
    Scaffold(
      body: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) =>
            Column(
              children: <Widget>[
                Expanded(
                  child: Observer(
                    builder: (_) =>
                      FlutterMap(
                        mapController: store.mapController,
                        options: MapOptions(
                          center: store.center,
                          zoom: store.zoom,
                          crs: Epsg3395(),
                          onPositionChanged: store.handleMapChange,
                          onTap: store.handleMapTap,
                          minZoom: minZoom,
                          maxZoom: maxZoom,
                        ),
                        layers: [
                          TileLayerOptions(
                            urlTemplate: tilesUrlTemplate,
                          ),
                          MarkerLayerOptions(
                            markers: store.markers,
                          ),
                        ],
                      ),
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height / 3,
                  ),
                  child: SingleChildScrollView(
                    child: Observer(
                      builder: (_) => Column(
                        children: <Widget>[
                          Visibility(
                            child: ZoomCard(),
                            visible: store.isNeedToShowZoomCard
                          ),
                          Visibility(
                            child: SignCard(signMarkerModel: store.activeSign),
                            visible: store.activeSign != null
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ),
      ),
    );
}

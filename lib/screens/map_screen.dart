import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:signsign/components/info_modal.dart';
import 'package:signsign/components/map_control/map_control.dart';
import 'package:signsign/components/map_card/sign_card.dart';
import 'package:signsign/components/map_card/zoom_card.dart';
import 'package:signsign/components/signsign_constants.dart';
import 'package:signsign/components/signsign_map.dart';
import 'package:signsign/components/map_control/zoom_control.dart';
import 'package:signsign/store/signsign_store.dart';

final store = SignSignStore();

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) =>
    Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final mediaQuery = MediaQuery.of(context);
            final constants = SignSignConstants.of(context);
            return Observer(
              builder: (_) => Stack(
                children: <Widget>[
                  Container(
                    color: Colors.green,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: SignSignMap(
                            mapController: store.mapController,
                            center: store.center,
                            zoom: store.zoom,
                            handleMapChange: store.handleMapChange,
                            handleMapTap: store.handleMapTap,
                            markers: store.markers,
                            isShownSignCard: store.activeSign != null,
                          ),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: mediaQuery.size.height / 3,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Visibility(
                                  child: ZoomCard(),
                                  visible: store.isNeedToShowZoomCard && !store.showInfoModal,
                                ),
                                Visibility(
                                  child: SignCard(signMarkerModel: store.activeSign),
                                  visible: store.activeSign != null && !store.showInfoModal,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    child: Positioned(
                      right: constants.screenEdgeOffset,
                      top: mediaQuery.padding.top + constants.screenEdgeOffset,
                      child: MapControl(
                        height: constants.mapControlSize,
                        width: constants.mapControlSize,
                        assetName: 'assets/controls/info.svg',
                        onTap: store.toggleInfoModalVisibility,
                      ),
                    ),
                    visible: !store.showInfoModal,
                  ),
                  Visibility(
                    child: Positioned(
                      right: constants.screenEdgeOffset,
                      top: (mediaQuery.size.height / 2) - (constants.zoomControlHeight / 2),
                      child: ZoomControl(
                        onZoomIn: () => store.animatedMapMove(store.center, store.zoom + 1, this),
                        onZoomOut: () => store.animatedMapMove(store.center, store.zoom - 1, this),
                        isMinZoom: store.zoom == constants.minZoom,
                        isMaxZoom: store.zoom == constants.maxZoom,
                      ),
                    ),
                    visible: !store.showInfoModal,
                  ),
                  Visibility(
                    child: Positioned(
                      bottom: store.isNeedToShowZoomCard
                        ? constants.zoomCardHeight + constants.screenEdgeOffset
                        : mediaQuery.padding.bottom + constants.screenEdgeOffset,
                      right: constants.screenEdgeOffset,
                      child: MapControl(
                        height: constants.mapControlSize,
                        width: constants.mapControlSize,
                        assetName: 'assets/controls/location.svg',
                        onTap: () => store.moveMapToCurrentLocation(this),
                        disabled: !store.hasLocationPermission,
                      ),
                    ),
                    visible: store.activeSign == null && !store.showInfoModal,
                  ),
                  InfoModal(
                    isVisible: store.showInfoModal,
                    onClose: store.toggleInfoModalVisibility,
                  ),
                ],
              )
            );
          },
        ),
    );
}

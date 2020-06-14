import 'package:flutter/material.dart';
import 'package:signsign/components/map_control/map_control_base.dart';
import 'package:signsign/components/map_control/map_control_decoration.dart';
import 'package:signsign/components/signsign_constants.dart';

class ZoomControl extends StatelessWidget {
  final Function onZoomIn;
  final Function onZoomOut;
  final bool isMinZoom;
  final bool isMaxZoom;

  ZoomControl({
    this.onZoomIn,
    this.onZoomOut,
    this.isMinZoom,
    this.isMaxZoom,
  });

  // @override
  Widget build(BuildContext context) {
    final constants = SignSignConstants.of(context);
    return MapControlDecoration(
      mapControl: Column(
        children: <Widget>[
          MapControlBase(
            assetName: 'assets/controls/zoomIn.svg',
            height: constants.zoomControlHeight / 2,
            width: constants.mapControlSize,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(constants.elementBorderRadius),
              topRight: Radius.circular(constants.elementBorderRadius),
            ),
            onTap: onZoomIn,
            disabled: isMaxZoom,
          ),
          MapControlBase(
            assetName: 'assets/controls/zoomOut.svg',
            height: constants.zoomControlHeight / 2,
            width: constants.mapControlSize,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(constants.elementBorderRadius),
              bottomRight: Radius.circular(constants.elementBorderRadius),
            ),
            onTap: onZoomOut,
            disabled: isMinZoom,
          ),
        ],
      ),
    );
  }
}

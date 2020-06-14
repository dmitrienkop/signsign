import 'package:flutter/material.dart';
import 'package:signsign/components/map_control/map_control_base.dart';
import 'package:signsign/components/map_control/map_control_decoration.dart';

class MapControl extends StatelessWidget {
  final double width;
  final double height;
  final String assetName;
  final Function onTap;
  final bool disabled;

  MapControl({
    this.width,
    this.height,
    this.assetName,
    this.onTap,
    this.disabled = false,
  });

  // @override
  Widget build(BuildContext context) =>
    MapControlDecoration(
      mapControl: MapControlBase(
        width: width,
        height: height,
        assetName: assetName,
        onTap: onTap,
        disabled: disabled,
      ),
    );
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:signsign/components/signsign_constants.dart';

class MapControlBase extends StatefulWidget {
  final double width;
  final double height;
  final String assetName;
  final BorderRadius borderRadius;
  final Function onTap;
  final bool disabled;

  MapControlBase({
    this.width,
    this.height,
    this.assetName,
    this.borderRadius,
    this.onTap,
    this.disabled = false
  });

  @override
  _MapControlBaseState createState() => _MapControlBaseState();
}

class _MapControlBaseState extends State<MapControlBase> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    final constants = SignSignConstants.of(context);
    return GestureDetector(
      onTapDown: (TapDownDetails details) =>
        widget.disabled
          ? null
          : setState(() {
            widget.onTap();
            pressed = true;
          }),
      onTapUp: (TapUpDetails details) =>
        setState(() {
          pressed = false;
        }),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius != null
            ? widget.borderRadius
            : BorderRadius.all(
                Radius.circular(constants.elementBorderRadius)
              ),
          color: pressed && !widget.disabled
            ? Color.fromRGBO(0, 0, 0, 0.03)
            : null,
        ),
        height: widget.height,
        width: widget.width,
        child: Opacity(
          opacity: widget.disabled ? 0.25 : 1.0,
          child: SvgPicture.asset(
            widget.assetName,
            fit: BoxFit.none,
          ),
        ),
      ),
    );
  }
}

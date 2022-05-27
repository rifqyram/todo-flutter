import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  double height;
  double width;
  BoxDecoration? decoration;
  BorderRadius? borderRadius;
  Color? splashColor;
  String label;
  TextStyle? textStyle;
  Function onTap;

  CustomButton(
      {Key? key,
      required this.height,
      required this.width,
      this.decoration,
      this.borderRadius,
      this.splashColor,
      required this.label,
      required this.onTap,
      this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: decoration,
      child: Material(
        color: Colors.transparent,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          splashColor: splashColor,
          onTap: () => onTap(),
          child: Center(
            child: Text(label, style: textStyle),
          ),
        ),
      ),
    );
  }
}

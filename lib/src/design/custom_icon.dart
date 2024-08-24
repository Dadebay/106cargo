import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class CustomIcon extends StatelessWidget {
  String title;
  double height;
  double width;
  Color color;
  CustomIcon({
    required this.title,
    required this.height,
    required this.width,
    required this.color,
    super.key,
  });

  bool mode = false;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      title,
      height: height,
      width: width,
      color: color,
    );
  }
}

class CustomIconText extends StatelessWidget {
  String text;
  String title;
  double height;
  double width;
  Color color;
  CustomIconText({
    required this.text,
    required this.title,
    required this.height,
    required this.width,
    required this.color,
    super.key,
  });

  bool mode = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            title,
            height: height,
            width: width,
            color: color,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Roboto',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

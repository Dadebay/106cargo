// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kargo_app/src/design/app_colors.dart';

class NumberStepper extends StatelessWidget {
  final double width;
  final int totalSteps;
  final int curStep;
  final Color stepCompleteColor;
  final Color currentStepColor;
  final Color inactiveColor;
  final double lineWidth;

  const NumberStepper({
    required this.width,
    required this.curStep,
    required this.stepCompleteColor,
    required this.totalSteps,
    required this.inactiveColor,
    required this.currentStepColor,
    required this.lineWidth,
    Key? key,
  })  : assert(curStep > 0 && curStep <= totalSteps + 1),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 20.0,
        left: 24.0,
        right: 24.0,
      ),
      width: width,
      child: Row(
        children: _steps(),
      ),
    );
  }

  List<Widget> _steps() {
    final list = <Widget>[];
    for (int i = 0; i < totalSteps; i++) {
// Colors according to state
      final circleColor = getCircleColor(i);
      final borderColor = getBorderColor(i);
      final lineColor = getLineColor(i);

// Step circles
      list.add(
        Container(
          width: i + 1 == curStep ? 38.0 : 13.0,
          height: i + 1 == curStep ? 38.0 : 13.0,
          decoration: BoxDecoration(
            color: circleColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: borderColor,
              width: 1.0,
            ),
            boxShadow: i + 1 == curStep
                ? [
                    BoxShadow(
                      color: AppColors.blueColor.withOpacity(0.4),
                    ),
                  ]
                : [],
          ),
          child: getInnerElementOfStepper(i),
        ),
      );

// Line between step circles
      if (i != totalSteps - 1) {
        list.add(
          Expanded(
            child: Container(
              width: lineWidth,
              height: 2,
              color: lineColor,
              margin: const EdgeInsets.symmetric(horizontal: 2),
            ),
          ),
        );
      }
    }

    return list;
  }

  Widget getInnerElementOfStepper(int index) {
    if (index + 1 < curStep) {
      return Container(
        decoration: const BoxDecoration(
          color: AppColors.blueColor,
          shape: BoxShape.circle,
        ),
      );
    } else if (index + 1 == curStep) {
      return Container(
        decoration: const BoxDecoration(
          color: AppColors.blueColor,
          shape: BoxShape.circle,
        ),
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(4),
        child: SvgPicture.asset(
          'assets/icons/truck_delivery.svg',
          color: Colors.white,
        ),
      );
    } else {
      return Container();
    }
  }

  Color getCircleColor(int i) {
    if (i + 1 < curStep) {
      return stepCompleteColor;
    } else if (i + 1 == curStep) {
      return currentStepColor;
    } else {
      return inactiveColor;
    }
  }

  Color getBorderColor(int i) {
    if (i + 1 < curStep) {
      return stepCompleteColor;
    } else if (i + 1 == curStep) {
      return currentStepColor;
    } else {
      return inactiveColor;
    }
  }

  Color getLineColor(int i) {
    return curStep > i + 1 ? stepCompleteColor : inactiveColor;
  }
}

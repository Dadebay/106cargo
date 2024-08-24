import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../design/app_colors.dart';
import '../design/custom_icon.dart';

// ignore: must_be_immutable
class BottomNavbarButton extends StatefulWidget {
  final Function() onTapp;
  final int selectedIndex;
  final int index;
  final bool icon;
  const BottomNavbarButton({
    required this.onTapp,
    required this.selectedIndex,
    required this.index,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavbarButton> createState() => _BottomNavbarButtonState();
}

class _BottomNavbarButtonState extends State<BottomNavbarButton> {
  List<String> title = [
    'order'.tr(),
    'about'.tr(),
    'profile'.tr(),
  ];

  List iconsLight = [
    CustomIcon(
      title: 'assets/icons/box_new.svg',
      height: 26,
      width: 26,
      color: AppColors.disableColor,
    ),
    CustomIcon(
      title: 'assets/icons/logo.svg',
      height: 26,
      width: 26,
      color: AppColors.disableColor,
    ),
    CustomIcon(
      title: 'assets/icons/person_cargo.svg',
      height: 26,
      width: 26,
      color: AppColors.disableColor,
    ),
  ];

  List iconsBold = [
    CustomIcon(
      title: 'assets/icons/box_new.svg',
      height: 26,
      width: 26,
      color: AppColors.mainColor,
    ),
    CustomIcon(
      title: 'assets/icons/logo.svg',
      height: 35,
      width: 35,
      color: AppColors.mainColor,
    ),
    CustomIcon(
      title: 'assets/icons/person_cargo.svg',
      height: 26,
      width: 26,
      color: AppColors.mainColor,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTapp,
      child: Column(
        children: [
          Expanded(
            child: AnimatedContainer(
              width: double.infinity,
              height: widget.index == widget.selectedIndex ? 68 : 0,
              decoration: const BoxDecoration(),
              duration: const Duration(milliseconds: 500),
              curve: Curves.decelerate,
              child: Column(
                children: [
                  Expanded(
                    child: widget.index != widget.selectedIndex
                        ? widget.icon
                            ? const Icon(Icons.local_activity)
                            : Container(
                                child: iconsLight[widget.index],
                              )
                        : widget.icon
                            ? const Icon(Icons.add)
                            : Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  child: iconsBold[widget.index],
                                ),
                              ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      title[widget.index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: widget.index == widget.selectedIndex ? AppColors.mainColor : AppColors.disableColor,
                        fontWeight: widget.index == widget.selectedIndex ? FontWeight.w600 : FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'Roboto',
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kargo_app/src/design/app_colors.dart';
import 'package:kargo_app/src/screens/clientHome/clientHome_controller.dart';

class LocationCard extends StatelessWidget {
  final String locationName;
  final String locationId;
  LocationCard({
    required this.locationName,
    required this.locationId,
    Key? key,
  }) : super(key: key);
  final ClientHomeController clientHomeController = Get.put(ClientHomeController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        clientHomeController.selectLocation(
          selectedLocation: locationName,
          regionId: locationId,
        );
      },
      child: Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          margin: const EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
            color: clientHomeController.locationName == locationName ? AppColors.blueColor.withOpacity(0.2) : AppColors.grey1Color,
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            locationName,
            style: TextStyle(
              color: clientHomeController.locationName == locationName ? AppColors.blueColor : AppColors.lightBlueColor,
              fontFamily: 'Roboto',
              fontWeight: clientHomeController.locationName == locationName ? FontWeight.bold : FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

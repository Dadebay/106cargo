import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:kargo_app/src/design/app_colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

SnackbarController showSnackBar(String title, String subtitle, Color color) {
  if (SnackbarController.isSnackbarBeingShown) {
    SnackbarController.cancelAllSnackbars();
  }
  return Get.snackbar(
    title,
    subtitle,
    snackStyle: SnackStyle.FLOATING,
    titleText: title == ''
        ? const SizedBox.shrink()
        : Text(
            title.tr,
            style: const TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
          ),
    messageText: Text(
      subtitle.tr,
      style: const TextStyle(fontFamily: 'Roboto', fontSize: 16, color: Colors.white),
    ),
    borderColor: Colors.white,
    borderWidth: 2,
    snackPosition: SnackPosition.TOP,
    backgroundColor: color,
    borderRadius: 20.0,
    duration: const Duration(seconds: 2),
    animationDuration: const Duration(seconds: 2),
    margin: const EdgeInsets.all(8),
  );
}

PreferredSize appBar() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(kToolbarHeight),
    child: Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        toolbarHeight: 70,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            IconlyLight.arrow_left_circle,
            color: Colors.grey,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.profilColor, size: 30),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        title: const Text(
          'Sargyt maglumaty',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Roboto',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),
  );
}

Padding customDivider() {
  return Padding(
    padding: const EdgeInsets.only(top: 40, bottom: 15, right: 10),
    child: Container(
      color: AppColors.profilColor.withOpacity(0.1),
      width: double.infinity,
      height: 1.5,
    ),
  );
}

CustomFooter footer(bool showLoading) {
  return CustomFooter(
    builder: (BuildContext context, LoadStatus? mode) {
      Widget body;
      if (mode == LoadStatus.idle) {
        body = Text(showLoading ? '' : 'Garaşyň...');
      } else if (mode == LoadStatus.loading) {
        body = const CircularProgressIndicator(
          color: AppColors.mainColor,
        );
      } else if (mode == LoadStatus.failed) {
        body = const Text('Load Failed!Click retry!');
      } else if (mode == LoadStatus.canLoading) {
        body = const Text('');
      } else {
        body = const Text('No more Data');
      }
      return SizedBox(
        height: 55.0,
        child: Center(child: body),
      );
    },
  );
}

Center emptyDataMine() => const Center(child: Text('No data available'));

Center hasError() {
  return const Center(
    child: Text('Error fetching data'),
  );
}

Widget loading() {
  return const Center(
    child: SpinKitFadingCircle(
      color: Colors.grey,
      size: 50.0,
    ),
  );
}

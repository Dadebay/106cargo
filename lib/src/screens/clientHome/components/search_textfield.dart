import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kargo_app/src/design/app_colors.dart';
import 'package:kargo_app/src/screens/clientHome/clientHome_controller.dart';
import 'package:kargo_app/src/screens/clientHome/data/services/region_service.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({super.key});

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  TextEditingController controller = TextEditingController();

  final ClientHomeController clientHomeController = Get.put(ClientHomeController());

  Timer? searchOnStoppedTyping;

  _onChangeHandler(value) {
    const duration = Duration(milliseconds: 800); // set the duration that you want call search() after that.
    if (searchOnStoppedTyping != null) {
      setState(() => searchOnStoppedTyping!.cancel()); // clear timer
    }
    setState(() => searchOnStoppedTyping = Timer(duration, () => search(value)));
  }

  search(value) async {
    if (controller.text.isNotEmpty) {
      clientHomeController.showUsersList.clear();

      clientHomeController.page.value = 0;
      clientHomeController.loading.value = 0;
      await RegionService().fetchRegionSearch(id: clientHomeController.locationId.value, limit: clientHomeController.limit.value, page: clientHomeController.page.value, search: controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, right: 20, left: 20),
      child: TextFormField(
        controller: controller,
        onChanged: _onChangeHandler,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: 'Gözleg',
          filled: true,
          prefixIcon: SvgPicture.asset(
            'assets/icons/searchnormal1.svg',
            fit: BoxFit.scaleDown,
          ),
          fillColor: const Color.fromARGB(255, 225, 234, 250),
          hintStyle: const TextStyle(
            color: AppColors.grey3Color,
            fontFamily: 'Roboto',
            // fontWeight: FontWeight.bold,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.blueColor, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color.fromARGB(255, 225, 234, 250), width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColors.blueColor,
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColors.redColor,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:kargo_app/src/design/app_colors.dart';
import 'package:kargo_app/src/screens/clientHome/clientHome_controller.dart';
import 'package:kargo_app/src/screens/clientHome/components/clientInfoCard_slider.dart';
import 'package:kargo_app/src/screens/clientHome/components/location_slider.dart';
import 'package:kargo_app/src/screens/clientHome/components/search_textfield.dart';
import 'package:kargo_app/src/screens/clientHome/data/services/getOneOrder_service.dart';
import 'package:kargo_app/src/screens/clientHome/tolegler_page.dart';
import 'package:kargo_app/src/screens/custom_widgets/custom_appbar.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({Key? key}) : super(key: key);

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  final ClientHomeController _clientHomeController = Get.put(ClientHomeController());

  @override
  void initState() {
    super.initState();
    _clientHomeController.onInit();
    fetchData();
  }

  fetchData() async {
    await GetOneOrderService().getPaymentHistory();
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.searchColor,
      appBar: CustomAppBar(
        title: selectedIndex == 0 ? 'Müşderiler' : 'Tölegler',
      ),
      body: selectedIndex == 0 ? pagee() : Tolegler(),
      bottomSheet: BottomNavigationBar(
        backgroundColor: Colors.white,
        iconSize: 26,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: AppColors.mainColor,
        useLegacyColorScheme: true,
        selectedLabelStyle: const TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 13),
        unselectedLabelStyle: const TextStyle(fontFamily: 'Roboto', fontSize: 12),
        currentIndex: selectedIndex,
        onTap: (index) async {
          setState(() {
            selectedIndex = index;
          });
          if (selectedIndex == 1) {
            await GetOneOrderService().getPaymentHistory();
          }
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Müşderiler',
            icon: Icon(
              IconlyLight.user,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Tölegler',
            icon: Icon(
              IconlyLight.document,
            ),
          ),
        ],
      ),
    );
  }

  Column pagee() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SearchTextField(),
        Expanded(
          flex: 1,
          child: LocationSlider(),
        ),
        const Expanded(
          flex: 8,
          child: ClientInfoCardSlider(),
        ),
      ],
    );
  }
}

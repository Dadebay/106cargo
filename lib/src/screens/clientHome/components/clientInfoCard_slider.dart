// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:kargo_app/src/design/app_colors.dart';
import 'package:kargo_app/src/screens/clientHome/clientHome_controller.dart';
import 'package:kargo_app/src/screens/clientHome/components/custom_button.dart';
import 'package:kargo_app/src/screens/clientHome/data/services/region_service.dart';
import 'package:kargo_app/src/screens/clientHome/orders_screen.dart';
import 'package:kargo_app/src/screens/custom_widgets/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ClientInfoCardSlider extends StatefulWidget {
  const ClientInfoCardSlider({
    Key? key,
  }) : super(key: key);

  @override
  State<ClientInfoCardSlider> createState() => _ClientInfoCardSliderState();
}

class _ClientInfoCardSliderState extends State<ClientInfoCardSlider> {
  final ClientHomeController clientHomeController = Get.put(ClientHomeController());

  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    clientHomeController.showUsersList.clear();
    clientHomeController.page.value = 0;
    clientHomeController.loading.value = 0;
    clientHomeController.fetchRegions();
  }

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
    clientHomeController.showUsersList.clear();

    clientHomeController.page.value = 0;
    clientHomeController.loading.value = 0;
    await RegionService().fetchRegion(id: clientHomeController.locationId.value, limit: clientHomeController.limit.value, page: clientHomeController.page.value);
  }

  int showLoading = 0;
  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.loadComplete();
    clientHomeController.page.value += 1;
    showLoading = clientHomeController.showUsersList.length;
    await RegionService().fetchRegion(id: clientHomeController.locationId.value, limit: clientHomeController.limit.value, page: clientHomeController.page.value);
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      footer: footer(showLoading == clientHomeController.showUsersList.length ? true : false),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      enablePullDown: true,
      enablePullUp: true,
      physics: const BouncingScrollPhysics(),
      header: const MaterialClassicHeader(
        color: AppColors.blueColor,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          margin: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Obx(
            () {
              if (clientHomeController.loading.value == 0) {
                return loading();
              } else if (clientHomeController.loading.value == 1) {
                return hasError();
              } else if (clientHomeController.loading.value == 2) {
                return emptyDataMine();
              } else if (clientHomeController.showUsersList.isEmpty && clientHomeController.loading.value == 3) {
                return emptyDataMine();
              }
              return showPage();
            },
          ),
        ),
      ),
    );
  }

  ListView showPage() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: Text(
                      clientHomeController.showUsersList[index]['userName'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.mainTextColor,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Text(
                    clientHomeController.showUsersList[index]['debt'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.redColor,
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  onTap: () {
                    clientHomeController.selectUserId(
                      value: clientHomeController.showUsersList[index]['id'].toString(),
                    );
                    Get.to(
                      () => OrdersScreen(
                        userID: clientHomeController.showUsersList[index]['id'].toString(),
                      ),
                    );
                  },
                ),
                CustomButton(
                  onTap: () => FlutterPhoneDirectCaller.callNumber(
                    '+993${clientHomeController.showUsersList[index]['phone']}',
                  ),
                  withIcon: true,
                  backColor: AppColors.lightBlue1Color,
                  textColor: AppColors.blueColor,
                ),
              ],
            ),
          ],
        ),
      ),
      separatorBuilder: (context, index) => const Divider(
        color: AppColors.grey2Color,
      ),
      itemCount: clientHomeController.showUsersList.length,
    );
  }
}

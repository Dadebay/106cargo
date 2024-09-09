// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:kargo_app/src/application/settings_singleton.dart';
import 'package:kargo_app/src/design/app_colors.dart';
import 'package:kargo_app/src/design/custom_icon.dart';
import 'package:kargo_app/src/screens/auth/components/login_components.dart';
import 'package:kargo_app/src/screens/custom_widgets/widgets.dart';
import 'package:kargo_app/src/screens/initial/components/cart_main.dart';
import 'package:kargo_app/src/screens/initial/model/orders_model.dart';
import 'package:kargo_app/src/screens/initial/pages/search_screen.dart';
import 'package:kargo_app/src/screens/initial/providers/initial_controller.dart';
import 'package:kargo_app/src/screens/initial/providers/orders_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final InitialPageController initialPageController = Get.put(InitialPageController());

  final FocusNode _focusNode = FocusNode();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    showNotfi();
    fetchData();
    super.initState();
  }

  dynamic fetchData() async {
    initialPageController.showOrders.clear();
    initialPageController.page.value = 1;
    initialPageController.loading.value = 0;
    await OrdersProvider().getOrders(context: context, limit: initialPageController.limit.value, page: initialPageController.page.value);
  }

  dynamic showNotfi() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      if (event.notification!.body != null) {
        fetchData();
        setState(() {});
      }
    });
  }

  Widget showPage(BuildContext context) {
    return Expanded(
      child: Consumer<SettingsSingleton>(
        builder: (_, settings, __) {
          settings.checkAuthStatus();
          if (settings.isAuthenticated == true) {
            return Consumer<OrdersProvider>(
              builder: (_, order, __) {
                if (order.isLoading == true) {
                  return const SpinKitFadingCircle(
                    color: Colors.grey,
                    size: 50.0,
                  );
                } else {
                  return Obx(
                    () {
                      if (initialPageController.loading.value == 0) {
                        return const SpinKitFadingCircle(
                          color: Colors.grey,
                          size: 50.0,
                        );
                      } else if (initialPageController.loading.value == 1) {
                        return hasError();
                      } else if (initialPageController.loading.value == 2) {
                        return emptyData();
                      } else if (initialPageController.showOrders.isEmpty && initialPageController.loading.value == 3) {
                        return emptyData();
                      }
                      return dataComes();
                    },
                  );
                }
              },
            );
          } else {
            return SizedBox(
              height: MediaQuery.of(context).size.height - 210,
              child: const LoginComponents(),
            );
          }
        },
      ),
    );
  }

  Widget emptyData() {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Column(
        children: [
          Center(
            child: Lottie.asset(
              'assets/icons/no_data.json',
              width: MediaQuery.of(context).size.width - 130,
              height: 200,
              fit: BoxFit.fill,
            ),
          ),
          TextButton(
            onPressed: () async {
              fetchData();
              setState(() {});
            },
            child: Text('change_data'.tr()),
          ),
        ],
      ),
    );
  }

  SmartRefresher dataComes() {
    return SmartRefresher(
      footer: footer(false),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      enablePullDown: true,
      enablePullUp: true,
      physics: const BouncingScrollPhysics(),
      header: const MaterialClassicHeader(
        color: AppColors.blueColor,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: initialPageController.showOrders.length,
        itemBuilder: (BuildContext context, int index) {
          final TripModel modelll = TripModel(
            id: int.parse(initialPageController.showOrders[index]['id'].toString()),
            date: initialPageController.showOrders[index]['date'],
            pointFrom: initialPageController.showOrders[index]['point_from'],
            pointTo: initialPageController.showOrders[index]['point_to'],
            trackCode: initialPageController.showOrders[index]['track_code'] ?? '',
            summarySeats: int.parse(initialPageController.showOrders[index]['summary_seats'].toString()),
            ticketCode: initialPageController.showOrders[index]['ticket_code'] ?? '',
            location: initialPageController.showOrders[index]['location'],
            points: initialPageController.showOrders[index]['points'],
            transportNumber: initialPageController.showOrders[index]['transport_number'],
            summaryKg: initialPageController.showOrders[index]['summary_kg'],
            summaryCube: initialPageController.showOrders[index]['summary_cube'],
            summaryPrice: initialPageController.showOrders[index]['summary_price'],
            danhaoCode: initialPageController.showOrders[index]['danhao_code'],
          );
          return Padding(
            padding: const EdgeInsets.all(5),
            child: CartMain(
              model: modelll,
              // model: order.orders[index],
            ),
          );
        },
      ),
    );
  }

  PreferredSize appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(55),
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
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          backgroundColor: Colors.white,
          toolbarHeight: 50,
          automaticallyImplyLeading: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  right: 0,
                  bottom: 10,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SearchScreen(
                          focusNode: _focusNode,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width - 32,
                    decoration: BoxDecoration(
                      color: AppColors.searchColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 22),
                          child: CustomIcon(
                            title: 'assets/icons/searchnormal1.svg',
                            height: 20,
                            width: 20,
                            color: AppColors.profilColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'search'.tr(),
                            style: const TextStyle(
                              color: AppColors.profilColor,
                              fontSize: 14,
                              fontFamily: 'Rubik',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
    initialPageController.showOrders.clear();

    initialPageController.page.value = 1;
    initialPageController.loading.value = 0;
    await OrdersProvider().getOrders(context: context, limit: initialPageController.limit.value, page: initialPageController.page.value);
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.loadComplete();
    initialPageController.page.value += 1;
    await OrdersProvider().getOrders(context: context, limit: initialPageController.limit.value, page: initialPageController.page.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: appBar(context),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: Image.asset(
              'assets/images/cargo_anim.gif',
              fit: BoxFit.fill,
            ),
          ),
          showPage(
            context,
          ),
        ],
      ),
    );
  }
}

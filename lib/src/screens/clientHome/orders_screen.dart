// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:kargo_app/src/design/app_colors.dart';
import 'package:kargo_app/src/screens/clientHome/clientHome_controller.dart';
import 'package:kargo_app/src/screens/clientHome/components/clientId_card.dart';
import 'package:kargo_app/src/screens/clientHome/data/models/getOneOrder_model.dart';
import 'package:kargo_app/src/screens/clientHome/data/services/getOneOrder_service.dart';
import 'package:kargo_app/src/screens/clientHome/tolegler_page.dart';
import 'package:kargo_app/src/screens/custom_widgets/custom_appbar.dart';
import 'package:kargo_app/src/screens/custom_widgets/widgets.dart';
import 'package:kargo_app/src/screens/initial/components/cart_main.dart';
import 'package:kargo_app/src/screens/initial/model/orders_model.dart' as prefix;

class OrdersScreen extends StatefulWidget {
  final String userID;
  const OrdersScreen({
    required this.userID,
    Key? key,
  }) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final ClientHomeController _clientHomeController = Get.put(ClientHomeController());
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.searchColor,
      appBar: CustomAppBar(
        title: selectedIndex == 0 ? 'Sargytlar' : 'Tölegler',
        backButton: true,
      ),
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
          await GetOneOrderService().getPaymentHistory();
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
      body: page1(widget.userID),
    );
  }

  FutureBuilder<List<dynamic>> page1(String userId) {
    return FutureBuilder<List<dynamic>>(
      future: Future.wait([
        GetOneOrderService().fetchOneOrderFromFilter(
          userId: userId,
          ticketID: [],
          controller: '',
          controller1: '',
        ),
        GetOneOrderService().fetchUserData(userId: userId),
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loading();
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error fetching data: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData) {
          return const Center(
            child: Text('No data available'),
          );
        }
        _clientHomeController.showOrderIDList.clear();
        final List<Datum> list = snapshot.data![0];

        _clientHomeController.showOrderIDList.addAll(list);
        final User user = snapshot.data![1];

        return selectedIndex == 0 ? pagee(user) : Tolegler();
      },
    );
  }

  ListView pagee(User user) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(18.0).copyWith(top: 0),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ClientIdCard(user: user),
        ),
        Obx(() {
          if (_clientHomeController.loadingOrders.value == 0) {
            return loading();
          } else if (_clientHomeController.showOrderIDList.isEmpty && _clientHomeController.loadingOrders.value == 2 ||
              _clientHomeController.showOrderIDList.isEmpty && _clientHomeController.loadingOrders.value == 1) {
            return emptyDataMine();
          } else {
            return ListView.builder(
              itemCount: _clientHomeController.showOrderIDList.length + 1,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                if (_clientHomeController.showOrderIDList.length == index) {
                  return const SizedBox(
                    height: 200,
                    width: double.infinity,
                  );
                } else {
                  final Datum a = _clientHomeController.showOrderIDList[index];
                  final List<prefix.Point> points = [];
                  a.points?.forEach((element) {
                    points.add(prefix.Point(point: element.point ?? '', isCurrent: element.isCurrent ?? 0, date: element.date ?? ''));
                  });
                  final prefix.TripModel model = prefix.TripModel(
                    id: a.id ?? 0,
                    date: a.date ?? '',
                    pointFrom: a.pointFrom ?? ' ',
                    pointTo: a.pointTo ?? ' ',
                    trackCode: a.trackCode ?? ' ',
                    danhaoCode: a.danhaoCode ?? ' ',
                    transportNumber: a.transportNumber ?? ' ',
                    summarySeats: a.summarySeats ?? 0,
                    summaryCube: a.summaryCube ?? ' ',
                    summaryKg: a.summaryKg ?? ' ',
                    summaryPrice: a.summaryPrice ?? ' ',
                    ticketCode: a.ticketCode ?? ' ',
                    location: a.location ?? ' ',
                    points: points,
                    images: a.images ?? [],
                  );
                  return CartMain(model: model);
                }
              },
            );
          }
        }),
      ],
    );
  }
}

// ignore_for_file: avoid_print, library_prefixes

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getWidget;
import 'package:kargo_app/src/screens/initial/providers/initial_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../design/constants.dart';
import '../model/orders_model.dart';

class OrdersProvider with ChangeNotifier {
  bool isLoading = false;
  bool waiting = false;
  List<TripModel> orders = [];
  List<TripModel> pointsget = [];
  final InitialPageController initialPageController = getWidget.Get.put(InitialPageController());

  static Dio dio = Dio();

  Future<void> getOrders({
    required int page,
    required int limit,
    required BuildContext context,
  }) async {
    isLoading = true;
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? val = preferences.getString('token');

    orders = [];
    pointsget = [];
    final headers = {
      'Authorization': 'Bearer $val',
    };

    try {
      final response = await dio.get(
        '${Constants.baseUrl}/cargo/list?per_page=$limit&page=$page',
        options: Options(
          headers: headers
            ..addAll(
              {
                // ignore: use_build_context_synchronously
                'Accept-Language': context.locale.languageCode,
              },
            ),
        ),
      );

      if (response.statusCode == 200) {
        if (response.data != null) {
          orders = List<TripModel>.from(
            response.data['data'].map((e) {
              return TripModel.fromJson(e);
            }),
          );
          isLoading = false;
          for (var item in orders) {
            if (item.points != null) {
              pointsget.add(item);
            }
          }
          // pointsget = List<Point>.from(response.data['data']['points'].map((e) {
          //   return Point.fromJson(e);
          // }));
          isLoading = false;
          notifyListeners();
          initialPageController.loading.value = 3;
          for (var a in orders) {
            final bool exists = initialPageController.showOrders.any((item) => item['id'] == a.id);
            if (!exists) {
              initialPageController.showOrders.add({
                'id': a.id.toString(),
                'date': a.date.toString(),
                'point_from': a.pointFrom,
                'point_to': a.pointTo,
                'track_code': a.trackCode,
                'transport_number': a.transportNumber,
                'summary_seats': a.summarySeats,
                'summary_kg': a.summaryKg,
                'summary_cube': a.summaryCube,
                'summary_price': a.summaryPrice,
                'ticket_code': a.ticketCode,
                'danhao_code': a.danhaoCode,
                'location': a.location,
                'points': a.points,
              });
            }
          }
        } else {
          initialPageController.loading.value = 2;
          return;
        }

        return;
      }
      // ignore: deprecated_member_use
    } on DioException catch (e) {
      isLoading = true;
      if (e.response != null) {}
      if (e.response != null) {}
      notifyListeners();
      initialPageController.loading.value = 1;
    }
    return;
  }
}

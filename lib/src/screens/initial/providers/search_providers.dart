// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../application/settings_singleton.dart';
import '../../../design/constants.dart';
import '../model/orders_model.dart';

class SearchProvider2 with ChangeNotifier {
  bool isLoading = false;
  List<TripModel> orders = [];

  static Dio dio = Dio();

  Future<void> getOrders(BuildContext context) async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // String? val = preferences.getString('token');
    orders = [];

    // final headers = {
    //   'Authorization': 'Bearer $val',
    // };

    try {
      final response = await dio.get(
        '${Constants.baseUrl}/cargo/track-code/search/',
        options: Options(
          headers: {
            'Accept-Language': SettingsSingleton().locale.languageCode,
          },
        ),
      );
      isLoading = true;
      if (response.statusCode == 200) {
        if (response.data != null) {
          orders = List<TripModel>.from(
            response.data['data'].map((e) {
              return TripModel.fromJson(e);
            }),
          );
          isLoading = false;
          notifyListeners();
        }

        return;
      }
      // ignore: deprecated_member_use
    } on DioError {
      isLoading = true;

      notifyListeners();
    }
    return;
  }
}

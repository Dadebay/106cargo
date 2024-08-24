import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../application/settings_singleton.dart';
import '../../../design/constants.dart';
import '../model/invoice_model.dart';

class InvoiceProvider with ChangeNotifier {
  bool isLoading = false;
  Shipment? invoice;

  static Dio dio = Dio();

  Future<void> getInvoice(BuildContext context, int id) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? val = preferences.getString('token');
    isLoading = true;
    final headers = {
      'Authorization': 'Bearer $val',
    };

    try {
      final response = await dio.get(
        '${Constants.baseUrl}/cargo/invoice/$id',
        options: Options(
          headers: headers
            ..addAll(
              {
                'Accept-Language': SettingsSingleton().locale.languageCode,
              },
            ),
        ),
      );
      isLoading = true;
      if (response.statusCode == 200) {
        if (response.data != null) {
          invoice = Shipment.fromJson(response.data['data']);

          isLoading = false;
          notifyListeners();
        }

        return;
      }
      // ignore: deprecated_member_use
    } on DioError {
      isLoading = false;

      notifyListeners();
    }
    return;
  }
}

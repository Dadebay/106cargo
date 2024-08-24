// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../design/constants.dart';
import '../model/me_model.dart';

class GetMeProvider with ChangeNotifier {
  bool isLoading = false;
  UserData? getMe;

  static Dio dio = Dio();

  Future<void> getMeResponse(BuildContext context) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? val = preferences.getString('token');
    final headers = {
      'Authorization': 'Bearer $val',
    };

    try {
      final response = await dio.get(
        '${Constants.baseUrl}/auth/me',
        options: Options(
          headers: headers
            ..addAll(
              {
                'Accept-Language': context.locale.languageCode,
              },
            ),
        ),
      );
      isLoading = true;

      if (response.statusCode == 200) {
        if (response.data != null) {
          getMe = UserData.fromJson(response.data['data']);
        }

        isLoading = false;
        notifyListeners();
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

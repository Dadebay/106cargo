// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../bottom_nav/bottom_nav_screen.dart';
import '../../../design/constants.dart';

class TicketsRepository {
  String? tokens;
  bool isLoading = false;
  static Dio dio = Dio();

  Future<void> tickedId(BuildContext context, int id) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? val = preferences.getString('token');

    final headers = {
      'Authorization': 'Bearer $val',
      'Content-Type': 'application/json',
    };
    try {
      final response = await dio.post(
        '${Constants.baseUrl}/cargo/add/ticket/$id',
        // data: jsonEncode({"phone": phone, "password": password}),
        options: Options(headers: headers),
      );
      isLoading = true;

      if (response.statusCode == 200) {
        isLoading = false;

        await Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const BottomNavScreen()),
          (route) => false,
        );

        return;
      }
      // ignore: deprecated_member_use
    } on DioError {
      isLoading = false;
    }
    return;
  }
}

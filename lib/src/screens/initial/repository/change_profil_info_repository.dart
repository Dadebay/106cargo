// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../bottom_nav/bottom_nav_screen.dart';
import '../../../design/constants.dart';

class ChangePInfoRepositorys {
  bool isLoading = false;
  static Dio dio = Dio();

  Future<void> saveInfo(
    BuildContext context,
    int id,
    String firstName,
    String lastName,
    String phone,
    String password,
    String passwordConfirmation,
  ) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? val = preferences.getString('token');

    final headers = {
      'Authorization': 'Bearer $val',
      'Accept': 'application/json',
    };

    try {
      final response = await dio.put(
        '${Constants.baseUrl}/auth/update',
        data: jsonEncode({
          'id': id,
          'first_name': firstName,
          'last_name': lastName,
          'phone': phone,
          'password': password,
          'password_confirmation': passwordConfirmation,
        }),
        options: Options(headers: headers),
      );

      isLoading = true;

      if (response.statusCode == 200) {
        isLoading = false;

        await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const BottomNavScreen()),
        );

        return;
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      isLoading = false;

      if (e.response != null) {
        final snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            e.response!.data['message'],
            style: const TextStyle(color: Colors.white),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
    return;
  }
}

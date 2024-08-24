// ignore_for_file: use_build_context_synchronously, sdk_version_since

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kargo_app/src/screens/clientHome/clientHome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../bottom_nav/bottom_nav_screen.dart';
import '../../../design/constants.dart';

class LoginRepository with ChangeNotifier {
  String? tokens;
  bool isLoading = false;
  static Dio dio = Dio();
  String? errorMessage;

  Future<bool> login(
    BuildContext context,
    String phone,
    String password,
  ) async {
    isLoading = true;
    try {
      notifyListeners();

      final response = await dio.post(
        '${Constants.baseUrl}/auth/login',
        data: jsonEncode({'phone': phone, 'password': password}),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      print(response.data);
      print(response.statusCode);
      notifyListeners();

      if (response.statusCode == 200) {
        isLoading = false;
        final SharedPreferences preferences = await SharedPreferences.getInstance();

        tokens = response.data!['data']['token'];
        await preferences.setString('token', tokens!);
        await preferences.setBool('is_collector', response.data['data']['user']['is_collector']!);

        notifyListeners();
        final bool isCollector = bool.parse(response.data['data']['user']['is_collector'].toString());
        if (isCollector) {
          await Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => const ClientHomeScreen(),
            ),
          );
        } else {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const BottomNavScreen(),
            ),
          );
        }
        return response.data['data']['user']['is_collector'];
      } else {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const BottomNavScreen(),
          ),
        );
        return false;
      }
    } on DioException catch (e) {
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
        notifyListeners();
      }

      notifyListeners();
    }
    return false;
  }
}

class LogOutRepository {
  bool isLoading = false;
  static Dio dio = Dio();

  Future<void> logOut(
    BuildContext context,
    String tokens,
  ) async {
    final headers = {
      'Authorization': 'Bearer $tokens',
    };
    try {
      final response = await dio.post(
        '${Constants.baseUrl}/auth/logout',
        options: Options(headers: headers),
      );
      isLoading = true;

      if (response.statusCode == 200) {
        isLoading = false;
        final SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.remove('token');
        await Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const BottomNavScreen(),
          ),
          (route) => false,
        );
        return;
      }
    } on DioException {
      isLoading = false;
    }
    return;
  }
}

// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:kargo_app/src/design/constants.dart';
import 'package:kargo_app/src/screens/clientHome/clientHome_controller.dart';
import 'package:kargo_app/src/screens/clientHome/data/models/getOneOrder_model.dart';
import 'package:kargo_app/src/screens/custom_widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetOneOrderService {
  final Dio dio = Dio();
  final ClientHomeController _clientHomeController = Get.put(ClientHomeController());

  Future<List<Datum>> fetchOneOrder({required String userId, required List ticketID}) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? token = preferences.getString('token');
    final String oneOrderUrl = '${Constants.baseUrl}/collector/fetch-user-debt/$userId?ticket_id=$ticketID&per_page=50&page=1';
    print(oneOrderUrl);
    try {
      final headers = {'User-Agent': 'application/json', 'Accept': 'application/json', 'Authorization': 'Bearer $token'};

      final response = await dio.get(
        oneOrderUrl,
        options: Options(
          headers: headers,
        ),
      );
      print(response.data);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        _clientHomeController.totalDebt.value = response.data['user']['total_debt'].toString();
        return data.map((e) => Datum.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Error fetching order: $e');
    }
  }

  Future<bool> deletePayment({required String id}) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? token = preferences.getString('token');
    const String regionUrl = '${Constants.baseUrl}/collector/delete-payment';

    try {
      final headers = {
        'User-Agent': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await dio.post(
        regionUrl,
        data: {
          'payment_id': id,
        },
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        showSnackBar('Pozuldy', 'Töleg pozuldy', Colors.green);
        return true;
      } else {
        showSnackBar('Ýalňyşlyk', 'Ýalňyşlyk ýüze çykdy täzeden deňäp görüň', Colors.red);

        return false;
      }
    } catch (e) {
      showSnackBar('Ýalňyşlyk', 'Ýalňyşlyk ýüze çykdy täzeden deňäp görüň', Colors.red);
      return false;
    }
  }

  Future<List<Datum>> fetchOneOrderFromFilter({required String userId, required String ticketID, required String controller, required String controller1}) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? token = preferences.getString('token');
    final String oneOrderUrl = '${Constants.baseUrl}/collector/fetch-user-debt/$userId?ticket_id=$ticketID&from_transport_id=$controller&to_transport_id=$controller1&per_page=50&page=1';
    print(oneOrderUrl);

    try {
      final headers = {'User-Agent': 'application/json', 'Accept': 'application/json', 'Authorization': 'Bearer $token'};

      final response = await dio.get(
        oneOrderUrl,
        options: Options(
          headers: headers,
        ),
      );

      log(response.data.toString());
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        _clientHomeController.totalDebt.value = response.data['user']['total_debt'].toString();

        return data.map((e) => Datum.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Error fetching order: $e');
    }
  }

  final ClientHomeController clientHomeController = Get.put(ClientHomeController());

  Future<List<PaymentModel>> getPaymentMethod({
    required String dateFrom,
    required String dateTo,
    required String ticket_search,
    required String from_transport_id,
    required String to_transport_id,
  }) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? token = preferences.getString('token');
    final String oneOrderUrl =
        '${Constants.baseUrl}/collector/get-payment-history?date_from=$dateFrom&date_to=$dateTo&ticket_search=$ticket_search&from_transport_id=$from_transport_id&to_transport_id=$to_transport_id';

    try {
      final headers = {'User-Agent': 'application/json', 'Accept': 'application/json', 'Authorization': 'Bearer $token'};

      final response = await dio.get(
        oneOrderUrl,
        options: Options(
          headers: headers,
        ),
      );
      print(response.data);

      clientHomeController.paymentHistory.clear();
      if (response.statusCode == 200) {
        clientHomeController.sumPaid.value = response.data['sum_paid'];

        for (var e in response.data['data'].map((e) => PaymentModel.fromJson(e as Map<String, dynamic>)).toList()) {
          clientHomeController.paymentHistory.add(e);
        }
        return [];
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Error fetching order: $e');
    }
  }

  Future<List<PaymentModel>> getPaymentDateSearch({
    required String dateFrom,
    required String dateTo,
  }) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? token = preferences.getString('token');
    final String oneOrderUrl = '${Constants.baseUrl}/collector/get-payment-history?date_from=$dateFrom&date_to=$dateTo';

    try {
      final headers = {'User-Agent': 'application/json', 'Accept': 'application/json', 'Authorization': 'Bearer $token'};

      final response = await dio.get(
        oneOrderUrl,
        options: Options(
          headers: headers,
        ),
      );
      print(response.data);

      clientHomeController.paymentHistory.clear();
      if (response.statusCode == 200) {
        clientHomeController.sumPaid.value = response.data['sum_paid'];

        for (var e in response.data['data'].map((e) => PaymentModel.fromJson(e as Map<String, dynamic>)).toList()) {
          clientHomeController.paymentHistory.add(e);
        }
        return [];
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Error fetching order: $e');
    }
  }

  Future<List<PaymentModel>> getPaymentHistory() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? token = preferences.getString('token');
    const String oneOrderUrl = '${Constants.baseUrl}/collector/get-payment-history';

    try {
      final headers = {'User-Agent': 'application/json', 'Accept': 'application/json', 'Authorization': 'Bearer $token'};

      final response = await dio.get(
        oneOrderUrl,
        options: Options(
          headers: headers,
        ),
      );
      clientHomeController.paymentHistory.clear();
      print(response.data);
      if (response.statusCode == 200) {
        clientHomeController.sumPaid.value = response.data['sum_paid'];
        for (var e in response.data['data'].map((e) => PaymentModel.fromJson(e as Map<String, dynamic>)).toList()) {
          clientHomeController.paymentHistory.add(e);
        }

        return [];
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Error fetching order: $e');
    }
  }

// {{cargo_l}}
  Future<User> fetchUserData({required String userId}) async {
    final String oneOrderUrl = '${Constants.baseUrl}/collector/fetch-user-debt/$userId&per_page=50&page=1';
    try {
      final headers = {'User-Agent': 'application/json', 'Accept': 'application/json', 'Authorization': 'Bearer 1704|vwLSM4Nda8e7IFHy9X0rMa7ixgnvDKfH8xWmdUZz6b3b4b3d'};

      final response = await dio.get(
        oneOrderUrl,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data['user'];
        return User.fromJson(data);
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      throw Exception('Error fetching order: $e');
    }
  }
}

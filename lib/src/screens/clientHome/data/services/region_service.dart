import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getWidget;
import 'package:kargo_app/src/design/constants.dart';
import 'package:kargo_app/src/screens/clientHome/clientHome_controller.dart';
import 'package:kargo_app/src/screens/clientHome/data/models/region_model.dart';
import 'package:kargo_app/src/screens/custom_widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegionService {
  final Dio dio = Dio();

  Future<bool> payOneCargoPOST({required String id, required String amount}) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? token = preferences.getString('token');
    const String regionUrl = '${Constants.baseUrl}/collector/pay-one-cargo';

    try {
      final headers = {
        'User-Agent': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await dio.post(
        regionUrl,
        data: {
          'cargo_id': id,
          'payment_amount': amount,
        },
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        showSnackBar('Tölendi', 'Tölegiňiz tassyklandy', Colors.green);
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

  Future<bool> payManyCargoPOST({required String id, required String urlParams}) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? token = preferences.getString('token');
    const String regionUrl = '${Constants.baseUrl}/collector/pay-many-cargo';

    try {
      final headers = {
        'User-Agent': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await dio.post(
        regionUrl,
        data: {
          'user_id': id,
          'url_params': urlParams,
        },
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        showSnackBar('Tölendi', 'Tölegiňiz tassyklandy', Colors.green);
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

  Future<List<Datum>> fetchRegion({
    required String id,
    required int page,
    required int limit,
  }) async {
    final ClientHomeController clientHomeController = getWidget.Get.put(ClientHomeController());

    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? token = preferences.getString('token');
    final String regionUrl = '${Constants.baseUrl}/collector/debt-list?region_id=$id&per_page=$limit&page=$page';
    try {
      final headers = {
        'User-Agent': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final Response response = await dio.get(
        regionUrl,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        clientHomeController.loading.value = 3;
        final List<dynamic> data = response.data['data'];
        for (final Map product in data) {
          final bool exists = clientHomeController.showUsersList.any((item) => item['id'] == product['id']);
          if (!exists) {
            clientHomeController.showUsersList.add({
              'id': product['id'],
              'userName': product['user_name'],
              'debt': product['debt'],
              'phone': product['phone'],
            });
          }
        }
        return data.map((e) => Datum.fromJson(e)).toList();
      } else {
        clientHomeController.loading.value = 1;
        return [];
      }
    } catch (e) {
      throw Exception('Error fetching regions: $e');
    }
  }

  Future<List<Datum>> fetchRegionSearch({
    required String id,
    required String search,
    required int page,
    required int limit,
  }) async {
    final ClientHomeController clientHomeController = getWidget.Get.put(ClientHomeController());

    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? token = preferences.getString('token');
    final String regionUrl = '${Constants.baseUrl}/collector/debt-list?region_id=$id&per_page=$limit&page=$page&search=$search';
    print(regionUrl);
    print(token);

    try {
      final headers = {
        'User-Agent': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final Response response = await dio.get(
        regionUrl,
        options: Options(
          headers: headers,
        ),
      );
      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        clientHomeController.loading.value = 3;
        final List<dynamic> data = response.data['data'];
        for (final Map product in data) {
          final bool exists = clientHomeController.showUsersList.any((item) => item['id'] == product['id']);
          if (!exists) {
            clientHomeController.showUsersList.add({
              'id': product['id'],
              'userName': product['user_name'],
              'debt': product['debt'],
              'phone': product['phone'],
            });
          }
        }
        return data.map((e) => Datum.fromJson(e)).toList();
      } else {
        clientHomeController.loading.value = 1;
        return [];
      }
    } catch (e) {
      throw Exception('Error fetching regions: $e');
    }
  }
}

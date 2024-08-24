// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:kargo_app/src/design/constants.dart';
import 'package:kargo_app/src/screens/clientHome/data/models/meRegions_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MeRegionService {
  final Dio dio = Dio();

  Future<List<Point>> fetchRegionNames() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? token = preferences.getString('token');
    const String regionUrl = '${Constants.baseUrl}/auth/me';

    try {
      final headers = {
        'User-Agent': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await dio.get(
        regionUrl,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        if (response.data['data'] != null && response.data['data']['points'] is List) {
          final List<Point> data = (response.data['data']['points'] as List).map((item) => Point.fromJson(item)).toList();
          return data;
        } else {
          throw Exception('Invalid data format');
        }
      } else {
        throw Exception('Failed to load regions');
      }
    } catch (e) {
      throw Exception('Error fetching regions: $e');
    }
  }
}

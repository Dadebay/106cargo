// ignore_for_file: file_names

import 'dart:convert';

class MeRegionsModel {
  final bool? success;
  final Data? data;

  MeRegionsModel({
    this.success,
    this.data,
  });

  factory MeRegionsModel.fromRawJson(String str) => MeRegionsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MeRegionsModel.fromJson(Map<String, dynamic> json) => MeRegionsModel(
        success: json['success'],
        data: json['data'] == null ? null : Data.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data?.toJson(),
      };
}

class Data {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final bool? isCollector;
  final List<Point>? points;

  Data({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.isCollector,
    this.points,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        phone: json['phone'],
        isCollector: json['is_collector'],
        points: json['points'] == null ? [] : List<Point>.from(json['points']!.map((x) => Point.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'first_name': firstName,
        'last_name': lastName,
        'phone': phone,
        'is_collector': isCollector,
        'points': points == null ? [] : List<dynamic>.from(points!.map((x) => x.toJson())),
      };
}

class Point {
  final int? id;
  final String? name;

  Point({
    this.id,
    this.name,
  });

  factory Point.fromRawJson(String str) => Point.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Point.fromJson(Map<String, dynamic> json) => Point(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}

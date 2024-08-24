import 'dart:convert';

class RegionModel {
  final List<Datum>? data;
  final Links? links;
  final Meta? meta;

  RegionModel({
    this.data,
    this.links,
    this.meta,
  });

  factory RegionModel.fromRawJson(String str) =>
      RegionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegionModel.fromJson(Map<String, dynamic> json) => RegionModel(
        data: json['data'] == null
            ? []
            : List<Datum>.from(json['data']!.map((x) => Datum.fromJson(x))),
        links: json['links'] == null ? null : Links.fromJson(json['links']),
        meta: json['meta'] == null ? null : Meta.fromJson(json['meta']),
      );

  Map<String, dynamic> toJson() => {
        'data': data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        'links': links?.toJson(),
        'meta': meta?.toJson(),
      };
}

class Datum {
  final int? id;
  final String? userName;
  final String? phone;
  final String? debt;

  Datum({
    this.id,
    this.userName,
    this.phone,
    this.debt,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'],
        userName: json['user_name'],
        phone: json['phone'],
        debt: json['debt'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_name': userName,
        'phone': phone,
        'debt': debt,
      };
}

class Links {
  final String? first;
  final String? last;
  final dynamic prev;
  final String? next;

  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory Links.fromRawJson(String str) => Links.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json['first'],
        last: json['last'],
        prev: json['prev'],
        next: json['next'],
      );

  Map<String, dynamic> toJson() => {
        'first': first,
        'last': last,
        'prev': prev,
        'next': next,
      };
}

class Meta {
  final int? currentPage;
  final int? from;
  final int? lastPage;
  final List<Link>? links;
  final String? path;
  final int? perPage;
  final int? to;
  final int? total;

  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json['current_page'],
        from: json['from'],
        lastPage: json['last_page'],
        links: json['links'] == null
            ? []
            : List<Link>.from(json['links']!.map((x) => Link.fromJson(x))),
        path: json['path'],
        perPage: json['per_page'],
        to: json['to'],
        total: json['total'],
      );

  Map<String, dynamic> toJson() => {
        'current_page': currentPage,
        'from': from,
        'last_page': lastPage,
        'links': links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        'path': path,
        'per_page': perPage,
        'to': to,
        'total': total,
      };
}

class Link {
  final String? url;
  final String? label;
  final bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromRawJson(String str) => Link.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json['url'],
        label: json['label'],
        active: json['active'],
      );

  Map<String, dynamic> toJson() => {
        'url': url,
        'label': label,
        'active': active,
      };
}

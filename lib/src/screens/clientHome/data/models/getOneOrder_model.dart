// ignore_for_file: file_names

import 'dart:convert';

class RegionModel {
  final List<Datum>? data;
  final Links? links;
  final Meta? meta;
  final User? user;

  RegionModel({
    this.data,
    this.links,
    this.meta,
    this.user,
  });

  factory RegionModel.fromRawJson(String str) => RegionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegionModel.fromJson(Map<String, dynamic> json) => RegionModel(
        data: json['data'] == null ? [] : List<Datum>.from(json['data']!.map((x) => Datum.fromJson(x))),
        links: json['links'] == null ? null : Links.fromJson(json['links']),
        meta: json['meta'] == null ? null : Meta.fromJson(json['meta']),
        user: json['user'] == null ? null : User.fromJson(json['user']),
      );

  Map<String, dynamic> toJson() => {
        'data': data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        'links': links?.toJson(),
        'meta': meta?.toJson(),
        'user': user?.toJson(),
      };
}

class Datum {
  final int? id;
  final String? date;
  final String? pointFrom;
  final String? pointTo;
  final String? trackCode;
  final String? danhaoCode;
  final dynamic transportNumber;
  final int? summarySeats;
  final String? summaryCube;
  final String? summaryKg;
  final String? summaryPrice;
  final String? summaryPaid;
  final String? ticketCode;
  final List<String>? images;
  final List<dynamic>? transportImages;
  final String? location;
  final List<Point>? points;

  Datum({
    this.id,
    this.date,
    this.pointFrom,
    this.pointTo,
    this.trackCode,
    this.danhaoCode,
    this.transportNumber,
    this.summarySeats,
    this.summaryCube,
    this.summaryKg,
    this.summaryPrice,
    this.summaryPaid,
    this.ticketCode,
    this.images,
    this.transportImages,
    this.location,
    this.points,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? pointsJson = json['points'];
    List<Point>? points;
    if (pointsJson != null) {
      points = pointsJson.map((pointJson) => Point.fromJson(pointJson)).toList();
    }
    return Datum(
      id: json['id'],
      date: json['date'],
      pointFrom: json['point_from'],
      pointTo: json['point_to'],
      trackCode: json['track_code'],
      danhaoCode: json['danhao_code'],
      transportNumber: json['transport_number'],
      summarySeats: json['summary_seats'],
      summaryCube: json['summary_cube'],
      summaryKg: json['summary_kg'],
      summaryPrice: json['summary_price'],
      summaryPaid: json['summary_paid'],
      ticketCode: json['ticket_code'],
      images: json['images'] == null ? [] : List<String>.from(json['images']!.map((x) => x)),
      transportImages: json['transport_images'] == null ? [] : List<dynamic>.from(json['transport_images']!.map((x) => x)),
      location: json['location'],
      points: points ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'point_from': pointFrom,
        'point_to': pointTo,
        'track_code': trackCode,
        'danhao_code': danhaoCode,
        'transport_number': transportNumber,
        'summary_seats': summarySeats,
        'summary_cube': summaryCube,
        'summary_kg': summaryKg,
        'summary_price': summaryPrice,
        'summary_paid': summaryPaid,
        'ticket_code': ticketCode,
        'images': images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        'transport_images': transportImages == null ? [] : List<dynamic>.from(transportImages!.map((x) => x)),
        'location': location,
        'points': points == null ? [] : List<dynamic>.from(points!.map((x) => x.toJson())),
      };
}

class Point {
  final String? point;
  final int? isCurrent;
  final String? date;

  Point({
    this.point,
    this.isCurrent,
    this.date,
  });

  factory Point.fromRawJson(String str) => Point.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Point.fromJson(Map<String, dynamic> json) => Point(
        point: json['point'],
        isCurrent: json['is_current'],
        date: json['date'],
      );

  Map<String, dynamic> toJson() => {
        'point': point,
        'is_current': isCurrent,
        'date': date,
      };
}

class PaymentModel {
  final int? id;
  final int? status;
  final String? ticketCode;
  final String? transport;
  final String? paid;
  final String? createdAT;

  PaymentModel({
    this.createdAT,
    this.id,
    this.status,
    this.ticketCode,
    this.transport,
    this.paid,
  });

  factory PaymentModel.fromRawJson(String str) => PaymentModel.fromJson(json.decode(str));

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        id: json['id'],
        status: json['status'],
        ticketCode: json['ticket_code'],
        transport: json['transport'],
        paid: json['paid'],
        createdAT: json['created_at'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
        'ticket_code': ticketCode,
        'transport': transport,
        'paid': paid,
        'created_at': createdAT,
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
        links: json['links'] == null ? [] : List<Link>.from(json['links']!.map((x) => Link.fromJson(x))),
        path: json['path'],
        perPage: json['per_page'],
        to: json['to'],
        total: json['total'],
      );

  Map<String, dynamic> toJson() => {
        'current_page': currentPage,
        'from': from,
        'last_page': lastPage,
        'links': links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
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

class User {
  final String? userName;
  final String? totalDebt;
  final String? phone;
  final List<Ticket>? tickets;

  User({
    this.userName,
    this.totalDebt,
    this.phone,
    this.tickets,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        userName: json['user_name'],
        totalDebt: json['total_debt'],
        phone: json['phone'],
        tickets: json['tickets'] == null
            ? []
            : List<Ticket>.from(
                json['tickets']!.map((x) => Ticket.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        'user_name': userName,
        'total_debt': totalDebt,
        'phone': phone,
        'tickets': tickets == null ? [] : List<dynamic>.from(tickets!.map((x) => x.toJson())),
      };
}

class Ticket {
  final int? id;
  final String? code;

  Ticket({
    this.id,
    this.code,
  });

  factory Ticket.fromRawJson(String str) => Ticket.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        id: json['id'],
        code: json['code'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
      };
}

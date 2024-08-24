// ignore_for_file: non_constant_identifier_names

class TripDataIdModel {
  final int id;
  final String date;
  final String pointFrom;
  final String pointTo;
  final String trackCode;
  final String transport_number;
  final int summarySeats;
  final List<String> images;
  final String ticketCode;
  final String location;
  final String danhaoCode;
  final List<PointSS> points;

  final dynamic summaryPrice;
  final String summaryKg;
  final String summaryCube;

  TripDataIdModel({
    required this.id,
    required this.date,
    required this.pointFrom,
    required this.pointTo,
    required this.trackCode,
    required this.summarySeats,
    required this.ticketCode,
    required this.transport_number,
    required this.location,
    required this.points,
    required this.images,
    required this.summaryKg,
    required this.summaryCube,
    required this.summaryPrice,
    required this.danhaoCode,
  });

  factory TripDataIdModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> pointsList = json['points'];
    final List<PointSS> points = pointsList.map((pointsList) => PointSS.fromJson(pointsList)).toList();

    return TripDataIdModel(
      id: json['id'] ?? 0,
      date: json['date'] ?? '',
      pointFrom: json['point_from'] ?? '',
      pointTo: json['point_to'],
      trackCode: json['track_code'] ?? '',
      transport_number: json['transport_number'] ?? '',
      summarySeats: json['summary_seats'] ?? 0,
      images: List<String>.from(json['images']),
      ticketCode: json['ticket_code'] ?? '',
      location: json['location'] ?? '',
      summaryKg: json['summary_kg'] ?? '',
      summaryCube: json['summary_cube'] ?? '',
      summaryPrice: json['summary_price'] ?? 0,
      danhaoCode: json['danhao_code'] ?? '',
      points: points,
    );
  }
}

class PointSS {
  final String point;
  final int isCurrent;
  final String date;

  PointSS({
    required this.point,
    required this.isCurrent,
    required this.date,
  });

  factory PointSS.fromJson(Map<String, dynamic> json) {
    return PointSS(
      point: json['point'] ?? '',
      isCurrent: json['is_current'] ?? 0,
      date: json['date'] ?? '',
    );
  }
}

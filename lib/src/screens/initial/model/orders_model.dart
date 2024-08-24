class TripModel {
  final int id;
  final String date;
  final String pointFrom;
  final String pointTo;
  final String trackCode;
  final String transportNumber;
  final int summarySeats;
  final dynamic summaryPrice;
  final String summaryKg;
  final String summaryCube;
  final String ticketCode;
  final String danhaoCode;
  final String location;
  final List<Point>? points;
  final List<String>? images;

  TripModel({
    required this.id,
    required this.date,
    required this.pointFrom,
    required this.pointTo,
    required this.trackCode,
    required this.transportNumber,
    required this.summarySeats,
    required this.ticketCode,
    required this.location,
    required this.summaryKg,
    required this.summaryCube,
    required this.summaryPrice,
    required this.danhaoCode,
    this.points,
    this.images,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? pointsJson = json['points'];
    List<Point>? points;
    if (pointsJson != null) {
      points = pointsJson.map((pointJson) => Point.fromJson(pointJson)).toList();
    }
    return TripModel(
      id: json['id'] ?? 0,
      date: json['date'] ?? '',
      pointFrom: json['point_from'] ?? '',
      pointTo: json['point_to'] ?? '',
      trackCode: json['track_code'] ?? '',
      transportNumber: json['transport_number'] ?? '',
      summarySeats: json['summary_seats'] ?? 0,
      summaryKg: json['summary_kg'] ?? '',
      summaryCube: json['summary_cube'] ?? '',
      summaryPrice: json['summary_price'] ?? 0,
      images: json['images'] == null ? [] : List<String>.from(json['images']!.map((x) => x)),
      ticketCode: json['ticket_code'] ?? '',
      danhaoCode: json['danhao_code'] ?? '',
      location: json['location'] ?? '',
      points: points ?? [],
    );
  }
}

class Point {
  final String point;
  final int isCurrent;
  final String date;

  Point({
    required this.point,
    required this.isCurrent,
    required this.date,
  });

  factory Point.fromJson(Map<String, dynamic> json) {
    return Point(
      point: json['point'] ?? '',
      isCurrent: json['is_current'] ?? 0,
      date: json['date'] ?? '',
    );
  }
}

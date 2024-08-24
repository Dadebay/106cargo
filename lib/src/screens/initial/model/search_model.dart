class SearchModel {
  final int id;
  final String date;
  final String pointFrom;
  final String pointTo;
  final String trackCode;
  final int summarySeats;
  final dynamic summaryPrice;
  final dynamic summaryPaid;
  final dynamic totalPayments;
  final String summaryKg;
  final String summaryCube;
  final String ticketCode;
  final String transportNumber;
  final String danhaoCode;
  final List<String>? images;
  final List<String>? transportImages;
  final String location;
  final List<PointSS> points;
  final bool isOwned;

  SearchModel({
    required this.id,
    required this.date,
    required this.pointFrom,
    required this.pointTo,
    required this.trackCode,
    required this.summarySeats,
    required this.ticketCode,
    required this.location,
    required this.transportNumber,
    required this.points,
    required this.images,
    required this.summaryPrice,
    required this.summaryKg,
    required this.summaryCube,
    required this.danhaoCode,
    required this.summaryPaid,
    required this.totalPayments,
    required this.transportImages,
    required this.isOwned,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> pointsList = json['points'];
    final List<PointSS> points =
        pointsList.map((pointsList) => PointSS.fromJson(pointsList)).toList();

    return SearchModel(
      id: json['id'] ?? 0,
      date: json['date'] ?? '',
      pointFrom: json['point_from'] ?? '',
      pointTo: json['point_to'] ?? '',
      trackCode: json['track_code'] ?? '',
      summarySeats: json['summary_seats'] ?? 0,
      ticketCode: json['ticket_code'] ?? '',
      transportNumber: json['transport_number'] ?? '',
      summaryPrice: json['summary_price'] ?? 0,
      summaryKg: json['summary_kg'] ?? 0,
      summaryCube: json['summary_cube'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      location: json['location'] ?? '',
      points: points,
      transportImages: List<String>.from(json['transport_images'] ?? []),
      totalPayments: json['total_payments'] ?? 0,
      summaryPaid: json['summary_paid'] ?? 0,
      danhaoCode: json['danhao_code'] ?? '',
      isOwned: json['is_owned'] ?? false,
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

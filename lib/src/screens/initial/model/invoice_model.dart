// ignore_for_file: non_constant_identifier_names

class Shipment {
  final String date;
  final String providerPhone;
  final String consumptionName;
  final dynamic consumptionPrice;
  final dynamic summarySeats;
  final String summaryKg;
  final String summaryCube;
  final String customersName;
  final String customersPhone;
  final dynamic summaryPrice;
  final String ticketId;
  final String trackCode;
  final String transport_number;
  final String pointFrom;
  final String pointTo;
  final List<ExpensesItem> expenses;
  final List<CargoItem> cargoItems;

  Shipment({
    required this.date,
    required this.providerPhone,
    required this.consumptionName,
    required this.consumptionPrice,
    required this.summarySeats,
    required this.summaryKg,
    required this.customersName,
    required this.customersPhone,
    required this.summaryCube,
    required this.summaryPrice,
    required this.ticketId,
    required this.pointFrom,
    required this.pointTo,
    required this.trackCode,
    required this.transport_number,
    required this.expenses,
    required this.cargoItems,
  });

  factory Shipment.fromJson(Map<String, dynamic> json) {
    final List<dynamic> cargoJson = json['cargo-items'];
    final List<CargoItem> cargoItems = cargoJson.map((item) => CargoItem.fromJson(item)).toList();

    final List<dynamic> expensesJson = json['expenses'];
    final List<ExpensesItem> expensesItems = expensesJson.map((item) => ExpensesItem.fromJson(item)).toList();

    return Shipment(
      date: json['date'] ?? '',
      providerPhone: json['provider_phone'] ?? '',
      consumptionName: json['consumption_name'] ?? '',
      consumptionPrice: json['consumption_price'],
      summarySeats: json['summary_seats'],
      customersPhone: json['customers_phone'],
      customersName: json['customers_name'],
      summaryKg: json['summary_kg'],
      trackCode: json['track_code'] ?? '',
      transport_number: json['transport_number'] ?? '',
      summaryCube: json['summary_cube'],
      summaryPrice: json['summary_price'],
      ticketId: json['ticket_id'],
      pointFrom: json['point_from'],
      pointTo: json['point_to'],
      expenses: expensesItems,
      cargoItems: cargoItems,
    );
  }
}

class CargoItem {
  final String productName;
  final dynamic packingSizeFirst;
  final dynamic packingSizeMiddle;
  final dynamic packingSizeLast;
  final dynamic numberOfSeats;
  final String price;
  final String cube;
  final String kg;
  final dynamic totalPrice;
  final String typePackagingId;

  CargoItem({
    required this.productName,
    required this.packingSizeFirst,
    required this.packingSizeMiddle,
    required this.packingSizeLast,
    required this.numberOfSeats,
    required this.price,
    required this.cube,
    required this.kg,
    required this.totalPrice,
    required this.typePackagingId,
  });

  factory CargoItem.fromJson(Map<String, dynamic> json) {
    return CargoItem(
      productName: json['product_name'] ?? '',
      packingSizeFirst: json['packing_size_first'],
      packingSizeMiddle: json['packing_size_middle'],
      packingSizeLast: json['packing_size_last'],
      numberOfSeats: json['number_of_seats'],
      price: json['price'],
      cube: json['cube'],
      kg: json['kg'] ?? '',
      totalPrice: json['total_price'],
      typePackagingId: json['type_packaging_id'],
    );
  }
}

class ExpensesItem {
  final int id;
  final String name;
  final dynamic price;

  ExpensesItem({
    required this.id,
    required this.name,
    required this.price,
  });

  factory ExpensesItem.fromJson(Map<String, dynamic> json) {
    return ExpensesItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      price: json['price'],
    );
  }
}

class UserData {
  final int id;
  final String firstName;
  final String lastName;
  final String phone;
  final List<Ticket> tickets;

  UserData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.tickets,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    final List<dynamic> ticketsJson = json['tickets'];
    final List<Ticket> tickets = ticketsJson.map((ticketJson) => Ticket.fromJson(ticketJson)).toList();

    return UserData(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      phone: json['phone'] ?? '',
      tickets: tickets,
    );
  }
}

class Ticket {
  final int id;
  final String code;

  Ticket({
    required this.id,
    required this.code,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      code: json['code'],
    );
  }
}

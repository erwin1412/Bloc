class LeaveModel {
  final int? id;
  final DateTime startdate;
  final DateTime enddate;
  final String name;
  final String email;
  final String reason;
  final String status;
  final String note;

  LeaveModel({
    required this.id,
    required this.startdate,
    required this.enddate,
    required this.name,
    required this.email,
    required this.reason,
    required this.status,
    required this.note,
  });

  factory LeaveModel.fromJson(Map<String, dynamic> json) {
    return LeaveModel(
      id: json['id'] ?? 0,
      startdate: json['start_date'] != null
          ? DateTime.parse(json['start_date'])
          : DateTime.now(),
      enddate: json['end_date'] != null
          ? DateTime.parse(json['end_date'])
          : DateTime.now(),
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      reason: json['reason'] ?? '',
      status: json['status'] ?? '',
      note: json['note'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'start_date': startdate.toIso8601String(),
      'end_date': enddate.toIso8601String(),
      'name': name,
      'email': email,
      'note': note,
    };
  }
}

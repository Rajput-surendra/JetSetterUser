class RequestModel {
  RequestModel({
    required this.error,
    required this.message,
    required this.data,
  });

  final bool? error;
  final String? message;
  final List<RequestData> data;

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      error: json["error"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<RequestData>.from(
              json["data"]!.map((x) => RequestData.fromJson(x))),
    );
  }
}

class RequestData {
  RequestData({
    required this.id,
    required this.userId,
    required this.applyType,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.mobile,
    required this.email,
    required this.age,
    required this.photograph,
    required this.type,
    required this.passportType,
    required this.passportFront,
    required this.passportBack,
    required this.amount,
    required this.tId,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  final String? id;
  final String? userId;
  final String? applyType;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? mobile;
  final String? email;
  final String? age;
  final String? photograph;
  final String? type;
  final String? passportType;
  final String? passportFront;
  final String? passportBack;
  final String? amount;
  final String? tId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? status;

  factory RequestData.fromJson(Map<String, dynamic> json) {
    return RequestData(
      status: json['status'],
      id: json["id"],
      userId: json["user_id"],
      applyType: json["apply_type"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      gender: json["gender"],
      mobile: json["mobile"],
      email: json["email"],
      age: json["age"],
      photograph: json["photograph"],
      type: json["type"],
      passportType: json["passport_type"],
      passportFront: json["passport_front"],
      passportBack: json["passport_back"],
      amount: json["amount"],
      tId: json["t_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}

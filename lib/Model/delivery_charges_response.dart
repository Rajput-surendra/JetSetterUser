// To parse this JSON data, do
//
//     final getDeliveryChargeResponse = getDeliveryChargeResponseFromJson(jsonString);

import 'dart:convert';

GetDeliveryChargeResponse getDeliveryChargeResponseFromJson(String str) => GetDeliveryChargeResponse.fromJson(json.decode(str));

String getDeliveryChargeResponseToJson(GetDeliveryChargeResponse data) => json.encode(data.toJson());

class GetDeliveryChargeResponse {
  bool? error;
  String? message;
  List<DeliveryChargeData>? data;

  GetDeliveryChargeResponse({
    this.error,
    this.message,
    this.data,
  });

  factory GetDeliveryChargeResponse.fromJson(Map<String, dynamic> json) => GetDeliveryChargeResponse(
    error: json["error"],
    message: json["message"],
    data: List<DeliveryChargeData>.from(json["data"].map((x) => DeliveryChargeData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DeliveryChargeData {
  String? id;
  String? minimum;
  String? maximum;
  String? deliveryCharge;
  DateTime? createdAt;
  DateTime? updatedAt;

  DeliveryChargeData({
    this.id,
    this.minimum,
    this.maximum,
    this.deliveryCharge,
    this.createdAt,
    this.updatedAt,
  });

  factory DeliveryChargeData.fromJson(Map<String, dynamic> json) => DeliveryChargeData(
    id: json["id"],
    minimum: json["minimum"],
    maximum: json["maximum"],
    deliveryCharge: json["delivery_charge"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "minimum": minimum,
    "maximum": maximum,
    "delivery_charge": deliveryCharge,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

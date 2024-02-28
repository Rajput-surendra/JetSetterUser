import 'package:eshop_multivendor/Model/Order_Model.dart';

class CurrentOrderModel {
  CurrentOrderModel({
    required this.error,
    required this.message,
    required this.data,
  });

  final bool? error;
  final String? message;
  final Data? data;

  factory CurrentOrderModel.fromJson(Map<String, dynamic> json) {
    return CurrentOrderModel(
      error: json["error"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
}

class Data {
  Data({
    required this.id,
    required this.finalTotal,
    required this.activeStatus,
    required this.sellerId,
    required this.sellerName,
    required this.resName,
  });

  final String? id;
  final String? finalTotal;
  final String? activeStatus;
  final String? sellerId;
  final String? sellerName;
  final String? resName;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json["id"],
      finalTotal: json["final_total"],
      activeStatus: json["active_status"],
      sellerId: json["seller_id"],
      sellerName: json["seller_name"],
      resName: json["res_name"],
    );
  }
}

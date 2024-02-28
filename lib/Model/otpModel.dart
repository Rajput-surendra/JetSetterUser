class otpModel {
  bool? error;
  String? message;
  String? mobile;
  String? otp;
  List<Null>? data;

  otpModel({this.error, this.message, this.mobile, this.otp, this.data});

  otpModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    mobile = json['mobile'];
    otp = json['otp'].toString();
    if (json['data'] != null) {
      data = <Null>[];
      json['data'].forEach((v) {
        data!.add(v.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    data['mobile'] = this.mobile;
    data['otp'] = this.otp;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toString()).toList();
    }
    return data;
  }
}
class PaymentResponse {
  PaymentResponse({
    required this.error,
    required this.message,
    required this.data,
  });

  final bool? error;
  final String? message;
  final String? data;

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      error: json["error"],
      message: json["message"] as String,
      data: json["data"] as String,
    );
  }
}

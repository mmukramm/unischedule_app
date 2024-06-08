class ApiResponse {
  final bool? status;
  final String? message;
  final String? token;
  final dynamic data;

  ApiResponse({
    required this.status,
    this.data,
    this.token,
    this.message,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      status: json["status"],
      data: json["data"],
      token: json["token"],
      message: json["message"],
    );
  }
}

class ApiResponse<T> {
  final T? data;
  final int code;
  final String message;

  ApiResponse({this.message = "", this.code = 500, this.data});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      code: json['code'],
      message: json['message'],
      data: json['data']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data
    };
  }
}
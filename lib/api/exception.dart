class ApiException implements Exception {
  final String message;
  final int code;

  ApiException({required this.code, required this.message});

  @override
  String toString() {
    return "ApiException(message: $message, code: $code)";
  }
}
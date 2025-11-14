class ApiException implements Exception {
  ApiException(this.statusCode, this.message, {this.details});

  final int statusCode;
  final String message;
  final dynamic details;

  @override
  String toString() => 'ApiException(statusCode: $statusCode, message: $message, details: $details)';
}

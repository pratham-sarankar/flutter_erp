class ApiException implements Exception {
  final int status;
  final String message;

  ApiException({
    required this.status,
    required this.message,
  });

  @override
  String toString() {
    return 'ApiException{status: $status, message: $message}';
  }
}

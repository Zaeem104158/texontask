class ErrorResponse {
  final Error? error;

  ErrorResponse({
    this.error,
  });

  ErrorResponse.fromJson(Map<String, dynamic> json)
      : error = (json['error'] as Map<String,dynamic>?) != null ? Error.fromJson(json['error'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'error' : error?.toJson()
  };
}

class Error {
  final String? message;
  final String? stack;
  final int? status;

  Error({
    this.message,
    this.stack,
    this.status,
  });

  Error.fromJson(Map<String, dynamic> json)
      : message = json['message'] as String?,
        stack = json['stack'] as String?,
        status = json['status'] as int?;

  Map<String, dynamic> toJson() => {
    'message' : message,
    'stack' : stack,
    'status' : status
  };
}
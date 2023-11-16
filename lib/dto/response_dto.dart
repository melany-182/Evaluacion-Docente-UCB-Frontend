class ResponseDto<T> {
  final String? code;
  final T? response;
  final String? errorMessage;

  ResponseDto({
    this.code,
    this.response,
    this.errorMessage,
  });

  factory ResponseDto.fromJson(Map<String, dynamic> json) {
    return ResponseDto(
      code: json['status'] as String?,
      response: json['data'] as T?,
      errorMessage: json['error'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'response': response,
      'errorMessage': errorMessage,
    };
  }
}

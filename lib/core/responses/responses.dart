abstract class Response {
  final String message;

  Response({this.message});
}

class SuccessResponse extends Response {
  final String sucessMessage;

  SuccessResponse({
    this.sucessMessage,
  }) : super(message: sucessMessage);
}

class ErrorResponse extends Response {
  final String errorMessage;

  ErrorResponse({
    this.errorMessage,
  }) : super(message: errorMessage);
}

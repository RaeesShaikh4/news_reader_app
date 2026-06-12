class ApiException implements Exception {
  final String message;
  const ApiException(this.message);

  @override
  String toString() => message;
}

class BadRequestException extends ApiException {
  const BadRequestException([super.message = 'Bad Request']);
}

class UnAuthorisedException extends ApiException {
  const UnAuthorisedException([super.message = 'Unauthorised, please try again']);
}

class ForbiddenException extends ApiException {
  const ForbiddenException([super.message = 'Access denied!']);
}

class NotFoundException extends ApiException {
  const NotFoundException([super.message = 'Data not found']);
}

class TooManyRequestExceptions extends ApiException {
  const TooManyRequestExceptions([super.message = 'Too many exceptions']);
}

class InternalServerExceptions extends ApiException {
  const InternalServerExceptions([super.message = 'Server error']);
}

class NetworkException extends ApiException {
  const NetworkException([super.message = 'Please check you internet']);
}
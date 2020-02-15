abstract class CulqiResponse{}

enum ErrorType{
  InvalidKey,
  InvalidCard,
  ServerValidationFailed,
  ExceptionTrowed
}

class CulqiError extends CulqiResponse{

  ErrorType _errorType;
  int _errorCode;
  String _errorMessage;
  Exception _exception;

  CulqiError.fromType(ErrorType errorType, {errorCode=-1, errorMessage='Unknown Error', exception}){
    _errorType = errorType;
    _errorCode = errorCode;
    _errorMessage = errorMessage;
    _exception = exception;
  }

  CulqiError.fromJson(Map<String, dynamic> response, int errorCode){
    _errorType = ErrorType.ServerValidationFailed;
    _errorMessage = response['merchant_message'];
    _errorCode = errorCode;
  }

  ErrorType get errorType     => _errorType;
  int get errorCode     => _errorCode;
  String get errorMessage  => _errorMessage;
  Exception get exception => _exception;

  @override
  String toString() {
    return  'Error obtaining Token from Culqi:\n'
            'ErrorCode: $_errorCode\n'
            'ErrorMessage: $_errorMessage\n'
            'ErrorType: $_errorType';
  }
}

class CulqiToken extends CulqiResponse{

  String _token;

  CulqiToken.fromJson(Map<String, dynamic> response){
    _token = response['id'];
  }

  String get token => _token;

  @override
  String toString() {
    return 'The token obtained is: $token';
  }

}
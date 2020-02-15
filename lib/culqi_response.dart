abstract class CulqiResponse{}

enum ErrorType{
  InvalidKey,
  InvalidCard,
  ServerValidationFailed,
}

class CulqiError extends CulqiResponse{

  ErrorType _errorType;
  int _errorCode;
  String _errorMessage;

  CulqiError.fromType(ErrorType errorType, {errorCode=-1, errorMessage='Unknown Error'}){
    _errorType = errorType;
    _errorCode = errorCode;
    _errorMessage = errorMessage;
  }

  CulqiError.fromJson(Map<String, dynamic> response, int errorCode){
    _errorType = ErrorType.ServerValidationFailed;
    _errorMessage = response['merchant_message'];
    _errorCode = errorCode;
  }

  ErrorType get errorType     => _errorType;
  int get errorCode     => _errorCode;
  String get errorMessage  => _errorMessage;

  @override
  String toString() {
    return  'Error obtaining Token from Culqi:\n'
            'ErrorCode: $_errorCode\n'
            'ErrorMessage: $_errorMessage';
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
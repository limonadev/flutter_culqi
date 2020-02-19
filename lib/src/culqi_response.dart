abstract class CulqiResponse{}

enum CulqiErrorType{
  ClientInvalidKey,
  ClientInvalidCard,
  ServerValidationFailed,
  InvalidBusiness,
  InvalidCard,
  ParameterError,
  ParameterErrorInvalidEmail,
  ParameterErrorInvalidCvv,
  ParameterErrorInvalidExpirationMonth,
  ParameterErrorInvalidExpirationYear,
  ExceptionTrowed
}

class CulqiError extends CulqiResponse{

  CulqiErrorType _errorType;
  int _errorCode;
  String _errorMessage;
  Exception _exception;

  CulqiError.fromType(CulqiErrorType errorType, {errorCode=-1, errorMessage='Unknown Error', exception}){
    _errorType = errorType;
    _errorCode = errorCode;
    _errorMessage = errorMessage;
    _exception = exception;
  }

  CulqiError.fromJson(Map<String, dynamic> response, int errorCode){

    String errorType = response['type'];

    if(_errorsOnServer.containsKey(errorType)){
      if(_errorsOnServer[errorType] == CulqiErrorType.ParameterError){
        String errorSubType = response['code'];

        if(_errorsFromParameter.containsKey(errorSubType)) _errorType = _errorsFromParameter[errorSubType];
        else _errorType = CulqiErrorType.ParameterError;

      }else{
        _errorType = CulqiErrorType.ServerValidationFailed;
      }
    }else{
      _errorType = CulqiErrorType.ServerValidationFailed;
    }

    _errorMessage = response['merchant_message'];
    _errorCode = errorCode;
  }

  Map<String, CulqiErrorType> _errorsOnServer = {
    'comercio_invalido' : CulqiErrorType.InvalidBusiness,
    'card_error' : CulqiErrorType.InvalidCard,
    'parameter_error' : CulqiErrorType.ParameterError,
  };

  Map<String, CulqiErrorType> _errorsFromParameter = {
    'invalid_email' : CulqiErrorType.ParameterErrorInvalidEmail,
    'invalid_cvv' : CulqiErrorType.ParameterErrorInvalidCvv,
    'invalid_expiration_month' : CulqiErrorType.ParameterErrorInvalidExpirationMonth,
    'invalid_expiration_year' : CulqiErrorType.ParameterErrorInvalidExpirationYear
  };

  CulqiErrorType get errorType     => _errorType;
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
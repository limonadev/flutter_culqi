import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import 'package:flutter_culqi/src/card.dart';
import 'package:flutter_culqi/src/culqi_response.dart';

class CulqiTokenizer{

  final baseUrl = 'https://secure.culqi.com/v2';
  final CulqiCard _card;

  CulqiTokenizer(this._card);

  Future<CulqiResponse> getToken({@required String publicKey}) async{
    if(publicKey==null) return CulqiError.fromType(ErrorType.InvalidKey, errorMessage: 'No public key given');
    if(!_card.isValid()) return CulqiError.fromType(ErrorType.InvalidCard, errorMessage: 'Some value on the card is incorrect');

    Map<String, dynamic> body = {
      'card_number'       : _card.cardNumber,
      'cvv'               : _card.cvv,
      'expiration_month'  : _card.expirationMonth,
      'expiration_year'   : _card.expirationYear,
      'email'             : _card.email
    };

    Map<String, String> headers = {
      'Content-Type'      : 'application/json; charset=utf-8',
      'Authorization'     : 'Bearer $publicKey'
    };

    final tokenUrl = baseUrl+'/tokens/';
    var response;
    try{
      response = await http.post(tokenUrl, body: json.encode(body), headers: headers);
    }catch (e){
      print('Exception ocurred: $e');
      return CulqiError.fromType(ErrorType.ServerValidationFailed, errorMessage: e.toString(), errorCode: -2);
    }

    if(response.statusCode == 201) return CulqiToken.fromJson(json.decode(response.body));
    else return CulqiError.fromJson(json.decode(response.body), response.statusCode);
  }

}
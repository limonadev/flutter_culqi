import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_culqi/flutter_culqi.dart';

void main() {
  group('Check Error Types', (){

    final String _publicKey = 'INSERT_YOUR_PUBLIC_KEY_HERE';

    test('Good Card', () async{
      CulqiCard card = CulqiCard(
          cardNumber: '4111111111111111',
          cvv: '123',
          expirationMonth: 9,
          expirationYear: 2020,
          email:'test@testmail.com'
      );

      CulqiTokenizer tokenizer = CulqiTokenizer(card);

      var result = await tokenizer.getToken(publicKey: _publicKey);
      if(result is CulqiToken){
        print(result.token);
      }else if(result is CulqiError){
        print(result);
      }
    });

    test('Bad Email', () async{
      CulqiCard card = CulqiCard(
          cardNumber: '4111111111111111',
          cvv: '123',
          expirationMonth: 9,
          expirationYear: 2020,
          email:null
      );

      CulqiTokenizer tokenizer = CulqiTokenizer(card);

      var result = await tokenizer.getToken(publicKey: _publicKey);
      if(result is CulqiToken){
        print(result.token);
      }else if(result is CulqiError){
        print(result);
      }
    });

    test('Bad Card Number', () async{
      CulqiCard card = CulqiCard(
          cardNumber: '',
          cvv: '123',
          expirationMonth: 9,
          expirationYear: 2020,
          email:'test@testmail.com'
      );

      CulqiTokenizer tokenizer = CulqiTokenizer(card);

      var result = await tokenizer.getToken(publicKey: _publicKey);
      if(result is CulqiToken){
        print(result.token);
      }else if(result is CulqiError){
        print(result);
      }
    });

    test('Bad CVV', () async{
      CulqiCard card = CulqiCard(
          cardNumber: '4111111111111111',
          cvv: '',
          expirationMonth: 9,
          expirationYear: 2020,
          email:'test@testmail.com'
      );

      CulqiTokenizer tokenizer = CulqiTokenizer(card);

      var result = await tokenizer.getToken(publicKey: _publicKey);
      if(result is CulqiToken){
        print(result.token);
      }else if(result is CulqiError){
        print(result);
      }
    });

    test('Bad Month', () async{
      CulqiCard card = CulqiCard(
          cardNumber: '4111111111111111',
          cvv: '123',
          expirationMonth: 123,
          expirationYear: 2020,
          email:'test@testmail.com'
      );

      CulqiTokenizer tokenizer = CulqiTokenizer(card);

      var result = await tokenizer.getToken(publicKey: _publicKey);
      if(result is CulqiToken){
        print(result.token);
      }else if(result is CulqiError){
        print(result);
      }
    });

    test('Bad Year', () async{
      CulqiCard card = CulqiCard(
          cardNumber: '4111111111111111',
          cvv: '123',
          expirationMonth: 123,
          expirationYear: 2019,
          email:'test@testmail.com'
      );

      CulqiTokenizer tokenizer = CulqiTokenizer(card);

      var result = await tokenizer.getToken(publicKey: _publicKey);
      if(result is CulqiToken){
        print(result.token);
      }else if(result is CulqiError){
        print(result);
      }
    });
  });
}

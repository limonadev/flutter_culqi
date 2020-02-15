import 'package:culqi_flutter/culqi_response.dart';
import 'package:flutter/material.dart';

import 'package:culqi_flutter/culqi_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  void kappa() async{
    CulqiCard card = CulqiCard(
        cardNumber: '4111111111111111',
        cvv: '123',
        expirationMonth: 9,
        expirationYear: 2020,
        email:'alrus2797@gmai.com'
    );

    CulqiTokenizer tokenizer = CulqiTokenizer(card);

    /*var result = await tokenizer.getToken(publicKey: 'pk_test_juKtZ4MFGEHRVGdl');
    if(result is CulqiToken){
      print(result);
    }else if(result is CulqiError){
      print(result);
    }*/

  }

  MyApp(){
    kappa();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {

  GlobalKey<CulqiPaymentState> _key = GlobalKey();

  String _email;

  String _token = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Culqi Example'),
      ),
      body: ListView(
        children: <Widget>[
          CulqiPayment(_key, locale: 'en'),
          ListTile(
            title: Text('Email', style: TextStyle(fontSize: 12),),
            subtitle: TextField(
              onChanged: (value){
                _email = value;
              },
              decoration: InputDecoration(
                hintText: 'test@test.com'
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: RaisedButton(
              onPressed: getToken,
              child: Text('Get Token', style: TextStyle(color: Colors.white),),
              color: Colors.blue,
            ),
          ),
          Text(_token)
        ],
      ),
    );
  }

  void getToken() async{
    CulqiCard _card = CulqiCard();
    bool success = _key.currentState.setInfoOn(_card);

    if(success){
      _card.email = _email;

      CulqiTokenizer _tokenizer = CulqiTokenizer(_card);

      var result = await _tokenizer.getToken(publicKey: 'pk_test_juKtZ4MFGEHRVGdl');
      if(result is CulqiToken){
        setState(() {
          _token = result.token;
        });
      }else if(result is CulqiError){
        setState(() {
          _token = result.errorMessage;
        });
      }
    }
  }
}

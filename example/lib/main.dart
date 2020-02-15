import 'package:flutter/material.dart';

import 'package:culqi_flutter/culqi_flutter.dart';


/// You need to paste your Culqi public key here
final String _publicKey = 'INSERT_YOUR_PUBLIC_KEY_HERE';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  /// This functions tests the creation of a [CulqiToken] given a [CulqiCard]
  void onlyApi() async{
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

  }

  MyApp(){
    onlyApi();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Culqi Demo',
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
          /// This is a provided widget to make faster the Culqi integration. Is not mandatory to use it,
          /// you can create your own form to get the necessary fields to get a token.
          ///
          /// Of course, the creation of the token requires an email, but on the most cases, the email
          /// is the login method, so the app already has the user email. Because of that the
          /// [CulqiPayment] widget wont request the email, and you need to provide it to the [CulqiCard]
          CulqiPayment(_key, locale: 'en', years: [2020, 2021, 2022, 2023, 2024],),

          /// In this example, here we are requesting the email and save it on [_email].
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


  /// This async function allows us to get the info from the [CulqiPayment] widget and check if all the fields
  /// were completed. If it happens, set the [_email] on the [_card].
  ///
  /// Finally, using the [CulqiTokenizer] we try to get the token.
  void getToken() async{
    CulqiCard _card = CulqiCard();
    bool success = _key.currentState.setInfoOn(_card);

    if(success){
      _card.email = _email;

      CulqiTokenizer _tokenizer = CulqiTokenizer(_card);

      var result = await _tokenizer.getToken(publicKey: _publicKey);
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

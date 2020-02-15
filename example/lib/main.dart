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

    var result = await tokenizer.getToken(publicKey: 'pk_test_juKtZ4MFGEHRVGdl');
    if(result is CulqiToken){
      print(result);
    }else if(result is CulqiError){
      print(result);
    }

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

  CulqiCard card;

  MyHomePage(){
    card = CulqiCard(
        cardNumber: '4111111111111111',
        cvv: '123',
        expirationMonth: 9,
        expirationYear: 2020,
        email:'alrus2797@gmai.com'
    );
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {

  GlobalKey _onBodyKey = GlobalKey();
  GlobalKey _onDialogKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CulqiPayment(_onBodyKey),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        child: Icon(Icons.credit_card),
      ),
    );
  }

  void _showDialog(){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          content: CulqiPayment(_onDialogKey),
        );
      }
    );
  }

}

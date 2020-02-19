# flutter_culqi

A [Flutter Package]() to allow the integration of Android/iOS apps with the [Culqi API](https://www.culqi.com/docs/#/).

## How to install it?

Add the package to pubspec.yaml:
```dart
flutter_culqi : ^0.5.2
```

Import and use it! :)
``` dart
import 'package:culqi_flutter/culqi_flutter.dart';
```

## What **flutter_culqi** do?

This package comes with two main components:
1. An easy way to request the token from Culqi
2. A widget to make faster the integration

### 1. An easy way to request the token from Culqi:

**flutter_culqi** provides you with a simple interface to request and get the token from Culqi. It's easy as:

+ Create an String variable called `_publicKey`, assign to it the public key obtained from your panel at Culqi.
    ```dart
    final String _publicKey = 'INSERT_YOUR_PUBLIC_KEY_HERE';
    ```
+ Create a `CulqiCard` object (all fields are required).
    ```dart
    CulqiCard card = CulqiCard(
        cardNumber: '4111111111111111',
        cvv: '123',
        expirationMonth: 9,
        expirationYear: 2020,
        email:'test@testmail.com'
    );
    ```
+ Create a `CulqiTokenizer` object. This will keep the `CulqiCard` created above.
    ```dart
    CulqiTokenizer tokenizer = CulqiTokenizer(card);
    ```
+ And finally request the `CulqiToken`. The `_publicKey` is the same we setted above, in the first step.
    ```dart
    var result = await tokenizer.getToken(publicKey: _publicKey);
    if(result is CulqiToken){
      print(result.token);
    }else if(result is CulqiError){
      print(result);
    }
    ```
All the code can be found at the [example folder](https://github.com/limonadev/flutter_culqi/tree/master/example).

### 2. A widget to make faster the integration:

We may not want to implement the UI to request all the data (card number, expiration date, etc). Because of that, this packages comes with a widget (called `CulqiPayment`) that makes the job for us. So, how to use it?

+ The widget can be created like any other. As body of `Scaffold` for example.
    ```dart

    class TestWidget extends StatefulWidget {
        @override
        TestWidgetState createState() => TestWidgetState();
    }

    class TestWidgetState extends State<TestWidget>{
        // We need this key to get the fields inside the widget
        GlobalKey<CulqiPaymentState> _widgetKey = GlobalKey();
        
        // This is again the public key from Culqi
        final String _publicKey = 'INSERT_YOUR_PUBLIC_KEY_HERE';

        // ... More code

        @override
        Widget build(BuildContext context){
            return Scaffold(
                body: ListView(
                    children: <Widget>[
                        // Here we create it and pass the _widgetKey
                        CulqiPayment(_widgetKey),
                        RaisedButton(
                            // This function will get the token
                            // with the fields from CulqiPayment
                            onPressed: getToken,
                            child: Text('Get Token')
                        )
                    ]
                )
            );
        }
    }
    ```
+ To make clearer how to get the `CulqiToken` when using the `CulqiPayment` widget, here is the `getToken()` function called from the RaisedButton above.
    ```dart
    class TestWidgetState extends State<TestWidget>{
        // Here comes the above code
        // ...
        // Here ends the above code

        void getToken() async{
            CulqiCard _card = CulqiCard();

            // Here we are getting all the fields from the widget
            // through setInfoOn(CulqiCard _card) function
            bool success = _widgetKey.currentState.setInfoOn(_card);

            // The widget doesn't ask for email, because 
            // assumes the app already has the user email  
            // (from login for example). 
            // But in case is needed, in the example
            // folder at repository, can be found the same 
            // code but requesting the email.
            //
            // Here, for simplicity, we set the email

            _card.email = 'test@testemail.com';

            CulqiTokenizer _tokenizer = CulqiTokenizer(_card);

            var r = await tokenizer.getToken(publicKey:_publicKey);
            
            if(r is CulqiToken){
                print(r.token);
            }else if(r is CulqiError){
                print(r);
            }
        }
    }
    ```
Again, all the code can be found at the [example folder](https://github.com/limonadev/flutter_culqi/tree/master/example).

#### The `CulqiPayment` widget:

This widgets allows two optional parameters: `locale` and `years`.
+ `locale` is an String with value 'es' or 'en', meaning Spanish and English respectively. This value is used to show the widget in the corresponding language. If not provided or not supported language is provided, the default goes to 'es'.
+ `years` is a `List<int>`. Represents the year range to choose at expiration year. Default goes to [2020, 2021, 2022, 2023, 2024, 2025].

## Suggestions and bugs

Please file feature requests, suggestions and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/limonadev/flutter_culqi/issues
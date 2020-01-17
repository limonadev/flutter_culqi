import 'package:culqi_flutter/card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CulqiPayment extends StatefulWidget {

  CulqiCard _card;

  CulqiPayment(this._card);

  @override
  CulqiPaymentState createState() {
    return CulqiPaymentState();
  }
}

class CulqiPaymentState extends State<CulqiPayment> {
  final _formKey = GlobalKey<FormState>();

  List<String> _months = [
    "January",
    "February",
    "March",
    "April",
    "Mayp",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  List<int> _years = [2020, 2021, 2022, 2023, 2024, 2025];

  int _selectedMonth = 0;
  int _selectedYear = 0;

  List<Widget> _buildMonths() {
    return _months.map((val) => Text(val)).toList();
  }

  List<Widget> _buildYears() {
    return _years.map((val) => Text(val.toString())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
              child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50)),
                color: Colors.white),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    ListTile(
                        title: Text(
                          "Número de tarjeta",
                          style: TextStyle(fontSize: 12),
                        ),
                        subtitle: TextFormField(
                          cursorColor: Colors.black,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 15),
                              hintText: "XXXX - XXXX - XXXX - XXXX"),
                          onFieldSubmitted: (value) {},
                          validator: (value) {
                            if (value.isEmpty)
                              return "Llene este campo para continuar";
                            return null;
                          },
                        )),
                    Container(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                            flex: 2,
                            child: ListTile(
                              title: Text(
                                "Fecha de expiración",
                                style: TextStyle(fontSize: 12),
                              ),
                              subtitle: Row(
                                children: <Widget>[
                                  Expanded(
                                      flex: 2,
                                      child: GestureDetector(
                                        child: Container(
                                            height: 45,
                                            alignment: Alignment.center,
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Text(
                                                      _months[_selectedMonth]),
                                                ),
                                                Icon(Icons.arrow_drop_down)
                                              ],
                                            )),
                                        onTap: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (BuildContext builder) {
                                                return Container(
                                                  child: CupertinoPicker(
                                                    itemExtent: 35.0,
                                                    onSelectedItemChanged:
                                                        (value) {
                                                      setState(() {
                                                        _selectedMonth = value;
                                                      });
                                                    },
                                                    children: _buildMonths(),
                                                    looping: true,
                                                    backgroundColor:
                                                        Colors.white,
                                                  ),
                                                );
                                              });
                                        },
                                      )),
                                  Container(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: GestureDetector(
                                    child: Container(
                                      height: 45,
                                      alignment: Alignment.center,
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                              child: Text(
                                                  "${_years[_selectedYear]}")),
                                          Icon(Icons.arrow_drop_down)
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext builder) {
                                            return Container(
                                              child: CupertinoPicker(
                                                itemExtent: 35.0,
                                                onSelectedItemChanged: (value) {
                                                  setState(() {
                                                    _selectedYear = value;
                                                  });
                                                },
                                                children: _buildYears(),
                                                looping: true,
                                                backgroundColor: Colors.white,
                                              ),
                                            );
                                          });
                                    },
                                  ))
                                ],
                              ),
                            )),
                        Expanded(
                            child: ListTile(
                          title: Text(
                            "CVV",
                            style: TextStyle(fontSize: 12),
                          ),
                          subtitle: TextFormField(
                            cursorColor: Colors.black,
                            textInputAction: TextInputAction.done,
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(hintText: "XXX"),
                            onFieldSubmitted: (value) {},
                            validator: (value) {
                              if (value.isEmpty)
                                return "Llene este campo para continuar";
                              return null;
                            },
                          ), //
                        ))
                      ],
                    )
                  ],
                )),
          )),
          Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: RaisedButton(
              onPressed: () {},
              child: Text("Pagar ahora"),
              color: Theme.of(context).primaryColorLight,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          )
        ],
      ),
    );
  }
}

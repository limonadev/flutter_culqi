import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:culqi_flutter/src/card.dart';
import 'package:culqi_flutter/src/internationalization/translation.dart';

class CulqiPayment extends StatefulWidget {

  final String locale;
  final List<int> years;

  CulqiPayment(Key key, {this.locale : Translations.defaultLocale, this.years : const [2020, 2021, 2022, 2023, 2024, 2025]}) : super(key:key);

  @override
  CulqiPaymentState createState() {
    return CulqiPaymentState();
  }
}

class CulqiPaymentState extends State<CulqiPayment> {
  final _formKey = GlobalKey<FormState>();

  List<String> _months;
  List<int> _years;

  String _cardNumber;
  String _cvv;
  int _selectedMonth = 0;
  int _selectedYear = 0;

  @override
  void initState() {
    _months = Translations.months(widget.locale);
    _years = widget.years;
  }

  List<Widget> _buildMonths() {
    return _months.map((val) => Text(val)).toList();
  }

  List<Widget> _buildYears() {
    return _years.map((val) => Text(val.toString())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              ListTile(
                  title: Text(
                    Translations.cardNumberLabel(widget.locale),
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
                      if (value.isEmpty) return Translations.emptyWarningLabel(widget.locale);
                      _cardNumber = value;
                      return null;
                    },
                  )),
              Container(
                height: 10,
              ),
              ListTile(
                title: Text(
                  Translations.expirationMonthLabel(widget.locale),
                  style: TextStyle(fontSize: 12),
                ),
                subtitle: GestureDetector(
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
                ),
              ),
              ListTile(
                  title: Text(
                    Translations.expirationYearLabel(widget.locale),
                    style: TextStyle(fontSize: 12),
                  ),
                  subtitle: GestureDetector(
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
                  )
              ),
              ListTile(
                title: Text(
                  Translations.cvvLabel(widget.locale),
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
                    if (value.isEmpty) return Translations.emptyWarningLabel(widget.locale);
                    _cvv = value;
                    return null;
                  },
                ), //
              )
            ],
          ))
    );
  }

  bool setInfoOn(CulqiCard _card) {
    if(!mounted) return false;

    if(_card == null) return false;

    if(!_formKey.currentState.validate()) return false;

    _card.cardNumber = _cardNumber;
    _card.cvv = _cvv;
    _card.expirationMonth = _selectedMonth+1;
    _card.expirationYear = _years[_selectedYear];
    return true;
  }
}

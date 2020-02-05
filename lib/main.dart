import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Simple Interest Calculator",
    home: SIform(),
    theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.green,
        accentColor: Colors.greenAccent),
  ));
}

class SIform extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIformState();
  }
}

class _SIformState extends State<SIform> {
  var _formKey = GlobalKey<FormState>();

  var _currencies = ["Rupees", "Dollars", "Pounds"];
  var _minimumpadding = 5.0;

  var _currentItemSelected = '';

  @override
  void initState() {
    super.initState();
    _currentItemSelected = _currencies[0];
  }

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  var displayResult = '';

  @override
  Widget build(BuildContext context) {
    TextStyle textstyle = Theme.of(context).textTheme.title;
    return Scaffold(
        appBar: AppBar(
          title: Text("Simple Interest Calculator"),
        ),
        body: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(_minimumpadding * 5),
              child: ListView(children: <Widget>[
                getImageSet(),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumpadding, bottom: _minimumpadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textstyle,
                      controller: principalController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter principal amount';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Principal',
                          labelStyle: textstyle,
                          hintText: 'Enter Principal e.g. 1200',
                          errorStyle: TextStyle(
                              color: Colors.yellowAccent, fontSize: 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumpadding, bottom: _minimumpadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: roiController,
                      style: textstyle,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter rate of interest';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Rate of Interest',
                          labelStyle: textstyle,
                          hintText: 'In Percent',
                          errorStyle: TextStyle(
                              color: Colors.yellowAccent, fontSize: 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimumpadding, bottom: _minimumpadding),
                  child: Row(children: <Widget>[
                    Expanded(
                        child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: termController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter time';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Term',
                          labelStyle: textstyle,
                          hintText: 'Term in years',
                          errorStyle: TextStyle(
                              color: Colors.yellowAccent, fontSize: 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                    Container(
                      width: _minimumpadding * 5,
                    ),
                    Expanded(
                        child: DropdownButton<String>(
                      items: _currencies.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      onChanged: (String newValueSelected) {
                        _dropDownItemSelected(newValueSelected);
                      },
                      value: _currentItemSelected,
                    )),
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimumpadding, bottom: _minimumpadding),
                  child: Row(children: <Widget>[
                    Expanded(
                        child: RaisedButton(
                            color: Theme.of(context).accentColor,
                            textColor: Theme.of(context).primaryColorDark,
                            child: Text(
                              'Calculate',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                if (_formKey.currentState.validate()) {
                                  this.displayResult = _calculateTotalReturns();
                                }
                              });
                            })),
                    Container(
                      width: _minimumpadding * 2,
                    ),
                    Expanded(
                        child: RaisedButton(
                            color: Theme.of(context).accentColor,
                            textColor: Theme.of(context).primaryColorDark,
                            child: Text(
                              'Reset',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              _reset();
                            })),
                  ]),
                ),
                Padding(
                    padding: EdgeInsets.all(_minimumpadding * 2),
                    child: Text(
                      this.displayResult,
                      style: textstyle,
                    )),
              ]),
            )));
  }

  Widget getImageSet() {
    AssetImage assetImage = AssetImage('./images/interest.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumpadding * 10),
    );
  }

  void _dropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String _calculateTotalReturns() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalAmountPayable = principal + (principal * roi * term) / 100;

    String result =
        'After $term years, your investment will be worth $totalAmountPayable $_currentItemSelected';
    return result;
  }

  void _reset() {
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    displayResult = '';
    _currentItemSelected = _currencies[0];
  }
}

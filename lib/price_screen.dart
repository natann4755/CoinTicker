import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String exchangeRateBTC = '?';
  String exchangeRateETH = '?';
  String exchangeRateLTC = '?';

  DropdownButton androidDropdown() {
    List<DropdownMenuItem<String>> mDropdownButton = [];

    for (String currency in currenciesList) {
      mDropdownButton.add(
        DropdownMenuItem(
          child: Text(currency),
          value: currency,
        ),
      );
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: mDropdownButton,
      onChanged: (value) async{
        CoinData data = CoinData(value);
        var rateBTC = await data.getExchangeRate('BTC');
        var rateETH = await data.getExchangeRate('ETH');
        var rateLTC = await data.getExchangeRate('LTC');
        print (rateBTC);
        setState(() {

          updateResult(value, rateBTC, rateETH, rateLTC);
        });
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Widget> mPicker = [];

    for (String currency in currenciesList) {
      mPicker.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) async {
          String coin = currenciesList[selectedIndex];
          CoinData data = CoinData(coin);
          print(coin);
          var rateBTC = await data.getExchangeRate('BTC');
          var rateETH = await data.getExchangeRate('ETH');
          var rateLTC = await data.getExchangeRate('LTC');
          print (rateBTC);
          setState(() {
            updateResult(coin, rateBTC, rateETH, rateLTC);
          });
      },
      children: mPicker,
    );
  }

  void updateResult(String coin, double rateBTC, double rateETH, double rateLTC) {
      print(coin);
    selectedCurrency =  coin;
    if (rateBTC != null) {
      exchangeRateBTC = rateBTC.toStringAsFixed(2);
    }else {
      exchangeRateBTC = '???';
    }
    if (rateETH != null) {
      exchangeRateETH = rateETH.toStringAsFixed(2);
    }else {
      exchangeRateETH = '???';
    }
    if (rateLTC != null) {
      exchangeRateLTC = rateLTC.toStringAsFixed(2);
    }else {
      exchangeRateLTC = '???';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $exchangeRateBTC $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = $exchangeRateETH $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = $exchangeRateLTC $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 200.0,
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
//            child: Platform.isIOS ? iosPicker() : androidDropdown(),
          child: iosPicker(),
          ),
        ],
      ),
    );
  }
}

import 'dart:convert';
import 'dart:ffi';

import 'network_request.dart';
const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  static const apiKey = "892A14AC-C05B-446D-9B26-BDB2347483DA";
  static const apiKey2 = "919B722F-94E6-4FC8-A11D-3F61D3AD47C0";

  CoinData(this.coin2);

  String coin2;

  Future <double> getExchangeRate(String coin1)async{
    NetworkRequest networkRequest = NetworkRequest('https://rest.coinapi.io/v1/exchangerate/$coin1/$coin2?apikey=$apiKey2');
    var data = await networkRequest.getData();
    print(data);
    if (data != null){
      return data['rate'];
    }
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;

String apiKey =
    '8cc2dd5a7b1804d9dcd434380dfa1409b050c6ce11e2675fd221e32c0c29a845d';
String coinDeckURL = 'https://data-api.coindesk.com';

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
  'ZAR',
];

const List<String> cryptoList = ['BTC', 'ETH', 'LTC'];

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices={};
    for (String crypto in cryptoList) {
      http.Response response = await http.get(
        Uri.parse(
          '$coinDeckURL/index/cc/v1/latest/tick?market=cadli&instruments=${crypto}-${selectedCurrency}&apply_mapping=false&groups=VALUE,ID,LAST_UPDATE&api_key=$apiKey',
        ),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        var lastPrice = result['Data']['$crypto-$selectedCurrency']['VALUE'];
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        print(response.statusCode);
      }
    }
    return cryptoPrices;
  }
}

import 'package:bitcoin_ticker/crypto_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  late String selectedCurrency = 'AUD';
  List<Widget> getPickerItem() {
    List<Text> pickerItem = [];
    for (String currency in currenciesList) {
      pickerItem.add(Text(currency));
      // getData();
    }
    return pickerItem;
  }

   Map<String, String> coinValues={};
  void getData() async {
    try {
      CoinData coinData = CoinData();
      var data = await coinData.getCoinData(selectedCurrency);
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  ////For bonus points, create a method that loops through the cryptoList and generates a CryptoCard for each. Call makeCards() in the build() method instead of the Column with 3 CryptoCards.
  Column makeCards() {
    List<CryptoCard> cryptoCards = [];
    for (String crypto in cryptoList) {
      cryptoCards.add(
        CryptoCard(
          cryptoCurrency: crypto,
          selectedCurrency: selectedCurrency,
          amount: coinValues[crypto] ?? '?',
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cryptoCards,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('🤑 Coin Ticker')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          makeCards(),
          // CryptoCard(
          //   cryptoCurrency: "BTC",
          //   amount: coinValues['BTC'] ?? '?',
          //   selectedCurrency: selectedCurrency,
          // ),
          // CryptoCard(
          //   cryptoCurrency: "ETH",
          //   amount: coinValues['ETH'] ?? '?',
          //   selectedCurrency: selectedCurrency,
          // ),
          // CryptoCard(
          //   cryptoCurrency: "LTC",
          //   amount: coinValues['LTC'] ?? '?',
          //   selectedCurrency: selectedCurrency,
          // ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: CupertinoPicker(
              itemExtent: 30,
              onSelectedItemChanged: (dynamic selectedIndex) {
                print(selectedIndex);
                setState(() {
                  selectedCurrency = currenciesList[selectedIndex];
                  getData();
                });
              },
              children: getPickerItem(),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:bitcoin_ticker/data/resuable_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'data/coin_data.dart';
import 'data/networking.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurency = 'USD';

  //PriceExchange price = PriceExchange();
  double rate = 0.0;

  // value pass from dropdown
  @override
  void initState() {
    super.initState();
    getExchangeData();
  }

  void updateUi(dynamic priceData) {
    setState(() {
      rate = priceData['rate'];
    });
  }

  void getExchangeData() async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://rest.coinapi.io/v1/exchangerate/BTC/$selectedCurency?apikey=7519179E-59FA-4619-9A0A-FD244922087D');
    var exchangeData = await networkHelper.getData();
    updateUi(exchangeData);
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        value: currency,
        child: Text(
          currency,
          textAlign: TextAlign.center,
        ),
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
        dropdownColor: Colors.black87,
        menuMaxHeight: 300.0,
        borderRadius: BorderRadius.circular(15.0),
        isExpanded: true,
        style: const TextStyle(
            color: Colors.white, backgroundColor: Colors.white12),
        value: selectedCurency,
        items: dropdownItems,
        onChanged: (value) {
          setState(() {
            selectedCurency = value!;
            getExchangeData();
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: Colors.lightBlueAccent),
        title: const Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
          child: Text(
            '🤑Coin Ticker',
            style: TextStyle(color: Colors.white),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ResuableCard(
              rate: rate,
              selectedCurrency: selectedCurency,
              currentCurrency: cryptoList[0]),
          ResuableCard(
              rate: rate,
              selectedCurrency: selectedCurency,
              currentCurrency: cryptoList[1]),
          ResuableCard(
              rate: rate,
              selectedCurrency: selectedCurency,
              currentCurrency: cryptoList[2]),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            decoration: const BoxDecoration(
              color: Colors.lightBlueAccent,
            ),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: androidDropdown(),
            ),
          ),
        ],
      ),
    );
  }
}

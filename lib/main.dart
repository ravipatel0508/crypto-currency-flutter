import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:crypto_example/home_page.dart';

void main() async{
  final List currencies = await getCurrencies();
  runApp(MyApp(currencies));
  //runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List currencies;
  MyApp(this.currencies);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(currencies),
      debugShowCheckedModeBanner: false,
    );
  }
}

Future getCurrencies() async {
    String cryptoUrl = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest";

    http.Response response = await http.get(Uri.parse(cryptoUrl),
     headers: {
       'X-CMC_PRO_API_KEY': 'Your-API',
       "Accept": "application/json",
     });

    return jsonDecode(response.body)['data'];
}
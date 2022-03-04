// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:currency_textfield/currency_textfield.dart';
import 'package:http/http.dart' as http;

const url = 'https://api.hgbrasil.com/finance/quotations?key=0e4d35d2';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CurrencyTextFieldController realController = CurrencyTextFieldController();
  CurrencyTextFieldController dolarController = CurrencyTextFieldController(rightSymbol: "\$ ");
  CurrencyTextFieldController euroController = CurrencyTextFieldController(rightSymbol: "€ ");

  double vrUSD = 0;
  double vrEUR = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    http.get(Uri.parse(url)).then((value) {
      var respJson = jsonDecode(value.body);
      vrUSD = respJson["results"]["currencies"]["USD"]["buy"];
      vrEUR = respJson["results"]["currencies"]["EUR"]["buy"];
      print("USD: $vrUSD e EUR: $vrEUR");
    });
  }

  void onRealChanged(String text) {
    double vrReal = realController.doubleValue;
    double calcUSD = vrReal * vrUSD;
    double calcEUR = vrReal * vrEUR;
    dolarController.text = calcUSD.toStringAsFixed(2);
    euroController.text = calcEUR.toStringAsFixed(2);
  }

  void onDolarChanged(String text) {
    double vr = dolarController.doubleValue;
    double calcReal = vr / vrUSD;
    double calcEUR = calcReal * vrEUR;
    realController.text = calcReal.toStringAsFixed(2);
    euroController.text = calcEUR.toStringAsFixed(2);
  }

  void onEuroChanged(String text) {
    double vr = euroController.doubleValue;
    double calcReal = vr / vrEUR;
    double calcUSD = calcReal * vrUSD;
    realController.text = calcReal.toStringAsFixed(2);
    dolarController.text = calcUSD.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.attach_money),
            Text("Conversor"),
            Icon(Icons.attach_money),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.monetization_on,
            size: 120,
            color: Theme.of(context).colorScheme.primary,
          ),
          buildTextFormField("Reais", realController, onRealChanged),
          Divider(),
          buildTextFormField("Dolares", dolarController, onDolarChanged),
          Divider(),
          buildTextFormField("Euros", euroController, onEuroChanged),
        ],
      ),
    );
  }
}

Widget buildTextFormField(String label, CurrencyTextFieldController controller, Function(String) onChanged) {
  return TextFormField(
    onChanged: onChanged,
    controller: controller,
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      labelText: label,
      suffixIcon: IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          controller.clear();
        },
      ),
    ),
    style: TextStyle(
      fontSize: 26,
    ),
    keyboardType: TextInputType.number,
  );
}

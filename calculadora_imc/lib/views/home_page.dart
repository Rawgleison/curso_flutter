import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController pesoTextController = TextEditingController();
  TextEditingController alturaTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final FocusNode focusNode = FocusNode();

  String _info = "Informe seus dados";
  String _info2 = "";

  Color getPrimaryColor(BuildContext context) {
    return Theme.of(context).primaryColor;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de IMC"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: clearForm,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Icon(
              Icons.person_outline_outlined,
              color: getPrimaryColor(context),
              size: 120,
            ),
            TextFormField(
              focusNode: focusNode,
              validator: ((value) {
                if (value != null && value.isEmpty) {
                  return "Informe o peso.";
                }
                return null;
              }),
              controller: pesoTextController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 26, color: getPrimaryColor(context)),
              decoration: InputDecoration(
                  labelText: "Peso(kg)",
                  labelStyle: TextStyle(color: getPrimaryColor(context))),
            ),
            TextFormField(
              validator: ((value) {
                if (value != null && value.isEmpty) {
                  return "Informe a altura.";
                }
                return null;
              }),
              controller: alturaTextController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: TextStyle(fontSize: 26, color: getPrimaryColor(context)),
              decoration: InputDecoration(
                labelText: "Altura(cm)",
                labelStyle: TextStyle(color: getPrimaryColor(context)),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: calcIMC,
              child: Text("Calcular", style: TextStyle(fontSize: 26)),
              style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(60)),
            ),
            Text(
              _info,
              style: TextStyle(color: getPrimaryColor(context), fontSize: 36),
            ),
            Text(
              _info2,
              style: TextStyle(color: getPrimaryColor(context), fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  void clearForm() {
    pesoTextController.clear();
    alturaTextController.clear();
    // focusNode.requestFocus();
    setState(() {
      _info = "Informe seus dados.";
      _info2 = "";
    });
  }

  void calcIMC() {
    if (_formKey.currentState!.validate()) {
      double peso = double.parse(pesoTextController.text);
      double altura = double.parse(alturaTextController.text) / 100;
      double imc = peso / (altura * altura);
      print(imc);
      double pesoIdealMenor = 18.5 * (altura * altura);
      double pesoIdealMaior = 24.9 * (altura * altura);
      setState(() {
        if (imc < 18.5) {
          _info = "A baixo do peso (${imc.toStringAsPrecision(4)})";
        } else if (18.5 <= imc && imc < 25) {
          _info = "Peso normal (${imc.toStringAsPrecision(4)})";
        } else if (25 <= imc && imc < 30) {
          _info = "Sobrepeso (${imc.toStringAsPrecision(4)})";
        } else if (30 <= imc && imc < 35) {
          _info = "Obesidade I (${imc.toStringAsPrecision(4)})";
        } else if (35 <= imc && imc < 40) {
          _info = "Obesidade II (${imc.toStringAsPrecision(4)})";
        } else if (40 <= imc) {
          _info = "Obesidade III (${imc.toStringAsPrecision(4)})";
        }
        _info2 =
            "O peso ideal está entre ${pesoIdealMenor.toStringAsPrecision(4)}kg e ${pesoIdealMaior.toStringAsPrecision(4)}kg";
      });
    }
  }
}

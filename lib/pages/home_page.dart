import 'package:flutter/material.dart';
import 'package:imc_calculator/widgets/refresh_button.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String _result = 'Resultado: ';

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetTextFields() {
    setState(() {
      weightController.text = '';
      heightController.text = '';
      _result = 'Resultado: ';
    });
  }

  void _resetValidatonErrorMessages() {
    _formKey = GlobalKey<FormState>();
  }

  void calculateImc() {
    String stringWeight = weightController.text;
    double weight = double.parse(stringWeight);
    String stringHeight = heightController.text;
    double height = double.parse(stringHeight) / 100;
    double imc = weight / (height * height);
    setState(() {
      alterResult(imc);
    });
  }

  void alterResult(double imc) {
    String convertedImc = imc.toStringAsPrecision(3);
    if (imc < 18.6) {
      _result = 'Resultado: Abaixo do peso (${convertedImc})';
    } else if (imc >= 18.6 && imc < 24.9) {
      _result = 'Resultado: Peso ideal (${convertedImc})';
    } else if (imc >= 24.9 && imc < 29.9) {
      _result = 'Resultado: Levemente acima do peso ${convertedImc}';
    } else if (imc >= 29.9 && imc < 34.9) {
      _result = 'Resultado: Obesidade Grau I ${convertedImc}';
    } else if (imc >= 34.9 && imc < 39.9) {
      _result = 'Resultado: Obesidade Grau II ${convertedImc}';
    } else if (imc >= 40) {
      _result = 'Resultado: Obesidade Grau III ${convertedImc}';
    }
  }

  void resetPage() {
    _resetTextFields();
    _resetValidatonErrorMessages();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Calculadora de IMC'),
          centerTitle: true,
          backgroundColor: Colors.lightGreen,
          actions: [
            RefreshButton(onpressedFunction: resetPage),
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.person,
                    size: 120,
                    color: Colors.lightGreen,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Peso (Kg)',
                      labelStyle: TextStyle(
                        color: Colors.lightGreen,
                      ),
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.lightGreen,
                      fontSize: 20,
                    ),
                    controller: weightController,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Insira seu peso';
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Altura (cm)',
                      labelStyle: TextStyle(
                        color: Colors.lightGreen,
                      ),
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.lightGreen,
                      fontSize: 20,
                    ),
                    controller: heightController,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Insira sua altura';
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          calculateImc();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen,
                      ),
                      child: const Text(
                        'Calcular',
                      ),
                    ),
                  ),
                  Text(
                    _result,
                    style: const TextStyle(
                      color: Colors.lightGreen,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

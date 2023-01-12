import 'package:flutter/material.dart';
import 'package:imc_calculator/widgets/imc_text_field.dart';
import 'package:imc_calculator/widgets/refresh_button.dart';

import '../widgets/green_confirmation_button.dart';

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

  String? heightValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Insira sua altura';
    }
  }

  String? weightValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Insira seu peso';
    }
  }

  void validateForm() {
    if (_formKey.currentState!.validate()) {
      calculateImc();
    }
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
                  ImcTextField(
                    controller: weightController,
                    labelText: 'Peso (Kg)',
                    validatorFunction: weightValidator,
                  ),
                  ImcTextField(
                    controller: heightController,
                    labelText: 'Altura (cm)',
                    validatorFunction: heightValidator,
                  ),
                  GreenConfirmationButton(onPressedFunction: validateForm),
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

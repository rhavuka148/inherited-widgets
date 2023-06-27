import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final calculator = CalculatorModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: MyInherited(
              calculator: calculator,
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FirstTextField(),
                  SizedBox(height: 16),
                  SecondTextField(),
                  SizedBox(height: 16),
                  Button(),
                  Result()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FirstTextField extends StatelessWidget {
  const FirstTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final inherited = MyInherited.of(context);

    return TextField(
      onChanged: (value) => inherited?.calculator.setFirstNumber(value),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'First number',
      ),
    );
  }
}

class SecondTextField extends StatelessWidget {
  const SecondTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final inherited = MyInherited.of(context);

    return TextField(
      onChanged: (value) => inherited?.calculator.setSecondNumber(value),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Second number',
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({super.key});

  @override
  Widget build(BuildContext context) {
    final inherited = MyInherited.of(context);

    return ElevatedButton(
      onPressed: inherited?.calculator.sum,
      child: const Text(
        'Calculate',
        style: TextStyle(color: Colors.black, fontSize: 18),
      ),
    );
  }
}

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  String _result = '';

  @override
  void didChangeDependencies() {
    final inherited = MyInherited.of(context);

    inherited?.calculator.addListener(() {
      _result = '${inherited.calculator.result ?? 0}';

      if (_result != '0') {
        setState(() {});
      }
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Text(_result);
  }
}

class CalculatorModel extends ChangeNotifier {
  int? firstNumber;
  int? secondNumber;
  int? result;

  void setFirstNumber(String value) => firstNumber = int.tryParse(value);
  void setSecondNumber(String value) => secondNumber = int.tryParse(value);

  void sum() {
    if (firstNumber != null && secondNumber != null) {
      result = firstNumber! + secondNumber!;
    } else {
      result = null;
    }

    notifyListeners();
  }
}

class MyInherited extends InheritedWidget {
  final CalculatorModel calculator;

  const MyInherited({
    super.key,
    required super.child,
    required this.calculator,
  });

  static MyInherited? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<MyInherited>();

  @override
  bool updateShouldNotify(covariant MyInherited oldWidget) =>
      oldWidget.calculator != calculator;
}

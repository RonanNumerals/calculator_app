/*
  Assignment: Calculator App
  Author: Ronan Pelot
  Description: 
*/

import 'package:flutter/material.dart';

void main() {
  runApp(const CalcuatorApp());
}

class CalcuatorApp extends StatelessWidget {
  const CalcuatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData.dark(), home: HomePage(),);
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _operandOne = '';
  String _operandTwo = '';
  String _input = '';
  String _display = '';
  String _operator = '';
  bool _result = false;

  bool _operatorSelected = false;
  bool _decimalUsed = false;

  void _calculate() { 
      if (!_operatorSelected || _operandOne.isEmpty || _operandTwo.isEmpty) return;

      double num1 = double.parse(_operandOne);
      double num2 = double.parse(_operandTwo);

      double temp = 0.0;

      if (_operator == '+') {
        temp = num1 + num2;
      } else if (_operator == '-') {
        temp = num1 - num2;
      } else if (_operator == '*') {
        temp = num1 * num2;
      } else if (_operator == '÷') {
        temp = num1 / num2;
      }
      setState(() {
        _result = true;
        _input = temp.toString();
        _operandOne = '';
        _operandTwo = '';
        _operator = '';
        _operatorSelected = false;
        _decimalUsed = false;
      });
  }

  void selectOperator(String operator) {
    if (_operatorSelected || _input.isEmpty || _result) return;
    setState(() {
      _operandOne = _input;
      _operator = operator;
      _display = '$_display $operator ';
      _input = '';
      _operatorSelected = true;
      _decimalUsed = false;
    });
  }

  void numPressed(String num) {
    setState(() {
      if (_result) {
        _input = '';
        _display = '';
        _result = false;
      }
      _input = _input + num;
      _display = _display + num;
    });
  }

  void decPressed() {
    if (_decimalUsed) return;
    setState(() {
      if (_result) {
        _input = '';
        _display = '';
        _result = false;
      }
      _input = '$_input.';
      _display = '$_display.';
      _decimalUsed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 260,
              height: 100, 
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 33, 37, 63),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _display,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Color.fromARGB(255, 24, 129, 112),
                    ),
                    textAlign: TextAlign.right,
                  ),

                  if (_result) 
                    Text(
                      '= ${_input.toString()}',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 24, 129, 112),
                      ),
                      textAlign: TextAlign.right,
                    ),
                ],
              ),
            ),
            SizedBox(height: 24),
            SizedBox(
              width: 260,
              child: GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                children: [
                  ElevatedButton(
                    onPressed: () => numPressed('7'),
                    child: const Text('7'),
                  ),
                  ElevatedButton(
                    onPressed: () => numPressed('8'),
                    child: const Text('8'),
                  ),
                  ElevatedButton(
                    onPressed: () => numPressed('9'),
                    child: const Text('9'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 87, 23, 136),
                    ),
                    onPressed: () => selectOperator('÷'),
                    child: const Text('÷'),
                  ),

                  ElevatedButton(
                    onPressed: () => numPressed('4'),
                    child: const Text('4'),
                  ),
                  ElevatedButton(
                    onPressed: () => numPressed('5'),
                    child: const Text('5'),
                  ),
                  ElevatedButton(
                    onPressed: () => numPressed('6'),
                    child: const Text('6'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 87, 23, 136),
                    ),
                    onPressed: () => selectOperator('*'),
                    child: const Text('x'),
                  ),

                  ElevatedButton(
                    onPressed: () => numPressed('1'),
                    child: const Text('1'),
                  ),
                  ElevatedButton(
                    onPressed: () => numPressed('2'),
                    child: const Text('2'),
                  ),
                  ElevatedButton(
                    onPressed: () => numPressed('3'),
                    child: const Text('3'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 87, 23, 136),
                    ),
                    onPressed: () => selectOperator('-'),
                    child: const Text('-'),
                  ),

                  ElevatedButton(
                    onPressed: () => numPressed('0'),
                    child: const Text('0'),
                  ),
                  ElevatedButton(
                    onPressed: () => decPressed(),
                    child: const Text('.'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 87, 23, 136),
                    ),
                    onPressed: () {
                        if (_input.isEmpty) return;
                        _operandTwo = _input;
                        _calculate();
                    },
                    child: const Text('='),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 87, 23, 136),
                    ),
                    onPressed: () => selectOperator('+'),
                    child: const Text('+'),
                  ),
                ],
              ),
            ),
          ]
        )
      ),
    );
  }
}
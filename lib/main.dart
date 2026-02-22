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
    return MaterialApp(home: HomePage(),);
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
      } else if (_operator == '/') {
        temp = num1 / num2;
      }
      setState(() {
        _result = true;
        _input = temp.toString();
        _operandOne = '';
        _operandTwo = '';
        _operator = '';
        _operatorSelected = false;
      });
  }

  void selectOperator(String operator) {
    if (_operatorSelected || _input.isEmpty) return;
    setState(() {
      _operandOne = _input;
      _operator = operator;
      _input = '';
      _operatorSelected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 300, 
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
                    _input,
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => setState(() => _input = '${_input}7'),
                  child: const Text('7'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => setState(() => _input = '${_input}4'),
                  child: const Text('4'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => setState(() => _input = '${_input}1'),
                  child: const Text('1'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => setState(() => _input = '${_input}0'),
                  child: const Text('0'),
                ),
              ],
            ),
      
            const SizedBox(width: 12),
            Column (
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /*ElevatedButton(
                  onPressed: () => setState(() => _counter = 5),
                  child: const Text('+', style: TextStyle(decoration: TextDecoration.underline)),
                ),
                const SizedBox(height: 8),*/
                ElevatedButton(
                  onPressed: () => setState(() => _input = '${_input}8'),
                  child: const Text('8'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => setState(() => _input = '${_input}5'),
                  child: const Text('5'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => setState(() => _input = '${_input}2'),
                  child: const Text('2'),
                ),
              ],
            ),

            const SizedBox(width: 12),
            Column (
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /*ElevatedButton(
                  onPressed: () => setState(() => _counter = 1),
                  child: const Text('%'),
                ),
                const SizedBox(height: 8),*/
                ElevatedButton(
                  onPressed: () => setState(() => _input = '${_input}9'),
                  child: const Text('9'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => setState(() => _input = '${_input}6'),
                  child: const Text('6'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => setState(() => _input = '${_input}3'),
                  child: const Text('3'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => setState(() => _input = '${_input}.'),
                  child: const Text('.'),
                ),
              ],
            ),

            const SizedBox(width: 12),
            Column (
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => selectOperator('/'),
                  child: const Text('÷'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => selectOperator('*'),
                  child: const Text('x'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => selectOperator('-'),
                  child: const Text('-'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => selectOperator('+'),
                  child: const Text('+'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                      if (_input.isEmpty) return;

                      _operandTwo = _input;
                      _calculate();
                  },
                  child: const Text('='),
                ),
              ],
            ),
          ]
        ),
      ),
    );
  }
}
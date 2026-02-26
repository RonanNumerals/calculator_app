/*
  Assignment: Calculator App
  Author: Ronan Pelot
  Description: This is a simple calculator app complete with a number pad, basic arithmetic operations, and a display for the current input and results. 
               The app handles errors such as incomplete expressions and division by zero, providing feedback to the user. Functions include addition, subtraction, 
               multiplication, division, reset, and negation of the current input.
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
  // Here are my variables to store the operands, operator, and display text. I also have boolean variables to track if a result has been calculated or if there's an error, and if an operator has been selected.
  String _operandOne = '';
  String _operandTwo = '';
  String _input = '';
  String _display = '';
  String _operator = '';
  bool _result = false;
  bool _error = false;
  bool _operatorSelected = false;

  // This function performs the calculation based on the selected operator and operands. It also handles errors such as incomplete expressions and division by zero, updating the display accordingly.
  void _calculate() {
    // Check if an operator has been selected and if both operands are present. If not, display an error message and reset the state.
      if (!_operatorSelected || _operandOne.isEmpty || _input.isEmpty) {
        setState(() {
            _display = 'Error: Incomplete expression';
            _error = true;
            _operandOne = '';
            _operandTwo = '';
            _operator = '';
            _operatorSelected = false;
          });
        return;
      }

      _operandTwo = _input;

      double num1 = double.parse(_operandOne);
      double num2 = double.parse(_operandTwo);

      // If the operator is division and the second operand is zero, display an error message and reset the state.
      if (_operator == '÷' && num2 == 0) {
        setState(() {
          _display = 'Error: Division by zero';
          _error = true;
          _operandOne = '';
          _operandTwo = '';
          _operator = '';
          _operatorSelected = false;
        });
        return;
      }

      double temp = 0.0;

      // Perform the calculation based on the selected operator.
      if (_operator == '+') {
        temp = num1 + num2;
      } else if (_operator == '-') {
        temp = num1 - num2;
      } else if (_operator == '*') {
        temp = num1 * num2;
      } else if (_operator == '÷') {
        temp = num1 / num2;
      }

      String resultString;

      // Format the result to remove unnecessary decimal places. If the result is an integer, display it without decimal places. Otherwise, display it with up to 8 decimal places, removing trailing zeros.
      if (temp % 1 == 0) {
        resultString = temp.toInt().toString();
      } else {
        resultString = temp.toStringAsFixed(8).replaceFirst(RegExp(r'0+$'), '').replaceFirst(RegExp(r'\.$'), '');
      }

      // Update the state to display the result and reset the operands and operator for the next calculation.
      setState(() {
        _result = true;
        _input = resultString;
        _operandOne = '';
        _operandTwo = '';
        _operator = '';
        _operatorSelected = false;
      });
  }

  // This function is called when an operator button is pressed. It checks if an operator has already been selected or if the input is empty, and if so, it does nothing. Otherwise, it updates the state to store the first operand, the selected operator, and prepares for the second operand input.
  void selectOperator(String operator) {
    // If an operator has already been selected, if the input is empty, or if a result has just been calculated, do nothing.
    if (_operatorSelected || _input.isEmpty || _result) return;
    // Update the state to store the first operand, the selected operator, and prepare for the second operand input.
    setState(() {
      _operandOne = _input;
      _operator = operator;
      _display = '$_display $operator ';
      _input = '';
      _operatorSelected = true;
    });
  }

  // This function is called when a number button is pressed. It checks if a result has just been calculated or if there's an error, and if so, it resets the input and display. Then it appends the pressed number to the current input and updates the display accordingly.
  void numPressed(String num) {
    setState(() {
      // If a result has just been calculated or if there's an error, reset the input and display before appending the new number.
      if (_result || _error) {
        _input = '';
        _display = '';
        _result = false;
        _error = false;
      }
      _input += num;
      _display += num;
    });
  }

  // This function is called when the clear button is pressed. It resets all the state variables to their initial values, effectively clearing the calculator for a new calculation.
  void clear(){
    setState(() {
      _operandOne = '';
      _operandTwo = '';
      _input = '';
      _display = '';
      _operator = '';
      _result = false;
      _error = false;
      _operatorSelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // This is the display area of the calculator. It shows the current input and, if a result has been calculated, it also shows the result below the input. The display is styled with a dark background and colored text for better visibility.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                height: 160, 
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 33, 37, 63),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // The current input is displayed in a large font size, aligned to the right. If the input exceeds the width of the display, it can be scrolled horizontally.
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        reverse: true,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            _display,
                            style: const TextStyle(
                              fontSize: 56,
                              color: Color.fromARGB(255, 24, 129, 112),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // If a result has been calculated, it is displayed below the input in a slightly smaller font size. It is also aligned to the right and can be scrolled horizontally if it exceeds the width of the display.
                    if (_result) 
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        reverse: true,
                        child: Text(
                          '= $_input',
                          style: const TextStyle(
                            fontSize: 40,
                            color: Color.fromARGB(255, 24, 129, 112),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // This is the grid of buttons for the calculator. It includes number buttons, operator buttons, a clear button, and a button to toggle the sign of the current input.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: [
                  // The first row of buttons includes a clear button, a sign toggle button, and the division operator. 
                  //The clear button resets the calculator, while the sign toggle button negates the current input. 
                  //The division operator allows the user to perform division operations.
                  Container(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 87, 23, 136),
                    ),
                    onPressed: () => clear(),
                    child: const Text('C'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 87, 23, 136),
                    ),
                    onPressed: () {
                      if (_input.isEmpty || _result || _error) return;

                      setState(() {
                        // Try to parse the current input as a double. If it fails, return without doing anything.
                        double? value = double.tryParse(_input);
                        if (value == null) return;

                        String originalInput = _input;

                        value = -value;

                        // Format the negated value to remove unnecessary decimal places. If the value is an integer, display it without decimal places. Otherwise, display it with up to 8 decimal places, removing trailing zeros.
                        if (value % 1 == 0) {
                          _input = value.toInt().toString();
                        } else {
                          _input = value.toString();
                        }

                        // If the negated value is -0, change it to 0 to avoid displaying negative zero.
                        if (_input == "-0") {
                          _input = "0";
                        }
                        // Update the display by replacing the original input with the negated value. This ensures that the display reflects the change in sign without affecting any other parts of the expression.
                        _display = _display.substring(0, _display.length - originalInput.length) + _input;
                      });
                    },
                    child: const Text('±'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 87, 23, 136),
                    ),
                    onPressed: () => selectOperator('÷'),
                    child: const Text('÷'),
                  ),

                  // This row includes the number buttons for 7, 8, and 9, as well as the multiplication operator. 
                  // The number buttons append their respective numbers to the current input when pressed, while the multiplication operator allows the user to perform multiplication operations.
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
                    onPressed: () => selectOperator('*'),
                    child: const Text('*'),
                  ),

                  // This row includes the number buttons for 4, 5, and 6, as well as the addition operator. 
                  // The number buttons append their respective numbers to the current input when pressed, while the addition operator allows the user to perform addition operations.
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
                    onPressed: () => selectOperator('+'),
                    child: const Text('+'),
                  ),

                  // This row includes the number buttons for 1, 2, and 3, as well as the subtraction operator. 
                  // The number buttons append their respective numbers to the current input when pressed, while the subtraction operator allows the user to perform subtraction operations.
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
                  
                  // The last row includes a placeholder container, the number button for 0, another placeholder container, and the equals button. 
                  // The number button for 0 appends '0' to the current input when pressed, while the equals button triggers the calculation of the current expression and displays the result.
                  Container(),
                  ElevatedButton(
                    onPressed: () => numPressed('0'),
                    child: const Text('0'),
                  ),
                  Container(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 87, 23, 136),
                    ),
                    onPressed: () {
                        _calculate();
                    },
                    child: const Text('='),
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
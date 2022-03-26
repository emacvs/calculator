import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_grid_button/flutter_grid_button.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class ButtonOperator {
  String operator;
  ButtonOperator(this.operator);
}

class ButtonNumber {
  String value;
  ButtonNumber(this.value);
}

class GridButtonItemCustom extends GridButtonItem {
  static getCorrectValue(value, isOperator, isNumber, other) {
    if (value is ButtonOperator) {
      return isOperator;
    } else if (value is ButtonNumber) {
      return isNumber;
    } else {
      return other;
    }
  }

  GridButtonItemCustom(dynamic value)
      : super(
          title: value is ButtonOperator
              ? value.operator
              : value is ButtonNumber
                  ? value.value
                  : "",
          value: value,
          borderRadius: 1000,
          textStyle: TextStyle(
              color: Colors.black, fontSize: 37, package: "", fontFamily: ""),
          color: getCorrectValue(value, Colors.amber, Colors.grey, null),
        );
}

class GridButtonNumber extends GridButtonItemCustom {
  GridButtonNumber(String number) : super(ButtonNumber(number));
}

class GridButtonOperator extends GridButtonItemCustom {
  GridButtonOperator(String operator) : super(ButtonOperator(operator));
}

class _HomeState extends State<Home> {
  double _total = 0;
  String _display = "";
  String _buffer = "";
  String _operator = "";

  String _removeTrailingZero(double n) {
    RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
    return n.toString().replaceAll(regex, '');
  }

  void _setOperator(String operator) {
    setState(() {
      if (_buffer != "") {
        switch (_operator) {
          case "":
            _total = double.parse(_buffer);
            break;
          case "+":
            _total += double.parse(_buffer);
            break;
          case "-":
            _total -= double.parse(_buffer);
            break;
          case "x":
            _total *= double.parse(_buffer);
            break;
          case ":":
            _total /= double.parse(_buffer);
            break;
        }
      }

      if (operator == "=") {
        if (_operator == "") {
          _total = 0;
        } else {
          _operator = "";
        }
      } else {
        _operator = operator;
      }

      _display = _removeTrailingZero(_total) + " " + _operator;
      _buffer = "";
    });
  }

  void _numberPressed(String operand) {
    setState(() {
      if ((operand == "." && _buffer != "") || operand != ".") {
        _buffer += operand;
      }
      _display = _buffer;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  _display.toString(),
                  style: TextStyle(fontSize: 80, color: Colors.white),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: SizedBox(
              height: 400,
              child: GridButton(
                hideSurroundingBorder: false,
                borderColor: Colors.black,
                borderWidth: 10,
                onPressed: (dynamic button) {
                  if (button is ButtonOperator) {
                    _setOperator(button.operator);
                  } else if (button is ButtonNumber) {
                    _numberPressed(button.value);
                  }
                },
                items: [
                  [
                    GridButtonNumber("7"),
                    GridButtonNumber("8"),
                    GridButtonNumber("9"),
                    GridButtonOperator("x"),
                  ],
                  [
                    GridButtonNumber("4"),
                    GridButtonNumber("5"),
                    GridButtonNumber("6"),
                    GridButtonOperator("-"),
                  ],
                  [
                    GridButtonNumber("1"),
                    GridButtonNumber("2"),
                    GridButtonNumber("3"),
                    GridButtonOperator("+"),
                  ],
                  [
                    GridButtonNumber("0"),
                    GridButtonNumber("."),
                    GridButtonOperator("="),
                    GridButtonOperator(":"),
                  ],
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

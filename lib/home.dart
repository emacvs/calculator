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

class ButtonOperand {
  String operator;
  ButtonOperand({required this.operator});
}

class ButtonNumber {
  double value;
  ButtonNumber({required this.value});
}

class _HomeState extends State<Home> {
  static const double radius = 10;
  double _total = 0;
  String _display = "0";
  String _operator = "+";

  void _setOperator(ButtonOperand operator) {
    setState(() {
      _operator = operator.operator;
    });
  }

  void _operation(ButtonNumber operand) {
    setState(() {
      _display = operand.value.toString();
      switch (_operator) {
        case "+":
          _total += operand.value;
      }
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
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: Center(
              child: Text(
                _display.toString() + " " + _operator,
                style: TextStyle(fontSize: 40),
              ),
            ),
          ),
          Expanded(
            child: GridButton(
              onPressed: (dynamic val) {
                log(val.toString());
                if (val is ButtonOperand) {
                  _setOperator(val);
                } else if (val is ButtonNumber) {
                  _operation(val);
                }
              },
              items: [
                [
                  GridButtonItem(
                      borderRadius: radius,
                      title: "7",
                      value: ButtonNumber(value: 7)),
                  GridButtonItem(
                      borderRadius: radius,
                      title: "8",
                      value: ButtonNumber(value: 8)),
                  GridButtonItem(
                      borderRadius: radius,
                      title: "9",
                      value: ButtonNumber(value: 9)),
                  GridButtonItem(
                    borderRadius: radius,
                    title: "×",
                    value: ButtonOperand(operator: "*"),
                    color: Colors.grey[300],
                  )
                ],
                [
                  GridButtonItem(
                      borderRadius: radius,
                      title: "4",
                      value: ButtonNumber(value: 4)),
                  GridButtonItem(
                      borderRadius: radius,
                      title: "5",
                      value: ButtonNumber(value: 5)),
                  GridButtonItem(
                      borderRadius: radius,
                      title: "6",
                      value: ButtonNumber(value: 6)),
                  GridButtonItem(
                      borderRadius: radius,
                      title: "-",
                      value: ButtonOperand(operator: "-"),
                      color: Colors.grey[300]),
                ],
                [
                  GridButtonItem(
                      borderRadius: radius,
                      title: "1",
                      value: ButtonNumber(value: 1)),
                  GridButtonItem(
                      borderRadius: radius,
                      title: "2",
                      value: ButtonNumber(value: 2)),
                  GridButtonItem(
                      borderRadius: radius,
                      title: "3",
                      value: ButtonNumber(value: 3)),
                  GridButtonItem(
                      borderRadius: radius,
                      title: "+",
                      value: ButtonOperand(operator: "+"),
                      color: Colors.grey[300]),
                ],
                [
                  GridButtonItem(
                      borderRadius: radius,
                      title: "0",
                      flex: 3,
                      value: ButtonNumber(value: 0)),
                  GridButtonItem(
                      borderRadius: radius,
                      title: "=",
                      value: ButtonOperand(operator: "="),
                      color: Colors.grey[300]),
                ],
              ],
            ),
          )
        ],
      ),
    );
  }
}

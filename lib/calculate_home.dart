import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculateHome extends StatefulWidget {
  const CalculateHome({Key? key}) : super(key: key);

  @override
  _CalculateHomeState createState() => _CalculateHomeState();
}

class _CalculateHomeState extends State<CalculateHome> {
  String equation = '0';
  String result = '0';
  String expression = '';
  double equationSize = 35;
  double resultSize = 45;

  onPressed(String textButton) {
    setState(() {
      if (textButton == 'C') {
        equation = '0';
        result = '0';
        equationSize = 35;
        resultSize = 45;
      } else if (textButton == '←') {
        equationSize = 45;
        resultSize = 35;
        equation = equation.substring(0, equation.length - 1);
        if (equation == '') {
          equation = '0';
        }
      } else if (textButton == '=') {
        equationSize = 35;
        resultSize = 45;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('%', '1/100');


        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();

          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = 'Error';
        }
      } else if (textButton == 'mc') {
      } else if (textButton == 'm+') {
      } else if (textButton == 'm-') {
      } else if (textButton == 'mr') {
      } else {
        equationSize = 45;
        resultSize = 35;
        if (equation == '0') {
          equation = textButton;
        } else {
          equation = equation + textButton;
        }
      }
    });
  }

  Widget newButton(double buttonHeight, Color boxColor, String textButton,
      Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: boxColor,
      child: TextButton(
        onPressed: () => onPressed(textButton),
        child: Text(textButton,
            style: TextStyle(fontSize: 30, color: buttonColor)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Column(children: [
                Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(equation,
                        style: TextStyle(fontSize: equationSize))),
                Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child:
                        Text(result, style: TextStyle(fontSize: resultSize))),
              ]),
            ),
            Expanded(
              flex: 2,
              child: Table(
                border: TableBorder.all(color: const Color(0xFFEBEBEB)),
                children: [
                  TableRow(
                    children: [
                      newButton(1, const Color(0xFFF5F5F5), 'mc', Colors.grey),
                      newButton(1, const Color(0xFFF5F5F5), 'm+', Colors.grey),
                      newButton(1, const Color(0xFFF5F5F5), 'm-', Colors.grey),
                      newButton(1, const Color(0xFFF5F5F5), 'mr', Colors.grey),
                    ],
                  ),
                  TableRow(
                    children: [
                      newButton(1, const Color(0xFFF5F5F5), 'C', Colors.blue),
                      newButton(1, const Color(0xFFF5F5F5), '←', Colors.blue),
                      newButton(1, const Color(0xFFF5F5F5), '√', Colors.blue),
                      newButton(1, const Color(0xFFF5F5F5), '×', Colors.blue),
                    ],
                  ),
                  TableRow(
                    children: [
                      newButton(1, Colors.white, '7', Colors.black),
                      newButton(1, Colors.white, '8', Colors.black),
                      newButton(1, Colors.white, '9', Colors.black),
                      newButton(1, const Color(0xFFF5F5F5), '÷', Colors.blue),
                    ],
                  ),
                  TableRow(
                    children: [
                      newButton(1, Colors.white, '4', Colors.black),
                      newButton(1, Colors.white, '5', Colors.black),
                      newButton(1, Colors.white, '6', Colors.black),
                      newButton(1, const Color(0xFFF5F5F5), '-', Colors.blue),
                    ],
                  ),
                  TableRow(
                    children: [
                      newButton(1, Colors.white, '1', Colors.black),
                      newButton(1, Colors.white, '2', Colors.black),
                      newButton(1, Colors.white, '3', Colors.black),
                      newButton(1, const Color(0xFFF5F5F5), '+', Colors.blue),
                    ],
                  ),
                  TableRow(
                    children: [
                      newButton(1, Colors.white, '%', Colors.black),
                      newButton(1, Colors.white, '0', Colors.black),
                      newButton(1, Colors.white, '.', Colors.black),
                      newButton(1, Colors.blue, '=', Colors.white),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

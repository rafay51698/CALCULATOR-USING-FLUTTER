import 'dart:ui';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Calculator());
  }
}

class Calculator extends StatefulWidget {
  

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  Widget calcbutton(String btntxt, Color btncolor, Color txtcolor) {
    return Container(
      child:  RaisedButton(
          onPressed: () {
            calculation(btntxt);
            setState(() {
              text = finalResult;
            });
          },
          child: Text(
            btntxt,
            style: TextStyle(
              fontSize: 35,
              color: txtcolor,
            ),
          ),
          shape: CircleBorder(),
          color: btncolor,
          padding: EdgeInsets.all(20),
        ),
      
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        title: Center(child: Text("Calculator")),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 120),
                        child: Text(
                          text,
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.white, fontSize: 80),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcbutton("AC", Colors.grey, Colors.white),
                calcbutton("+/-", Colors.grey, Colors.white),
                calcbutton("%", Colors.grey, Colors.white),
                calcbutton("/", Colors.amber, Colors.black),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcbutton("7", Colors.blueGrey, Colors.black),
                calcbutton("8", Colors.blueGrey, Colors.black),
                calcbutton("9", Colors.blueGrey, Colors.black),
                calcbutton("x", Colors.amber, Colors.black),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcbutton("4", Colors.blueGrey, Colors.black),
                calcbutton("5", Colors.blueGrey, Colors.black),
                calcbutton("6", Colors.blueGrey, Colors.black),
                calcbutton("-", Colors.amber, Colors.black),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcbutton("1", Colors.blueGrey, Colors.black),
                calcbutton("2", Colors.blueGrey, Colors.black),
                calcbutton("3", Colors.blueGrey, Colors.black),
                calcbutton("+", Colors.amber, Colors.black),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  onPressed: () {},
                  shape: StadiumBorder(),
                  padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
                  child: Center(
                    child: Text(
                      "0",
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  color: Colors.blueGrey,
                ),
                calcbutton(".", Colors.blueGrey, Colors.black),
                calcbutton("=", Colors.amber, Colors.black),
              ],
            )
          ],
        ),
      ),
    );
  }
}

dynamic text = '0';
double numOne = 0;
double numTwo = 0;

dynamic result = '';
dynamic finalResult = '';
dynamic opr = '';
dynamic preOpr = '';
void calculation(btnText) {
  if (btnText == 'AC') {
    text = '0';
    numOne = 0;
    numTwo = 0;
    result = '';
    finalResult = '0';
    opr = '';
    preOpr = '';
  } else if (opr == '=' && btnText == '=') {
    if (preOpr == '+') {
      finalResult = add();
    } else if (preOpr == '-') {
      finalResult = sub();
    } else if (preOpr == 'x') {
      finalResult = mul();
    } else if (preOpr == '/') {
      finalResult = div();
    }
  } else if (btnText == '+' ||
      btnText == '-' ||
      btnText == 'x' ||
      btnText == '/' ||
      btnText == '=') {
    if (numOne == 0) {
      numOne = double.parse(result);
    } else {
      numTwo = double.parse(result);
    }

    if (opr == '+') {
      finalResult = add();
    } else if (opr == '-') {
      finalResult = sub();
    } else if (opr == 'x') {
      finalResult = mul();
    } else if (opr == '/') {
      finalResult = div();
    }
    preOpr = opr;
    opr = btnText;
    result = '';
  } else if (btnText == '%') {
    result = numOne / 100;
    finalResult = doesContainDecimal(result);
  } else if (btnText == '.') {
    if (!result.toString().contains('.')) {
      result = result.toString() + '.';
    }
    finalResult = result;
  } else if (btnText == '+/-') {
    result.toString().startsWith('-')
        ? result = result.toString().substring(1)
        : result = '-' + result.toString();
    finalResult = result;
  } else {
    result = result + btnText;
    finalResult = result;
  }
}

String add() {
  result = (numOne + numTwo).toString();
  numOne = double.parse(result);
  return doesContainDecimal(result);
}

String sub() {
  result = (numOne - numTwo).toString();
  numOne = double.parse(result);
  return doesContainDecimal(result);
}

String mul() {
  result = (numOne * numTwo).toString();
  numOne = double.parse(result);
  return doesContainDecimal(result);
}

String div() {
  result = (numOne / numTwo).toString();
  numOne = double.parse(result);
  return doesContainDecimal(result);
}

String doesContainDecimal(dynamic result) {
  if (result.toString().contains('.')) {
    List<String> splitDecimal = result.toString().split('.');
    if (!(int.parse(splitDecimal[1]) > 0))
      return result = splitDecimal[0].toString();
  }
  return result;
}

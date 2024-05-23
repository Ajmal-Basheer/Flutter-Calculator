
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class calculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => calculatorState();
}
class calculatorState extends State {
  Color darkColor = Colors.grey;
  Color lightColor = Colors.yellow.shade800;

  String number1 = "";
  String number2 = "";
  String operator = "";

  Widget buildButton(String buttonText, Color color) {
    return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(24.0),
              primary: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0),
              ),
              elevation: 5,
              textStyle: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () => btnTap(buttonText),
            child: Text(buttonText, style: TextStyle(color: Colors.black),),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenHight = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(right: 20),
              alignment: Alignment.bottomRight,
              height: screenHight / 2.5,
              width: screenWidth,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Text('${numOne} ${opr} ${numTwo}',style: TextStyle(fontSize: 20,color: Colors.white54),),
                    Text("$number1$operator$number2".isEmpty
                        ? '0'
                        : "$number1$operator$number2",
                      style: TextStyle(fontSize: 80, color: Colors.white),),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
                      buildButton('C', lightColor),
                      buildButton('%', lightColor),
                      buildButton('⌫', lightColor),
                      buildButton('÷', lightColor),
                    ],
                  ), Row(
                    children: <Widget>[
                      buildButton('7', darkColor),
                      buildButton('8', darkColor),
                      buildButton('9', darkColor),
                      buildButton('x', lightColor),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      buildButton('4', darkColor),
                      buildButton('5', darkColor),
                      buildButton('6', darkColor),
                      buildButton('-', lightColor),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      buildButton('1', darkColor),
                      buildButton('2', darkColor),
                      buildButton('3', darkColor),
                      buildButton('+', lightColor),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      buildButton('00', darkColor),
                      buildButton('0', darkColor),
                      buildButton('.', darkColor),
                      buildButton('=', lightColor),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void btnTap(String btnText) {
    if (btnText == '⌫') {
      backspace();
      return;
    }
    if (btnText == "C") {
      clear();
      return;
    }
    if(btnText == '%'){
      convertToPer();
      return;
    }
    if(btnText == "="){
      calculate();
      return;
    }
    AppendValues(btnText);
  }

  void calculate(){
    if(number1.isEmpty && number2.isEmpty && operator.isEmpty) return;
    double numb1 = double.parse(number1);
    double numb2 = double.parse(number2);
    var result = 0.0;
    switch (operator){
      case '+' :
        result = numb1 + numb2;
        break;
      case '-' :
        result = numb1 - numb2;
        break;
      case 'x' :
        result = numb1 * numb2;
        break;
      case '÷' :
        result = numb1 / numb2;
        break;
      default:
    }
    setState(() {
      number1 = "$result";

      if(number1.endsWith('.0')){
        number1 = number1.substring(0,number1.length-2);
      }
      number2 = "";
      operator = '';
    });
  }

  void convertToPer(){
    if(number1.isNotEmpty&&number2.isNotEmpty&&operator.isNotEmpty){
      calculate();
    }
    if(operator.isNotEmpty){
      return;
    }
    final number = double.parse(number1);
    setState(() {
      number1 = '${number / 100}';
      operator = "";
      number2 = "";
    });
  }

  void backspace() {
    if (number2.isNotEmpty) {
      number2 = number2.substring(0, number2.length - 1);
    } else if (operator.isNotEmpty) {
      operator = "";
    } else if (number1.isNotEmpty) {
      number1 = number1.substring(0, number1.length - 1);
    }
    setState(() {});
  }

  void clear() {
    setState(() {
      number1 = '';
      operator = '';
      number2 = '';
    });
  }

  void AppendValues(btnText) {
    //if is operator or not '.'
    if (btnText != '.' && int.tryParse(btnText) == null) {
      //if operator pressed
      if (operator.isNotEmpty && number2.isNotEmpty) {
        //calculate the equation before assigning new value
        calculate();
      }
      operator = btnText;
    }
    //assign to number1 variable
    else if (number1.isEmpty || operator.isEmpty) {
      //check value is '.'
      //eg : number1 = '1.0'
      if (btnText == '.' && number1.contains('.')) return;
      if (btnText == '.' && (number1.isEmpty || number1 == '.')) {
        //eg : number 1 '' || "0"
        btnText = '0.';
      }
      number1 += btnText;
    }
    //assign to number2 variable
    else if (number2.isEmpty || operator.isNotEmpty) {
      //eg : number2 = '1.0'
      if (btnText == '.' && number2.contains('.')) return;
      if (btnText == '.' && (number2.isEmpty || number2 == '.')) {
        //eg : number 2  '' || "0"
        btnText = '0.';
      }
      number2 += btnText;
    }

    setState(() {});
  }
}